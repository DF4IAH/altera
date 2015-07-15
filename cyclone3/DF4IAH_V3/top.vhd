-- This is the VHDL top entity for the DF4IAH_V3 FPGA project
--
-- VHDL variant
--
--  Author(s):
--      - Ulrich Habel, espero7757 at gmx.net
--


library ieee;
use ieee.std_logic_1164.all;

library altera;
use altera.altera_syn_attributes.all;

-- use work.all;
-- use work.amber_types.all;


entity top is
	port
	(
-- {ALTERA_IO_BEGIN} DO NOT REMOVE THIS LINE!

-- Reset Pin
		i_reset_n			: in std_logic;

-- Clock from oscillator
		i_brd_clk			: in std_logic;
--		i_brd_clk_p			: in std_logic;
--		i_brd_clk_n			: in std_logic;

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

-- I2C Master 0 Master Interface
        o_i2c0_scl          : out std_logic;
        io_i2c0_sda         : inout std_logic;

-- SPI Master 0 Interface
        o_spi0_sclk         : out std_logic;
        o_spi0_mosi         : out std_logic;
        i_spi0_miso         : in std_logic;
        o_spi0_ss_n         : out std_logic;

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
		i_mtx_clk_pad       : in std_logic;
		o_mtxd              : out std_logic_vector (3 downto 0);
		o_mtxen             : out std_logic;
		o_mtxerr            : out std_logic;
		i_mrx_clk           : in std_logic;
		i_mrxd              : in std_logic_vector (3 downto 0);
		i_mrxdv             : in std_logic;
		i_mrxerr            : in std_logic;
		i_mcoll             : in std_logic;
		i_mcrs              : in std_logic;
		io_md               : inout std_logic;
		o_mdc               : out std_logic;
		o_phy_reset_n       : out std_logic;

-- JTAG Interface
        altera_reserved_tck : in std_logic;
        altera_reserved_tdi : in std_logic;
        altera_reserved_tms : in std_logic;
        altera_reserved_tdo : out std_logic;

        o_monitor           : out std_logic_vector (15 downto 0)
-- {ALTERA_IO_END} DO NOT REMOVE THIS LINE!
	);

-- {ALTERA_ATTRIBUTE_BEGIN} DO NOT REMOVE THIS LINE!
--	signal ddr3_dq_top	: std_logic_vector (15 downto 0);

    signal monitor : std_logic_vector (15 downto 0);
-- {ALTERA_ATTRIBUTE_END} DO NOT REMOVE THIS LINE!
end top;


architecture HIERARCHICAL of top is
-- {ALTERA_COMPONENTS_BEGIN} DO NOT REMOVE THIS LINE!
	component system
		port (
-- BOARD
			brd_rst			: in std_logic;
			brd_clk 		: in std_logic;
--			brd_clk_p		: in std_logic;
--			brd_clk_n		: in std_logic;

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

-- I2C Master 0 Master Interface
            o_i2c0_scl      : out std_logic;
            io_i2c0_sda     : inout std_logic;

-- SPI Master 0 Interface
            o_spi0_sclk     : out std_logic;
            o_spi0_mosi     : out std_logic;
            i_spi0_miso     : in std_logic;
            o_spi0_ss_n     : out std_logic;

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


    signal          brd_rst : std_logic;
    signal      i_reset_n_r : std_logic;
    
-- {ALTERA_COMPONENTS_END} DO NOT REMOVE THIS LINE!
begin
-- {ALTERA_INSTANTIATION_BEGIN} DO NOT REMOVE THIS LINE!
	system_0: system
		port map (
-- BOARD
			brd_rst			=> brd_rst,
			brd_clk		    => i_brd_clk,
--			brd_clk_p		=> i_brd_clk_p,
--			brd_clk_n		=> i_brd_clk_n,

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

-- I2C Master 0 Master Interface
            o_i2c0_scl      => o_i2c0_scl,
            io_i2c0_sda     => io_i2c0_sda,

-- SPI Master 0 Interface
            o_spi0_sclk     => o_spi0_sclk,
            o_spi0_mosi     => o_spi0_mosi,
            i_spi0_miso     => i_spi0_miso,
            o_spi0_ss_n     => o_spi0_ss_n,

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
			mtx_clk_pad_i	=> i_mtx_clk,
			mtxd_pad_o		=> o_mtxd,
			mtxen_pad_o		=> o_mtxen,
			mtxerr_pad_o	=> o_mtxerr,
			mrx_clk_pad_i	=> i_mrx_clk,
			mrxd_pad_i		=> i_mrxd,
			mrxdv_pad_i		=> i_mrxdv,
			mrxerr_pad_i	=> i_mrxerr,
			mcoll_pad_i		=> i_mcoll,
			mcrs_pad_i		=> i_mcrs,
			md_pad_io		=> io_md,
			mdc_pad_o		=> o_mdc,
			phy_reset_n		=> o_phy_reset_n,

			led				=> o_led
	);

--	a23_core_0: a23_core 
--		port map (
--			i_clk			=>	C_40MHZ,
--			i_irq			=>	amber_i_irq,				-- Interrupt request, active high
--			i_firq			=>	amber_i_firq,				-- Fast Interrupt request, active high
--			i_system_rdy	=>	amber_i_system_rdy,		    -- Amber is stalled when this is low
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


    -- Synchronizing reset
    --
    reset_proc : process (i_brd_clk)
    begin
        if (rising_edge(i_brd_clk)) then
            brd_rst     <= i_reset_n_r;             monitor(2) <= i_reset_n_r;
            i_reset_n_r <= i_reset_n;               monitor(1) <= i_reset_n;
        end if;
    end process reset_proc;
    
    -- Monitoring
    --
    monitor(0)          <= i_reset_n;
    o_monitor           <= monitor;

-- {ALTERA_INSTANTIATION_END} DO NOT REMOVE THIS LINE!

end;
