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
output      [31:0]          o_m_wb_adr,
output      [WB_SWIDTH-1:0] o_m_wb_sel,
output                      o_m_wb_we,
input       [WB_DWIDTH-1:0] i_m_wb_dat,
output      [WB_DWIDTH-1:0] o_m_wb_dat,
output                      o_m_wb_cyc,
output                      o_m_wb_stb,
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

// DMA engine
reg  [31:0]     block_src_ptr = 'd0;
reg  [31:0]     block_dst_ptr = 'd0;
reg  [15:0]     block_remain_reg = 'd0;
reg             block_copy_reg = 'd0;


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
            AMBER_DMA_CUR0:     wb_s_rdata32 <= block_src_ptr;
            AMBER_DMA_CUR1:     wb_s_rdata32 <= block_dst_ptr;
            AMBER_DMA_REMAIN:   wb_s_rdata32 <= {16'd0, block_remain_reg};

            default:            wb_s_rdata32 <= 32'h66778899;

        endcase


// -------------------------------  
// Init copy
// -------------------------------  
localparam MASTER_INIT      = 2'd0;
localparam MASTER_READY     = 2'd1;
localparam MASTER_RUN       = 2'd2;
reg  [1:0]      fsm_master  = 2'd0;
always @( posedge i_clk )
    begin
    if ( i_sys_rst )
        begin
        block_src_ptr       <= 'd0;
        block_dst_ptr       <= 'd0;
        block_remain_reg    <= 'd0;
        block_copy_reg      <= 'd0;
        fsm_master          <= MASTER_INIT;
        end
    else
        case ( fsm_master )
            MASTER_INIT:
                begin
                block_src_ptr       <= 'd0;
                block_dst_ptr       <= 'd0;
                block_remain_reg    <= 'd0;
                block_copy_reg      <= 'd0;
                fsm_master          <= MASTER_READY;
                end

            MASTER_READY:
                begin
                if (wb_s_start_write && (AMBER_DMA_LENGTH == wb_s_rdata32) && (block_len_reg != 0))
                    begin
                    block_src_ptr       <= src_start_reg;
                    block_dst_ptr       <= dst_start_reg;
                    block_remain_reg    <= block_len_reg;
                    block_copy_reg      <= 'd1;
                    fsm_master          <= MASTER_RUN;
                    end
                end

            MASTER_RUN:
                begin
                if ((fsm_push == PUSH_READY) && (fsm_pull == PULL_READY))
                    begin
                    block_copy_reg      <= 'd0;
                    fsm_master          <= MASTER_READY;
                    end
                    
                end
                
            default:
                fsm_master  <= MASTER_INIT;
        endcase
    end

// TODO

// -------------------------------  
// Pulling FSM
// -------------------------------  
localparam PULL_INIT      = 2'd0;
localparam PULL_READY     = 2'd1;
reg  [1:0]      fsm_pull  = 2'd0;
always @( posedge i_clk )
    begin
    if ( i_sys_rst )
        begin
        fsm_pull    <= PULL_INIT;
        end
    else
        case ( fsm_pull )
            PULL_INIT:
                begin
                fsm_pull    <= PULL_READY;
                end

            PULL_READY:
                begin
                if (block_copy_reg)
                    begin

                    end
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
reg  [1:0]      fsm_push  = 2'd0;
always @( posedge i_clk )
    begin
    if ( i_sys_rst )
        begin
        fsm_push    <= PUSH_INIT;
        end
    else
        case ( fsm_push )
            PUSH_INIT:
                begin
                fsm_push    <= PUSH_READY;
                end

            PUSH_READY:
                begin
                // if ()
                
                end

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
