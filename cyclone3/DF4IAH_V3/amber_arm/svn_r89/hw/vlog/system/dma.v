//////////////////////////////////////////////////////////////////
//                                                              //
//  DMA controller                                              //
//                                                              //
//  This file is part of the Amber project                      //
//  http://www.opencores.org/project,amber                      //
//                                                              //
//  Description                                                 //
//  DMA controller that copies data between memory addresses.   //
//                                                              //
//  Author(s):                                                  //
//      - Ulrich Habel, espero7757 at gmx.net                   //
//                                                              //
//////////////////////////////////////////////////////////////////
//                                                              //
// Copyright (C) 2015 Authors and OPENCORES.ORG                 //
//                                                              //
// This source file may be used and distributed without         //
// restriction provided that this copyright statement is not    //
// removed from the file and that any derivative work contains  //
// the original copyright notice and the associated disclaimer. //
//                                                              //
// This source file is free software; you can redistribute it   //
// and/or modify it under the terms of the GNU Lesser General   //
// Public License as published by the Free Software Foundation; //
// either version 2.1 of the License, or (at your option) any   //
// later version.                                               //
//                                                              //
// This source is distributed in the hope that it will be       //
// useful, but WITHOUT ANY WARRANTY; without even the implied   //
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      //
// PURPOSE.  See the GNU Lesser General Public License for more //
// details.                                                     //
//                                                              //
// You should have received a copy of the GNU Lesser General    //
// Public License along with this source; if not, download it   //
// from http://www.opencores.org/lgpl.shtml                     //
//                                                              //
//////////////////////////////////////////////////////////////////
`include "../tb/global_defines.vh"
`include "system_config_defines.vh"

module dma  #(
parameter WB_DWIDTH  = 32,
parameter WB_SWIDTH  = 4
)(
input                       i_clk,
input                       i_sys_rst,

// WISHBONE SLAVE
input       [31:0]          i_s_wb_adr,
input       [WB_SWIDTH-1:0] i_s_wb_sel,
input                       i_s_wb_we,
output      [WB_DWIDTH-1:0] o_s_wb_dat,
input       [WB_DWIDTH-1:0] i_s_wb_dat,
input                       i_s_wb_cyc,
input                       i_s_wb_stb,
output                      o_s_wb_ack,
output                      o_s_wb_err,

// WISHBONE MASTER
output reg  [31:0]          o_m_wb_adr,
output reg  [WB_SWIDTH-1:0] o_m_wb_sel,
output reg                  o_m_wb_we,
input       [WB_DWIDTH-1:0] i_m_wb_dat,
output reg  [WB_DWIDTH-1:0] o_m_wb_dat,
output reg                  o_m_wb_cyc,
output reg                  o_m_wb_stb,
input                       i_m_wb_ack,
input                       i_m_wb_err

);


`include "memory_configuration.vh"
`include "register_addresses.vh"

// Wishbone registers
reg  [31:0]     src_start_reg       = 'd0;        // initial address of source block
reg  [31:0]     dst_start_reg       = 'd0;        // initial address of destination block
reg  [15:0]     block_len_reg       = 'd0;        // block copy length
reg             dma_block_reg       = 'd0;        // blocking access for complete transfer by holding the wishbone cycle signal

// Wishbone slave interface
reg  [31:0]     wb_s_rdata32        = 'd0;
wire            wb_s_start_write;
wire            wb_s_start_read;
reg             wb_s_start_read_d1  = 'd0;
wire [31:0]     wb_s_wdata32;


// ======================================================
// Wishbone Interface
// ======================================================

// Can't start a write while a read is completing. The ack for the read cycle
// needs to be sent first
assign wb_s_start_write = i_s_wb_stb &&  i_s_wb_we && !wb_s_start_read_d1;
assign wb_s_start_read  = i_s_wb_stb && !i_s_wb_we && !o_s_wb_ack;

always @( posedge i_clk )
    if ( i_sys_rst )
        wb_s_start_read_d1 <= 'd0;
    else
        wb_s_start_read_d1 <= wb_s_start_read;


assign o_s_wb_err = 1'd0;
assign o_s_wb_ack = i_s_wb_stb && ( wb_s_start_write || wb_s_start_read_d1 );

generate
if (WB_DWIDTH == 128) 
    begin : wb128
    assign wb_s_wdata32 = i_s_wb_adr[3:2] == 2'd3 ? i_s_wb_dat[127:96] :
                          i_s_wb_adr[3:2] == 2'd2 ? i_s_wb_dat[ 95:64] :
                          i_s_wb_adr[3:2] == 2'd1 ? i_s_wb_dat[ 63:32] :
                                                    i_s_wb_dat[ 31: 0] ;
                                                                                                                                            
    assign o_s_wb_dat   = {4{wb_s_rdata32}};
    end
else
    begin : wb32
    assign wb_s_wdata32 = i_s_wb_dat;
    assign o_s_wb_dat   = wb_s_rdata32;
    end
endgenerate


// -------------------------------
// for Master FSM
// -------------------------------
localparam MASTER_INIT                      = 2'd0;
localparam MASTER_READY                     = 2'd1;
localparam MASTER_RUN                       = 2'd2;
localparam MASTER_END                       = 2'd3;
reg  [1:0]              fsm_master          = 2'd0;

// -------------------------------
// for PullPush FSM
// -------------------------------
localparam PP_INIT                          = 4'd0;
localparam PP_PRELOAD                       = 4'd1;
localparam PP_READY                         = 4'd2;
localparam PP_BEGIN                         = 4'd3;
localparam PP_MAIL11                        = 4'd4;
localparam PP_MAIL12                        = 4'd5;
localparam PP_MAIL13                        = 4'd6;
localparam PP_MIDDLE                        = 4'd7;
localparam PP_MAIL21                        = 4'd8;
localparam PP_MAIL22                        = 4'd9;
localparam PP_MAIL23                        = 4'd10;
localparam PP_LAST                          = 4'd11;
localparam PP_MAIL31                        = 4'd12;
localparam PP_MAIL32                        = 4'd13;

reg  [3:0]              fsm_pp              = 'd0;
reg  [31:0]             pp_src_ptr          = 'd0;
reg  [31:0]             pp_dst_ptr          = 'd0;
reg  [3:0]              pp_sel_r            = 'd0;
reg  [WB_DWIDTH-1:0]    pp_data             = 'd0;
reg                     pp_dma_block        = 'd0;

integer                 pp_remain_int       =   0;
wire [15:0]             pp_remain;
assign pp_remain = pp_remain_int[15:0];

wire [3:0]              sel_nxt;
assign sel_nxt = (pp_remain > 3) ?  (4'b1111 << (pp_src_ptr & 2'b11) & 4'b1111) :
                                    (4'b1111 << (pp_src_ptr & 2'b11) & 4'b1111 & (4'b1111 >> (4 - pp_remain)));


// ========================================================
// Register Writes
// ========================================================
always @( posedge i_clk )
    begin
    if ( i_sys_rst )
        begin
        src_start_reg    <= 'd0;
        dst_start_reg    <= 'd0;
        block_len_reg    <= 'd0;
        end
    else if ( wb_s_start_write )
        case ( i_s_wb_adr[15:0] )
            // write to timer control registers
            AMBER_DMA_START0: src_start_reg  <= wb_s_wdata32[31:0];
            AMBER_DMA_START1: dst_start_reg  <= wb_s_wdata32[31:0];
            AMBER_DMA_LENGTH: block_len_reg  <= wb_s_wdata32[15:0];
            AMBER_DMA_BLOCK:  dma_block_reg  <= wb_s_wdata32[0];
        endcase
    end

// ========================================================
// Register Reads
// ========================================================
always @( posedge i_clk )
    if ( i_sys_rst )
        wb_s_rdata32    <= 'd0;
    else if ( wb_s_start_read )
        case ( i_s_wb_adr[15:0] )
            AMBER_DMA_START0:   wb_s_rdata32 <= src_start_reg;
            AMBER_DMA_START1:   wb_s_rdata32 <= dst_start_reg;
            AMBER_DMA_LENGTH:   wb_s_rdata32 <= {16'd0, block_len_reg};
            AMBER_DMA_BLOCK:    wb_s_rdata32 <= {31'd0, dma_block_reg};
            AMBER_DMA_CUR0:     wb_s_rdata32 <= pp_src_ptr;
            AMBER_DMA_CUR1:     wb_s_rdata32 <= pp_dst_ptr;
            AMBER_DMA_REMAIN:   wb_s_rdata32 <= {16'd0, pp_remain};

            default:            wb_s_rdata32 <= 32'hdeadbeef;
        endcase


// ===============================
// Master FSM
// ===============================
always @( posedge i_clk )
    begin
    if ( i_sys_rst )
        begin
        fsm_master  <= MASTER_INIT;
        end
    else
        case ( fsm_master )
            MASTER_INIT:
                begin
                if (fsm_pp == PP_PRELOAD)               // preload boot_mem with ConfigData
                    fsm_master      <= MASTER_END;
                end
            
            MASTER_READY:
                begin
                if (wb_s_start_write && (wb_s_wdata32 == AMBER_DMA_LENGTH) && (block_len_reg != 0))
                    begin
                    fsm_master      <= MASTER_RUN;
                    end
                end

            MASTER_RUN:
                fsm_master          <= MASTER_END;

            MASTER_END:
                if (fsm_pp == PP_READY)
                    fsm_master      <= MASTER_READY;

            default:
                fsm_master          <= MASTER_READY;
        endcase
    end


// ===============================
// PullPush FSM
// ===============================
always @( posedge i_clk )
    begin
    if ( i_sys_rst )
        begin
        pp_dma_block    <= 'd0;
        pp_src_ptr      <= 'd0;
        pp_dst_ptr      <= 'd0;
        pp_remain_int   <=   0;
        pp_sel_r        <= 'd0;
        pp_data         <= 'd0;
        o_m_wb_adr      <= 'd0;
        o_m_wb_sel      <= 'd0;
        o_m_wb_we       <= 'd0;
        o_m_wb_dat      <= 'd0;
        o_m_wb_cyc      <= 'd0;
        o_m_wb_stb      <= 'd0;
        fsm_pp          <= PP_INIT;
        end
    else
        case ( fsm_pp )
            PP_INIT:
                begin
                pp_dma_block    <= 'd0;
                pp_src_ptr      <= 'd0;
                pp_dst_ptr      <= 'd0;
                pp_remain_int   <=   0;
                pp_sel_r        <= 'd0;
                pp_data         <= 'd0;
                o_m_wb_adr      <= 'd0;
                o_m_wb_sel      <= 'd0;
                o_m_wb_we       <= 'd0;
                o_m_wb_dat      <= 'd0;
                o_m_wb_cyc      <= 'd0;
                o_m_wb_stb      <= 'd0;
                fsm_pp          <= PP_PRELOAD;
                end

            PP_PRELOAD:
                if (fsm_master != MASTER_INIT)
                    begin                                               // PULL request
                    pp_dma_block    <= 'd1;                             // init first and block CPU
                    pp_src_ptr      <= CONFIG_BASE + PRG_OFFS;
                    pp_dst_ptr      <= BOOT_BASE;
                    pp_remain_int   <= 16'd256 - 4;                     // 4096 x 32 words
                    pp_sel_r        <= 4'b1111;                         // aligned words
                    o_m_wb_adr      <= (CONFIG_BASE + PRG_OFFS) & 32'hffff_fffc;
                    o_m_wb_sel      <= 4'b1111;
                    o_m_wb_cyc      <= 'd1;
                    o_m_wb_stb      <= 'd1;
                    fsm_pp          <= PP_BEGIN;
                    end

            PP_READY:
                if ((fsm_master == MASTER_RUN) && (pp_remain != 0))
                    begin                                               // PULL request
                    pp_dma_block    <= dma_block_reg;
                    pp_src_ptr      <= src_start_reg;
                    pp_dst_ptr      <= dst_start_reg;
                    pp_remain_int   <= block_len_reg;
                    pp_sel_r        <= sel_nxt[WB_SWIDTH-1:0];
                    o_m_wb_adr      <= src_start_reg & 32'hffff_fffc;
                    o_m_wb_sel      <= sel_nxt[WB_SWIDTH-1:0];
                    o_m_wb_cyc      <= 'd1;
                    o_m_wb_stb      <= 'd1;
                    fsm_pp          <= PP_BEGIN;
                    end

            PP_BEGIN:
                if (i_m_wb_ack || i_m_wb_err)
                    begin                                               // PULL result
                    pp_data         <= i_m_wb_dat;
                    pp_src_ptr      <= (pp_src_ptr & 32'hffff_fffc) + 4;
                    o_m_wb_cyc      <= 'd1;
                    o_m_wb_stb      <= 'd0;
                    if (4 < pp_remain)
                        begin
                        pp_remain_int   <= pp_remain - 4;
                        fsm_pp          <= PP_MAIL11;
                        end
                    else
                        // keep pull_remain_reg
                        fsm_pp          <= PP_MAIL21;
                    end

            PP_MAIL11:
                if (!i_m_wb_ack && !i_m_wb_err)
                    begin                                               // PUSH activation
                    o_m_wb_adr      <= pp_dst_ptr;
                    o_m_wb_sel      <= pp_sel_r;
                    o_m_wb_dat      <= pp_data;
                    o_m_wb_we       <= 'd1;
                    o_m_wb_cyc      <= 'd1;
                    o_m_wb_stb      <= 'd1;
                    fsm_pp          <= PP_MAIL12;
                    end

            PP_MAIL12:
                if (i_m_wb_ack || i_m_wb_err)
                    begin                                               // PUSH termination
                    pp_dst_ptr      <= (pp_dst_ptr & 32'hffff_fffc) + 4;
                    o_m_wb_we       <= 'd0;
                    o_m_wb_cyc      <= pp_dma_block;
                    o_m_wb_stb      <= 'd0;
                    fsm_pp          <= PP_MAIL13;
                    end

            PP_MAIL13:
                if (!i_m_wb_ack && !i_m_wb_err)
                    begin                                               // PULL request
                    pp_sel_r        <= 4'b1111;
                    o_m_wb_adr      <= pp_src_ptr;
                    o_m_wb_sel      <= 4'b1111;
                    o_m_wb_cyc      <= 'd1;
                    o_m_wb_stb      <= 'd1;
                    fsm_pp          <= PP_MIDDLE;
                    end

            PP_MIDDLE:
                if (i_m_wb_ack)
                    begin                                               // PULL result
                    pp_data         <= i_m_wb_dat;
                    pp_src_ptr      <= pp_src_ptr + 4;
                    o_m_wb_cyc      <= 'd1;
                    o_m_wb_stb      <= 'd0;
                    if (4 < pp_remain)
                        begin
                        pp_remain_int   <= pp_remain - 4;
                        fsm_pp          <= PP_MAIL11;
                        end
//                  else if (0 == pp_remain_reg)                        // dead code
//                      fsm_pp          <= PP_LAST;
                    else
                        // keep pp_remain_reg
                        fsm_pp          <= PP_MAIL21;
                    end

            PP_MAIL21:          // entry point for 1..4 requested bytes
                if (!i_m_wb_ack && !i_m_wb_err)
                    begin                                               // PUSH activation
                    o_m_wb_adr      <= pp_dst_ptr;
                    o_m_wb_sel      <= pp_sel_r;
                    o_m_wb_dat      <= pp_data;
                    o_m_wb_we       <= 'd1;
                    o_m_wb_cyc      <= 'd1;
                    o_m_wb_stb      <= 'd1;
                    fsm_pp          <= PP_MAIL22;
                    end

            PP_MAIL22:
                if (i_m_wb_ack || i_m_wb_err)
                    begin                                               // PUSH termination
                    pp_dst_ptr      <= pp_dst_ptr + 4;
                    o_m_wb_we       <= 'd0;
                    o_m_wb_cyc      <= pp_dma_block;
                    o_m_wb_stb      <= 'd0;
                    fsm_pp          <= PP_MAIL23;
                    end

            PP_MAIL23:
                if (!i_m_wb_ack && !i_m_wb_err)
                    begin                                               // PULL request
                    pp_sel_r        <= (4'b1111 >> (4 - pp_remain));
                    o_m_wb_adr      <= pp_src_ptr;
                    o_m_wb_sel      <= (4'b1111 >> (4 - pp_remain));
                    o_m_wb_cyc      <= 'd1;
                    o_m_wb_stb      <= 'd1;
                    fsm_pp          <= PP_LAST;
                    end
                
            PP_LAST:
                if (i_m_wb_ack || i_m_wb_err)
                    begin                                               // PULL result
                    pp_data         <= i_m_wb_dat;
                    o_m_wb_cyc      <= 'd1;
                    o_m_wb_stb      <= 'd0;
                    fsm_pp          <= PP_MAIL31;
                    end

            PP_MAIL31:
                 if (!i_m_wb_ack && !i_m_wb_err)
                    begin                                               // PUSH activation
                    o_m_wb_adr      <= pp_dst_ptr;
                    o_m_wb_sel      <= pp_sel_r;
                    o_m_wb_dat      <= pp_data;
                    o_m_wb_we       <= 'd1;
                    o_m_wb_cyc      <= 'd1;
                    o_m_wb_stb      <= 'd1;
                    fsm_pp          <= PP_MAIL32;
                    end

            PP_MAIL32:
                if (i_m_wb_ack || i_m_wb_err)
                    begin                                               // PUSH termination
                    pp_dma_block    <= 'd0;
                    pp_sel_r        <= 'd0;
                    pp_data         <= 'd0;
                    o_m_wb_adr      <= 'd0;
                    o_m_wb_sel      <= 'd0;
                    o_m_wb_dat      <= 'd0;
                    o_m_wb_we       <= 'd0;
                    o_m_wb_cyc      <= 'd0;
                    o_m_wb_stb      <= 'd0;
                    fsm_pp          <= PP_READY;
                    end

            default:
                fsm_pp  <= PP_INIT;
        endcase
    end



// =======================================================================================
// =======================================================================================
// =======================================================================================
// Non-synthesizable debug code
// =======================================================================================
//synthesis translate_off
//synopsys translate_off
wire    [(3*8)-1:0]    xFSM_MASTER;
wire    [(6*8)-1:0]    xFSM_PP;

assign  xFSM_MASTER = fsm_master    == MASTER_INIT                  ? "INI" :
                      fsm_master    == MASTER_READY                 ? "RDY" :
                      fsm_master    == MASTER_RUN                   ? "RUN" :
                      fsm_master    == MASTER_END                   ? "END" :
                                                                      "???" ;

assign  xFSM_PP     = fsm_pp        == PP_INIT                      ? "INIT  " :
                      fsm_pp        == PP_PRELOAD                   ? "PRELD " :
                      fsm_pp        == PP_READY                     ? "READY " :
                      fsm_pp        == PP_BEGIN                     ? "BEGIN " :
                      fsm_pp        == PP_MAIL11                    ? "MAIL11" :
                      fsm_pp        == PP_MAIL12                    ? "MAIL12" :
                      fsm_pp        == PP_MAIL13                    ? "MAIL13" :
                      fsm_pp        == PP_MIDDLE                    ? "MIDDLE" :
                      fsm_pp        == PP_MAIL21                    ? "MAIL21" :
                      fsm_pp        == PP_MAIL22                    ? "MAIL22" :
                      fsm_pp        == PP_MAIL23                    ? "MAIL23" :
                      fsm_pp        == PP_LAST                      ? "LAST  " :
                      fsm_pp        == PP_MAIL31                    ? "MAIL31" :
                      fsm_pp        == PP_MAIL32                    ? "MAIL32" :
                                                                      "??????" ;

`ifdef AMBER_DMA_DEBUG            

wire wb_s_read_ack = i_s_wb_stb && !i_s_wb_we &&  o_s_wb_ack;


// -----------------------------------------------
// Report DMA Module Register accesses
// -----------------------------------------------  
always @(posedge i_clk)
    if (wb_s_read_ack || wb_s_start_write)
        begin
        `TB_DEBUG_MESSAGE

        if (wb_s_start_write)
            $write("Write 0x%08x to   ", i_s_wb_dat);
        else
            $write("Read  0x%08x from ", o_s_wb_dat);

        case (i_s_wb_adr[15:0])
            AMBER_DMA_START0:
                $write(" DMA Controller PULL start address"); 
            AMBER_DMA_START1:
                $write(" DMA Controller PUSH start address"); 
            AMBER_DMA_LENGTH:
                $write(" DMA Controller Memory copy length"); 
            AMBER_DMA_CUR0:
                $write(" DMA Controller Current PULL address"); 
            AMBER_DMA_CUR1:
                $write(" DMA Controller Current PUSH address"); 
            AMBER_DMA_REMAIN:
                $write(" DMA Controller Remaining bytes to run"); 

            default:
                begin
                $write(" unknown Amber DMA Register Address");
                $write(", Address 0x%08h\n", i_s_wb_adr); 
                `TB_ERROR_MESSAGE
                end
        endcase

        $write(", Address 0x%08h\n", i_s_wb_adr); 
        end

`endif

//synopsys translate_on
//synthesis translate_on

endmodule
