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


`include "register_addresses.vh"

// Wishbone registers
reg  [31:0]     src_start_reg = 'd0;         // initial address of source block
reg  [31:0]     dst_start_reg = 'd0;         // initial address of destination block
reg  [15:0]     block_len_reg = 'd0;            // block copy length

// Wishbone slave interface
reg  [31:0]     wb_s_rdata32 = 'd0;
wire            wb_s_start_write;
wire            wb_s_start_read;
reg             wb_s_start_read_d1 = 'd0;
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
            AMBER_DMA_CUR0:     wb_s_rdata32 <= pull_src_ptr;
            AMBER_DMA_CUR1:     wb_s_rdata32 <= push_dst_ptr;
            AMBER_DMA_REMAIN:   wb_s_rdata32 <= {16'd0, pull_remain_reg};

            default:            wb_s_rdata32 <= 32'h66778899;

        endcase


// -------------------------------  
// Init copy
// -------------------------------  
localparam MASTER_READY     = 2'd0;
localparam MASTER_RUN       = 2'd1;
localparam MASTER_END       = 2'd2;
reg  [1:0]      fsm_master  = 2'd0;
always @( posedge i_clk )
    begin
    if ( i_sys_rst )
        begin
        fsm_master          <= MASTER_READY;
        end
    else
        case ( fsm_master )
            MASTER_READY:
                begin
                if (wb_s_start_write && (AMBER_DMA_LENGTH == wb_s_rdata32) && (block_len_reg != 0))
                    begin
                    fsm_master          <= MASTER_RUN;
                    end
                end

            MASTER_RUN:
                fsm_master              <= MASTER_END;

            MASTER_END:
                if ((fsm_pull == PULL_READY) && (fsm_push == PUSH_READY))
                    fsm_master          <= MASTER_READY;

            default:
                fsm_master              <= MASTER_READY;
        endcase
    end


// -------------------------------  
// Pulling FSM
// -------------------------------  
localparam PULL_INIT        = 4'd0;
localparam PULL_READY       = 4'd1;
localparam PULL_BEGIN       = 4'd2;
localparam PULL_MAIL11      = 4'd3;
localparam PULL_MAIL12      = 4'd4;
localparam PULL_MIDDLE      = 4'd5;
localparam PULL_MAIL21      = 4'd6;
localparam PULL_MAIL22      = 4'd7;
localparam PULL_LAST        = 4'd8;
localparam PULL_MAIL31      = 4'd9;
localparam PULL_MAIL32      = 4'd10;
reg  [31:0]             pull_src_ptr        = 'd0;
reg  [15:0]             pull_remain_reg     = 'd0;
reg  [3:0]              mail_pull_sel_r     = 'd0;
reg  [WB_DWIDTH-1:0]    mail_pull_data      = 'd0;
reg                     mail_pull_ready     = 'd0;
reg  [3:0]              fsm_pull            = 'd0;

wire [3:0]              sel_int;
assign                  sel_int = (pull_remain_reg > 3) ?  (4'b1111 << (pull_src_ptr & 2'b11) & 4'b1111) :
                                                           (4'b1111 << (pull_src_ptr & 2'b11) & 4'b1111 & (4'b1111 >> (4 - pull_remain_reg)));
always @( posedge i_clk )
    begin
    if ( i_sys_rst )
        begin
        pull_src_ptr    <= 'd0;
        pull_remain_reg <= 'd0;
        o_m_wb_adr      <= 'd0;
        o_m_wb_sel      <= 'd0;
        o_m_wb_we       <= 'd0;
        o_m_wb_dat      <= 'd0;
        o_m_wb_cyc      <= 'd0;
        o_m_wb_stb      <= 'd0;
        mail_pull_sel_r <= 'd0;
        mail_pull_data  <= 'd0;
        mail_pull_ready <= 'd0;
        fsm_pull        <= PULL_INIT;
        end
    else
        case ( fsm_pull )
            PULL_INIT:
                begin
                pull_src_ptr    <= 'd0;
                pull_remain_reg <= 'd0;
                o_m_wb_adr      <= 'd0;
                o_m_wb_sel      <= 'd0;
                o_m_wb_we       <= 'd0;
                o_m_wb_dat      <= 'd0;
                o_m_wb_cyc      <= 'd0;
                o_m_wb_stb      <= 'd0;
                mail_pull_sel_r <= 'd0;
                mail_pull_data  <= 'd0;
                mail_pull_ready <= 'd0;
                fsm_pull        <= PULL_READY;
                end

            PULL_READY:
                if ((fsm_master == MASTER_RUN) && (pull_remain_reg != 0))
                    begin
                    pull_src_ptr        <= src_start_reg;
                    pull_remain_reg     <= block_len_reg;
                    o_m_wb_adr          <= src_start_reg & 32'hffff_fffd;   // first request cycle starts here
                    o_m_wb_sel          <= sel_int[WB_SWIDTH-1:0];
                    mail_pull_sel_r     <= sel_int[WB_SWIDTH-1:0];
                    o_m_wb_cyc          <= 'd1;
                    o_m_wb_stb          <= 'd1;
                    fsm_pull            <= PULL_BEGIN;
                    end

            PULL_BEGIN:
                if (i_m_wb_ack)
                    begin
                    mail_pull_data  <= i_m_wb_dat;
                    o_m_wb_cyc      <= 'd0;
                    o_m_wb_stb      <= 'd0;
                    pull_src_ptr    <= (pull_src_ptr & 32'hffff_fffd) + 4;
                    if (4 < pull_remain_reg)
                        begin
                        pull_remain_reg     <= pull_remain_reg - 4;
                        fsm_pull            <= PULL_MAIL11;
                        end
                    else
                        // keep pull_remain_reg
                        fsm_pull            <= PULL_MAIL21;
                    end

            PULL_MAIL11:
                begin
                o_m_wb_adr      <= pull_src_ptr;    // next request cycle starts here
                o_m_wb_sel      <= 4'b1111;
                o_m_wb_cyc      <= 'd1;
                o_m_wb_stb      <= 'd1;
                if (mail_push_next)
                    begin
                    mail_pull_sel_r <= 4'b1111;
                    mail_pull_ready <= 'd1;
                    fsm_pull        <= PULL_MAIL12;
                    end
                end

            PULL_MAIL12:
                if (!mail_push_next)
                    begin
                    mail_pull_ready <= 'd0;
                    fsm_pull        <= PULL_MIDDLE;
                    end

            PULL_MIDDLE:
                if (i_m_wb_ack)
                    begin
                    mail_pull_data  <= i_m_wb_dat;
                    o_m_wb_cyc      <= 'd0;
                    o_m_wb_stb      <= 'd0;
                    pull_src_ptr    <= pull_src_ptr + 4;
                    if (4 < pull_remain_reg)
                        begin
                        pull_remain_reg     <= pull_remain_reg - 4;
                        fsm_pull            <= PULL_MAIL11;
                        end
//                  else if (0 == pull_remain_reg)         // dead code
//                      fsm_pull            <= PULL_LAST;
                    else
                        // keep pull_remain_reg
                        fsm_pull            <= PULL_MAIL21;
                    end

            PULL_MAIL21:                            // entry point for 1..4 requested bytes
                begin
                o_m_wb_sel      <= (4'b1111 >> (4 - pull_remain_reg));
                o_m_wb_adr      <= pull_src_ptr;    // last request cycle starts here
                o_m_wb_cyc      <= 'd1;
                o_m_wb_stb      <= 'd1;
                if (mail_push_next)
                    begin
                    mail_pull_sel_r <= (4'b1111 >> (4 - pull_remain_reg));
                    mail_pull_ready <= 'd1;
                    fsm_pull        <= PULL_MAIL22;
                    end
                end

            PULL_MAIL22:
                if (!mail_push_next)
                    begin
                    mail_pull_ready <= 'd0;
                    fsm_pull        <= PULL_LAST;
                    end

            PULL_LAST:
                if (i_m_wb_ack)
                    begin
                    mail_pull_data  <= i_m_wb_dat;
                    o_m_wb_cyc      <= 'd0;
                    o_m_wb_stb      <= 'd0;
                    fsm_pull        <= PULL_MAIL31;
                    end

            PULL_MAIL31:
                begin
                o_m_wb_sel      <= 'd0;
                o_m_wb_adr      <= 'd0;
                o_m_wb_cyc      <= 'd0;
                o_m_wb_stb      <= 'd0;
                if (mail_push_next)
                    begin
                    mail_pull_ready <= 'd1;
                    fsm_pull        <= PULL_MAIL32;
                    end
                end

            PULL_MAIL32:
                if (!mail_push_next)
                    begin
                    mail_pull_sel_r <= 'd0;
                    mail_pull_data  <= 'd0;
                    mail_pull_ready <= 'd0;
                    fsm_pull        <= PULL_READY;
                    end

            default:
                fsm_pull    <= PULL_INIT;
        endcase
    end


// -------------------------------  
// Pushing FSM
// -------------------------------  
localparam PUSH_INIT      = 2'd0;
localparam PUSH_READY     = 2'd1;
reg  [31:0]             push_dst_ptr        = 'd0;
reg  [3:0]              mail_push_sel_r     = 'd0;
reg  [WB_DWIDTH-1:0]    mail_push_data      = 'd0;
reg                     mail_push_next      = 'd0;
reg  [1:0]              fsm_push            = 2'd0;
always @( posedge i_clk )
    begin
    if ( i_sys_rst )
        begin
        push_dst_ptr    <= 'd0;
        mail_push_sel_r <= 'd0;
        mail_push_data  <= 'd0;
        mail_push_next  <= 'd0;
        fsm_push        <= PUSH_INIT;
        end
    else
        case ( fsm_push )
            PUSH_INIT:
                begin
                push_dst_ptr    <= 'd0;
                mail_push_sel_r <= 'd0;
                mail_push_data  <= 'd0;
                mail_push_next  <= 'd0;
                fsm_push        <= PUSH_READY;
                end

            PUSH_READY:
                begin
                // if ()
                
                end
//                    push_dst_ptr        <= dst_start_reg;

//                    mail_push_sel_r <= mail_pull_sel_r
//                    mail_push_data  <= mail_pull_data;

            default:
                fsm_push    <= PUSH_INIT;
        endcase
    end


// =======================================================================================
// =======================================================================================
// =======================================================================================
// Non-synthesizable debug code
// =======================================================================================


//synthesis translate_off
//synopsys translate_off

`ifdef AMBER_DMA_DEBUG            

wire wb_s_read_ack = i_wb_s_stb && !i_wb_s_we &&  o_wb_s_ack;

// -----------------------------------------------
// Report DMA Module Register accesses
// -----------------------------------------------  
always @(posedge i_clk)
    if ( wb_s_read_ack || wb_s_start_write )
        begin
        `TB_DEBUG_MESSAGE

        if ( wb_start_write )
            $write("Write 0x%08x to   ", i_wb_dat);
        else
            $write("Read  0x%08x from ", o_wb_dat);

        case ( i_wb_adr[15:0] )
            AMBER_DMA_START0:
                $write(" DMA Controller Start address of puller"); 
            AMBER_DMA_START1:
                $write(" DMA Controller Start address of pusher"); 
            AMBER_DMA_LENGTH:
                $write(" DMA Controller Memory copy length"); 
            AMBER_DMA_REMAIN:
                $write(" DMA Controller Current remaining bytes to run"); 

            default:
                begin
                $write(" unknown Amber DMA Register region");
                $write(", Address 0x%08h\n", i_wb_adr); 
                `TB_ERROR_MESSAGE
                end
        endcase

        $write(", Address 0x%08h\n", i_wb_adr); 
        end

`endif

//synopsys translate_on
//synthesis translate_on

endmodule
