-- TestBench

library ieee;
use ieee.std_logic_1164.all;
library altera;
use altera.altera_syn_attributes.all;

entity tb_top is
	port
	(
            tb_state        : out std_logic
	);
end tb_top;

architecture HIERARCHICAL of tb_top is
	component top
		port (
-- Reset Pin
            i_reset_n		: in std_logic;

-- Clock from oscillator
            i_brd_clk		: in std_logic;
--		    i_brd_clk_p		: in std_logic;
--		    i_brd_clk_n		: in std_logic;

-- Status LEDs
            o_led			: out std_logic_vector (3 downto 0);
		
-- UART 0 Interface
			i_uart0_rts		: in std_logic;
			o_uart0_rx		: out std_logic;
			o_uart0_cts		: out std_logic;
			i_uart0_tx		: in std_logic;

-- UART 1 Interface
--			i_uart1_rts		: in std_logic;
--			o_uart1_rx		: out std_logic;
--			o_uart1_cts		: out std_logic;
--			i_uart1_tx		: in std_logic;

-- I2C Master 0 Master Interface
            o_i2c0_scl      : out std_logic;
            io_i2c0_sda     : inout std_logic;

-- SPI Master 0 Interface
            o_spi0_sclk     : out std_logic;
            o_spi0_mosi     : out std_logic;
            i_spi0_miso     : in std_logic;
            o_spi0_ss_n     : out std_logic;

-- Xilinx Spartan 6 MCB DDR3 Interface
--		    io_ddr3_dq		: inout std_logic_vector (15 downto 0);
--		    o_ddr3_addr		: out std_logic_vector (12 downto 0);
--		    o_ddr3_ba		: out std_logic_vector (2 downto 0);
--		    o_ddr3_ras_n	: out std_logic;
--		    o_ddr3_cas_n	: out std_logic;
--		    o_ddr3_we_n		: out std_logic;
--		    o_ddr3_odt		: out std_logic;
--		    o_ddr3_reset_n	: out std_logic;
--		    o_ddr3_cke		: out std_logic;
--		    o_ddr3_dm		: out std_logic_vector (1 downto 0);
--		    io_ddr3_dqs_p	: inout std_logic_vector (1 downto 0);
--	    	io_ddr3_dqs_n	: inout std_logic_vector (1 downto 0);
--		    o_ddr3_ck_p		: out std_logic;
--		    o_ddr3_ck_n		: out std_logic;
-- ifdef XILINX_SPARTAN6_FPGA
--		    io_mcb3_rzq		: inout std_logic;
-- endif

-- Altera SRAM 2Mx8 Interface
			o_sram_cs_n		: out std_logic_vector (3 downto 0);
			o_sram_read_n	: out std_logic;
			o_sram_write_n	: out std_logic;
			o_sram_addr		: out std_logic_vector (20 downto 0);
			io_sram_data	: inout std_logic_vector (7 downto 0);

-- Ethmac B100 MAC to PHY Interface
            i_mtx_clk_pad_i	: in std_logic;
            o_mtxd_pad_o	: out std_logic_vector (3 downto 0);
            o_mtxen_pad_o	: out std_logic;
            o_mtxerr_pad_o	: out std_logic;
            i_mrx_clk_pad_i	: in std_logic;
            i_mrxd_pad_i	: in std_logic_vector (3 downto 0);
            i_mrxdv_pad_i	: in std_logic;
            i_mrxerr_pad_i	: in std_logic;
            i_mcoll_pad_i	: in std_logic;
            i_mcrs_pad_i	: in std_logic;
            io_md_pad_io	: inout std_logic;
            o_mdc_pad_o		: out std_logic;
            o_phy_reset_n	: out std_logic;

-- JTAG Interface
        altera_reserved_tck : in std_logic;
        altera_reserved_tdi : in std_logic;
        altera_reserved_tms : in std_logic;
        altera_reserved_tdo : out std_logic
	);
	end component;


    -- Inputs
    signal i_reset_n                    : std_logic;
    signal i_brd_clk                    : std_logic;
    signal i_uart0_tx                   : std_logic;
    signal i_uart0_rts                  : std_logic;
    signal i_spi0_miso                  : std_logic;
    signal i_mtx_clk_pad_i              : std_logic;
    signal i_mrx_clk_pad_i              : std_logic;
    signal i_mrxd_pad_i                 : std_logic_vector( 3 downto 0);
    signal i_mrxdv_pad_i                : std_logic;
    signal i_mrxerr_pad_i               : std_logic;
    signal i_mcoll_pad_i                : std_logic;
    signal i_mcrs_pad_i                 : std_logic;
    signal altera_reserved_tck          : std_logic;
    signal altera_reserved_tdi          : std_logic;
    signal altera_reserved_tms          : std_logic;

    -- Outputs and Inouts
    signal o_led                        : std_logic_vector( 3 downto 0);
    signal o_uart0_rx                   : std_logic;
    signal o_uart0_cts                  : std_logic;
    signal o_i2c0_scl                   : std_logic;
    signal io_i2c0_sda                  : std_logic;
    signal o_spi0_sclk                  : std_logic;
    signal o_spi0_mosi                  : std_logic;
    signal o_spi0_ss_n                  : std_logic;
    signal o_sram_cs_n                  : std_logic_vector( 3 downto 0);
    signal o_sram_read_n                : std_logic;
    signal o_sram_write_n               : std_logic;
    signal o_sram_addr                  : std_logic_vector(20 downto 0);
    signal io_sram_data                 : std_logic_vector( 7 downto 0);
    signal o_mtxd_pad_o                 : std_logic_vector( 3 downto 0);
    signal o_mtxen_pad_o                : std_logic;
    signal o_mtxerr_pad_o               : std_logic;
    signal io_md_pad_io                 : std_logic;
    signal o_mdc_pad_o                  : std_logic;
    signal o_phy_reset_n                : std_logic;
    signal altera_reserved_tdo          : std_logic;

    -- Clock period definitions
    constant i_brd_clk_period           : time := 40ns;

BEGIN

    -- Instantiate the Unit Under Test (DUT)
    dut: top 
        port map (
 
-- Reset Pin
		i_reset_n			=> i_reset_n,

-- Clock from oscillator
		i_brd_clk			=> i_brd_clk,
--		i_brd_clk_p			=> i_brd_clk_p,
--		i_brd_clk_n			=> i_brd_clk_n,

-- Status LEDs
		o_led				=> o_led,

-- UART 0 Interface
		i_uart0_tx			=> i_uart0_tx,
		o_uart0_rx			=> o_uart0_rx,
		i_uart0_rts			=> i_uart0_rts,
		o_uart0_cts			=> o_uart0_cts,

-- UART 1 Interface
--		i_uart1_tx			=> i_uart1_tx,
--		o_uart1_rx			=> o_uart1_rx,
--		i_uart1_rts			=> i_uart1_rts,
--		o_uart1_cts			=> o_uart1_cts,

-- I2C Master 0 Master Interface
        o_i2c0_scl          => o_i2c0_scl,
        io_i2c0_sda         => io_i2c0_sda,

-- SPI Master 0 Interface
        o_spi0_sclk         => o_spi0_sclk,
        o_spi0_mosi         => o_spi0_mosi,
        i_spi0_miso         => i_spi0_miso,
        o_spi0_ss_n         => o_spi0_ss_n,

-- Xilinx Spartan 6 MCB DDR3 Interface
--		io_ddr3_dq			=> io_ddr3_dq,
--		o_ddr3_addr			=> o_ddr3_addr,
--		o_ddr3_ba			=> o_ddr3_ba,
--		o_ddr3_ras_n		=> o_ddr3_ras_n,
--		o_ddr3_cas_n		=> o_ddr3_cas_n,
--		o_ddr3_we_n			=> o_ddr3_we_n,
--		o_ddr3_odt			=> o_ddr3_odt,
--		o_ddr3_reset_n		=> o_ddr3_reset_n,
--		o_ddr3_cke			=> o_ddr3_cke,
--		o_ddr3_dm			=> o_ddr3_dm,
--		io_ddr3_dqs_p		=> io_ddr3_dqs_p,
--		io_ddr3_dqs_n		=> io_ddr3_dqs_n,
--		o_ddr3_ck_p			=> o_ddr3_ck_p,
--		o_ddr3_ck_n			=> o_ddr3_ck_n,
-- ifdef XILINX_SPARTAN6_FPGA
--		io_mcb3_rzq			=> io_mcb3_rzq,
-- endif

-- Altera SRAM 2Mx8 Interface
		o_sram_cs_n			=> o_sram_cs_n,
		o_sram_read_n		=> o_sram_read_n,
		o_sram_write_n		=> o_sram_write_n,
		o_sram_addr			=> o_sram_addr,
		io_sram_data		=> io_sram_data,

-- Ethmac B100 MAC to PHY Interface
		i_mtx_clk_pad_i	    => i_mtx_clk_pad_i,
		o_mtxd_pad_o		=> o_mtxd_pad_o,
		o_mtxen_pad_o		=> o_mtxen_pad_o,
		o_mtxerr_pad_o		=> o_mtxerr_pad_o,
		i_mrx_clk_pad_i	    => i_mrx_clk_pad_i,
		i_mrxd_pad_i		=> i_mrxd_pad_i,
		i_mrxdv_pad_i		=> i_mrxdv_pad_i,
		i_mrxerr_pad_i		=> i_mrxerr_pad_i,
		i_mcoll_pad_i		=> i_mcoll_pad_i,
		i_mcrs_pad_i		=> i_mcrs_pad_i,
		io_md_pad_io		=> io_md_pad_io,
		o_mdc_pad_o			=> o_mdc_pad_o,
		o_phy_reset_n		=> o_phy_reset_n,

-- JTAG Interface
        altera_reserved_tck => altera_reserved_tck,
        altera_reserved_tdi => altera_reserved_tdi,
        altera_reserved_tms => altera_reserved_tms,
        altera_reserved_tdo => altera_reserved_tdo
    );

    -- Clock process definitions
    brd_clk_proc: process
    begin
        i_brd_clk <= '0';
        wait for i_brd_clk_period/2;
        i_brd_clk <= '1';
        wait for i_brd_clk_period/2;
    end process brd_clk_proc;

    -- MII clock process definitions
    mii_clk_proc: process
    begin
		i_mtx_clk_pad_i	    <= '0';
        wait for 0.2ns;
		i_mrx_clk_pad_i	    <= '0';
        wait for 19.8ns;

		i_mtx_clk_pad_i	    <= '1';
        wait for 0.2ns;
		i_mrx_clk_pad_i	    <= '1';
        wait for 19.8ns;
    end process mii_clk_proc;

    -- Stimulus process
    stim_proc: process
    begin
        -- hold reset state for 100 ms
        i_reset_n           <= '0';

		i_uart0_tx			<= '1';
		i_uart0_rts			<= '1';

        io_i2c0_sda         <= 'H';

        i_spi0_miso         <= '0';

  		io_sram_data		<= "XXXXXXXX";

		i_mrxd_pad_i		<= "0000";
		i_mrxdv_pad_i		<= '0';
		i_mrxerr_pad_i		<= '0';
		i_mcoll_pad_i		<= '0';
		i_mcrs_pad_i		<= '0';
		io_md_pad_io		<= 'H';

        altera_reserved_tck <= 'H';
        altera_reserved_tdi <= 'H';
        altera_reserved_tms <= 'H';

        wait for 100ms;

        -- more stimulus to be added HERE


        wait;
    end process stim_proc;

    tb_state <= '0';
END;
