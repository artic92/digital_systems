--------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:   19:53:30 12/11/2015
-- Design Name:
-- Module Name:   tb_clock_shifter.vhd
-- Project Name:  exercise4
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: clock_shifter
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

ENTITY tb_clock_shifter IS
END tb_clock_shifter;

ARCHITECTURE behavior OF tb_clock_shifter IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT clock_shifter
      generic ( clock_period : time := 230 ns );
      PORT(
            enable : IN  std_logic;
            clk_base : IN  std_logic;
            clk90 : OUT  std_logic;
            clk180 : OUT  std_logic;
            clk270 : OUT  std_logic;
            clk2x : OUT  std_logic
         );
    END COMPONENT;

	 -- NB. Quella Behavioral richiede il generic mentre la structural no
--	for all : clock_shifter use entity work.clock_shifter(Behavioral);
	for all : clock_shifter use entity work.clock_shifter(Structural);

   --Inputs
   signal en : std_logic := '0';
   signal clk_base : std_logic := '0';
   signal clk_base_sig : std_logic := '0';

 	--Outputs
   signal clk90 : std_logic;
   signal clk180 : std_logic;
   signal clk270 : std_logic;
   signal clk2x : std_logic;

   -- Clock period definitions
   constant clk_base_period : time := 10 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: clock_shifter
	generic map(clk_base_period)
	PORT MAP (
          enable => en,
          clk_base => clk_base_sig,
          clk90 => clk90,
          clk180 => clk180,
          clk270 => clk270,
          clk2x => clk2x
        );

   -- Clock process definitions
   clk_base_process :process
   begin
		clk_base <= '0';
		wait for clk_base_period/2;
		clk_base <= '1';
		wait for clk_base_period/2;
   end process;
	clk_base_sig <= not clk_base;

   -- Stimulus process
   stim_proc: process
   begin
      -- hold reset state for 100 ns.
      wait for 100 ns;

      wait for clk_base_period*10;

      -- insert stimulus here
		en <= '1';

      wait;
   end process;

END;
