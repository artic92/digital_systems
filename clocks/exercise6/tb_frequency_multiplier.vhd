--------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:   22:21:27 12/16/2015
-- Design Name:
-- Module Name:   tb_frequency_multiplier.vhd
-- Project Name:  exercise6
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: freq_multiplier
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

ENTITY tb_frequency_multiplier IS
END tb_frequency_multiplier;

ARCHITECTURE behavior OF tb_frequency_multiplier IS

    -- Component Declaration for the Unit Under Test (UUT)

   COMPONENT freq_multiplier
	   generic ( periodo_freq_in : time := 10 ns;
						mult_factor : natural := 2 );
      PORT( enable : IN  std_logic;
            clock : IN  std_logic;
            clock_out : OUT  std_logic
         );
    END COMPONENT;


   --Inputs
   signal enable : std_logic := '0';
   signal clock : std_logic := '0';

 	--Outputs
   signal clock_out : std_logic;

   -- Clock period definitions
   constant clock_period : time := 10 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: freq_multiplier
	generic map (clock_period, 2)
	PORT MAP (
          enable => enable,
          clock => clock,
          clock_out => clock_out
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

      wait;
   end process;

END;
