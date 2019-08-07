--------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:   21:49:15 12/16/2015
-- Design Name:
-- Module Name:   tb_orologio_onBoard.vhd
-- Project Name:  exercise7
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: orologio_onBoard
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes:
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;

ENTITY tb_orologio_onBoard IS
END tb_orologio_onBoard;

ARCHITECTURE behavior OF tb_orologio_onBoard IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT orologio_onBoard
      PORT(
            clock : IN  std_logic;
            reset : IN  std_logic;
            enable : IN  std_logic;
            load_m : IN  std_logic;
            load_h : IN  std_logic;
            switch : IN  std_logic_vector(5 downto 0);
            cathodes : OUT  std_logic_vector(7 downto 0);
            anodes : OUT  std_logic_vector(3 downto 0);
            leds : OUT  std_logic_vector(5 downto 0)
         );
    END COMPONENT;


   --Inputs
   signal clock : std_logic := '0';
   signal reset : std_logic := '0';
   signal enable : std_logic := '0';
   signal load_m : std_logic := '0';
   signal load_h : std_logic := '0';
   signal switch : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal cathodes : std_logic_vector(7 downto 0);
   signal anodes : std_logic_vector(3 downto 0);
   signal leds : std_logic_vector(5 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: orologio_onBoard PORT MAP (
          clock => clock,
          reset => reset,
          enable => enable,
          load_m => load_m,
          load_h => load_h,
          switch => switch,
          cathodes => cathodes,
          anodes => anodes,
          leds => leds
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;


   -- Stimulus process
   stim_proc: process
   begin
      -- hold reset state for 100 ns.
      wait for 100 ns;

      wait for clock_period*10;

      -- insert stimulus here
		enable <= '1';
		load_m <= '1';
		switch <= "111011";
		wait for clock_period;
		load_m <= '0';

      wait;
   end process;

END;
