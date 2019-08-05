--------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:   11:22:53 12/09/2015
-- Design Name:
-- Module Name:   tb.vhd
-- Project Name:  exercise12
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: esercizio_2
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

ENTITY tb IS
END tb;

ARCHITECTURE behavior OF tb IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT esercizio_2
    PORT(
			en_n : IN std_logic;
         clock : OUT  std_logic
        );
    END COMPONENT;


 	--Outputs
   signal clock : std_logic;
   signal en_n : std_logic := '1';

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: esercizio_2 PORT MAP (
			en_n => en_n,
         clock => clock
        );



   -- Stimulus process
   stim_proc: process
   begin
      -- hold reset state for 100 ns.
      wait for 100 ns;

      -- insert stimulus here

		wait for 10000000 ns;

      wait;
   end process;

END;
