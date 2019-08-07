--------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:   12:02:45 12/14/2015
-- Design Name:
-- Module Name:   tb_pattern_generator.vhd
-- Project Name:  exercise3
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: pattern_generator
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

ENTITY tb_pattern_generator IS
END tb_pattern_generator;

ARCHITECTURE behavior OF tb_pattern_generator IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT pattern_generator
    PORT(
         clock : IN  std_logic;
         pattern : OUT  std_logic;
			clk90 : out STD_LOGIC;
			clk180 : out STD_LOGIC;
			clk270 : out STD_LOGIC;
			clk360 : out STD_LOGIC
        );
    END COMPONENT;


   --Inputs
   signal clock : std_logic := '0';

 	--Outputs
   signal pattern : std_logic;
   signal clk90 : std_logic;
   signal clk180 : std_logic;
   signal clk270 : std_logic;
   signal clk360 : std_logic;

   -- Clock period definitions
   constant clock_period : time := 10 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: pattern_generator PORT MAP (
          clock => clock,
          pattern => pattern,
          clk90 => clk90,
          clk180 => clk180,
          clk270 => clk270,
          clk360 => clk360
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

      wait;
   end process;

END;
