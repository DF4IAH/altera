-- Copyright (C) 1991-2015 Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, the Altera Quartus II License Agreement,
-- the Altera MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Altera and sold by Altera or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

library ieee;
use ieee.std_logic_1164.all;
library altera;
use altera.altera_syn_attributes.all;

-- use work.amber_types.all;


entity top is
	port
	(
-- {ALTERA_IO_BEGIN} DO NOT REMOVE THIS LINE!

-- Reset Pin
		i_reset_n			: in std_logic;

-- Clock from oscillator
		i_brd_clk_p			: in std_logic;
		i_brd_clk_n			: in std_logic;

-- Status LEDs
		o_led				: out std_logic_vector (3 downto 0);
		
-- UART 0 Interface
		i_uart0_tx			: in std_logic;
		o_uart0_rx			: out std_logic;
		i_uart0_rts			: in std_logic;
		o_uart0_cts			: out std_logic;

-- UART 1 Interface
--		i_uart1_tx			: in std_logic;
--		o_uart1_rx			: out std_logic;
--		i_uart1_rts			: in std_logic;
--		o_uart1_cts			: out std_logic;

-- Xilinx Spartan 6 MCB DDR3 Interface
--		io_ddr3_dq			: inout std_logic_vector (15 downto 0);
--		o_ddr3_addr			: out std_logic_vector (12 downto 0);
--		o_ddr3_ba			: out std_logic_vector (2 downto 0);
--		o_ddr3_ras_n		: out std_logic;
--		o_ddr3_cas_n		: out std_logic;
--		o_ddr3_we_n			: out std_logic;
--		o_ddr3_odt			: out std_logic;
--		o_ddr3_reset_n		: out std_logic;
--		o_ddr3_cke			: out std_logic;
--		o_ddr3_dm			: out std_logic_vector (1 downto 0);
--		io_ddr3_dqs_p		: inout std_logic_vector (1 downto 0);
--		io_ddr3_dqs_n		: inout std_logic_vector (1 downto 0);
--		o_ddr3_ck_p			: out std_logic;
--		o_ddr3_ck_n			: out std_logic;
-- ifdef XILINX_SPARTAN6_FPGA
--		io_mcb3_rzq			: inout std_logic;
-- endif

-- Altera SRAM 2Mx8 Interface
		o_sram_cs_n			: out std_logic_vector (3 downto 0);
		o_sram_read_n		: out std_logic;
		o_sram_write_n		: out std_logic;
		o_sram_addr			: out std_logic_vector (20 downto 0);
		io_sram_data		: inout std_logic_vector (7 downto 0);

-- Ethmac B100 MAC to PHY Interface
		i_mtx_clk_pad_i	    : in std_logic;
		o_mtxd_pad_o		: out std_logic_vector (3 downto 0);
		o_mtxen_pad_o		: out std_logic;
		o_mtxerr_pad_o		: out std_logic;
		i_mrx_clk_pad_i	    : in std_logic;
		i_mrxd_pad_i		: in std_logic_vector (3 downto 0);
		i_mrxdv_pad_i		: in std_logic;
		i_mrxerr_pad_i		: in std_logic;
		i_mcoll_pad_i		: in std_logic;
		i_mcrs_pad_i		: in std_logic;
		io_md_pad_io		: inout std_logic;
		o_mdc_pad_o			: out std_logic;
		o_phy_reset_n		: out std_logic

-- {ALTERA_IO_END} DO NOT REMOVE THIS LINE!
	);

-- {ALTERA_ATTRIBUTE_BEGIN} DO NOT REMOVE THIS LINE!
--	signal ddr3_dq_top	: std_logic_vector (15 downto 0);
-- {ALTERA_ATTRIBUTE_END} DO NOT REMOVE THIS LINE!
end top;


architecture HIERARCHICAL of top is
-- {ALTERA_COMPONENTS_BEGIN} DO NOT REMOVE THIS LINE!
	component system
		port (
-- BOARD
			brd_rst			: in std_logic;
			brd_clk_p		: in std_logic;
			brd_clk_n		: in std_logic;

-- UART 0 Interface
			i_uart0_rts		: in std_logic;
			o_uart0_rx		: out std_logic;
			o_uart0_cts		: out std_logic;
			i_uart0_tx		: in std_logic;

-- UART 1 Interface
			i_uart1_rts		: in std_logic;
			o_uart1_rx		: out std_logic;
			o_uart1_cts		: out std_logic;
			i_uart1_tx		: in std_logic;

-- Xilinx Spartan 6 MCB DDR3 Interface
			ddr3_dq			: inout std_logic_vector (15 downto 0);
			ddr3_addr		: out std_logic_vector (12 downto 0);
			ddr3_ba			: out std_logic_vector (2 downto 0);
			ddr3_ras_n		: out std_logic;
			ddr3_cas_n		: out std_logic;
			ddr3_we_n		: out std_logic;
			ddr3_odt		: out std_logic;
			ddr3_reset_n	: out std_logic;
			ddr3_cke		: out std_logic;
			ddr3_dm			: out std_logic_vector (1 downto 0);
			ddr3_dqs_p		: inout std_logic_vector (1 downto 0);
			ddr3_dqs_n		: inout std_logic_vector (1 downto 0);
			ddr3_ck_p		: out std_logic;
			ddr3_ck_n		: out std_logic;
-- ifdef XILINX_SPARTAN6_FPGA
--			mcb3_rzq		: inout std_logic;
-- endif

-- Altera SRAM 2Mx8 Interface
			o_sram_cs_n		: out std_logic_vector (3 downto 0);
			o_sram_read_n	: out std_logic;
			o_sram_write_n	: out std_logic;
			o_sram_addr		: out std_logic_vector (20 downto 0);
			io_sram_data	: inout std_logic_vector (7 downto 0);

-- Ethmac B100 MAC to PHY Interface
			mtx_clk_pad_i	: in std_logic;
			mtxd_pad_o		: out std_logic_vector (3 downto 0);
			mtxen_pad_o		: out std_logic;
			mtxerr_pad_o	: out std_logic;
			mrx_clk_pad_i	: in std_logic;
			mrxd_pad_i		: in std_logic_vector (3 downto 0);
			mrxdv_pad_i		: in std_logic;
			mrxerr_pad_i	: in std_logic;
			mcoll_pad_i		: in std_logic;
			mcrs_pad_i		: in std_logic;
			md_pad_io		: inout std_logic;
			mdc_pad_o		: out std_logic;
			phy_reset_n		: out std_logic;

			led				: out std_logic_vector (3 downto 0)
	);
	end component;

--	component a23_core
--		port (
--			i_clk			: in std_logic;
--			i_irq			: in std_logic;
--			i_firq			: in std_logic;
--			i_system_rdy	: in std_logic;
--
--			-- Wishbone Master I/F
--			o_wb_adr		: out std_logic_vector(31 downto 0);
--			o_wb_sel		: out std_logic_vector(3 downto 0);
--			o_wb_we			: out std_logic;
--			i_wb_dat		: in std_logic_vector(31 downto 0);
--			o_wb_dat		: out std_logic_vector(31 downto 0);
--			o_wb_cyc		: out std_logic;
--			o_wb_stb		: out std_logic;
--			i_wb_ack		: in std_logic;
--			i_wb_err		: in std_logic
--		);
--	end component;
-- {ALTERA_COMPONENTS_END} DO NOT REMOVE THIS LINE!
begin
-- {ALTERA_INSTANTIATION_BEGIN} DO NOT REMOVE THIS LINE!
	system_0: system
		port map (
-- BOARD
			brd_rst			=> i_reset_n,
			brd_clk_p		=> i_brd_clk_p,
			brd_clk_n		=> i_brd_clk_n,

-- UART 0 Interface
			i_uart0_tx		=> i_uart0_tx,
			o_uart0_rx		=> o_uart0_rx,
			i_uart0_rts		=> i_uart0_rts,
			o_uart0_cts		=> o_uart0_cts,

-- UART 1 Interface
			i_uart1_tx		=> '1',
			o_uart1_rx		=> open,
			i_uart1_rts		=> '1',
			o_uart1_cts		=> open,

-- Xilinx Spartan 6 MCB DDR3 Interface
			ddr3_dq			=> open,
			ddr3_addr		=> open,
			ddr3_ba			=> open,
			ddr3_ras_n		=> open,
			ddr3_cas_n		=> open,
			ddr3_we_n		=> open,
			ddr3_odt		=> open,
			ddr3_reset_n	=> open,
			ddr3_cke		=> open,
			ddr3_dm			=> open,
			ddr3_dqs_p		=> open,
			ddr3_dqs_n		=> open,
			ddr3_ck_p		=> open,
			ddr3_ck_n		=> open,

--			ddr3_dq			=> io_ddr3_dq,
--			ddr3_addr		=> o_ddr3_addr,
--			ddr3_ba			=> o_ddr3_ba,
--			ddr3_ras_n		=> o_ddr3_ras_n,
--			ddr3_cas_n		=> o_ddr3_cas_n,
--			ddr3_we_n		=> o_ddr3_we_n,
--			ddr3_odt		=> o_ddr3_odt,
--			ddr3_reset_n	=> o_ddr3_reset_n,
--			ddr3_cke		=> o_ddr3_cke,
--			ddr3_dm			=> o_ddr3_dm,
--			ddr3_dqs_p		=> io_ddr3_dqs_p,
--			ddr3_dqs_n		=> io_ddr3_dqs_n,
--			ddr3_ck_p		=> o_ddr3_ck_p,
--			ddr3_ck_n		=> o_ddr3_ck_n,
-- ifdef XILINX_SPARTAN6_FPGA
--			mcb3_rzq 		=> io_mcb3_rzq,
-- endif

			o_sram_cs_n		=> o_sram_cs_n,
			o_sram_read_n	=> o_sram_read_n,
			o_sram_write_n	=> o_sram_write_n,
			o_sram_addr		=> o_sram_addr,
			io_sram_data	=> io_sram_data,

-- Ethmac B100 MAC to PHY Interface
			mtx_clk_pad_i	=> i_mtx_clk_pad_i,
			mtxd_pad_o		=> o_mtxd_pad_o,
			mtxen_pad_o		=> o_mtxen_pad_o,
			mtxerr_pad_o	=> o_mtxerr_pad_o,
			mrx_clk_pad_i	=> i_mrx_clk_pad_i,
			mrxd_pad_i		=> i_mrxd_pad_i,
			mrxdv_pad_i		=> i_mrxdv_pad_i,
			mrxerr_pad_i	=> i_mrxerr_pad_i,
			mcoll_pad_i		=> i_mcoll_pad_i,
			mcrs_pad_i		=> i_mcrs_pad_i,
			md_pad_io		=> io_md_pad_io,
			mdc_pad_o		=> o_mdc_pad_o,
			phy_reset_n		=> o_phy_reset_n,

			led				=> o_led
	);

--	a23_core_0: a23_core 
--		port map (
--			i_clk			=>	C_40MHZ,
--			i_irq			=>	amber_i_irq,				-- Interrupt request, active high
--			i_firq			=>	amber_i_firq,				-- Fast Interrupt request, active high
--			i_system_rdy	=>	amber_i_system_rdy,		-- Amber is stalled when this is low
--
--			-- Wishbone Master I/F
--			o_wb_adr(31 downto 8)	=>	open,
--			o_wb_adr(7 downto 0)	=>	wb_o_adr,
--			o_wb_sel		=>	wb_o_sel,
--			o_wb_we			=>	wb_o_we,
--			i_wb_dat		=>	wb_i_dat,
--			o_wb_dat		=>	wb_o_dat,
--			o_wb_cyc		=>	wb_o_cyc,
--			o_wb_stb		=>	wb_o_stb,
--			i_wb_ack		=>	wb_i_ack,
--			i_wb_err		=>	wb_i_err
--	);
-- {ALTERA_INSTANTIATION_END} DO NOT REMOVE THIS LINE!

end;
