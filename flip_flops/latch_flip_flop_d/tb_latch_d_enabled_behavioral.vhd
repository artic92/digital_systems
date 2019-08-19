--------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:   17:48:59 11/07/2015
-- Design Name:
-- Module Name:   tb_latch_d_enabled_behavioral.vhd
-- Project Name:  latch_flip_flop_d
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: latch_d_enabled_behavioral
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

ENTITY tb_latch_d_enabled_behavioral IS
END tb_latch_d_enabled_behavioral;

ARCHITECTURE behavior OF tb_latch_d_enabled_behavioral IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT latch_d_enabled_behavioral
		PORT(
			data_in : IN  std_logic;
			enable : IN  std_logic;
			reset_n : IN  std_logic;
			data_out : OUT  std_logic
			);
    END COMPONENT;


   --Inputs
   signal data_in : std_logic := '0';
   signal enable : std_logic := '0';
   signal reset_n : std_logic := '0';

 	--Outputs
   signal data_out : std_logic;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: latch_d_enabled_behavioral PORT MAP (
          data_in => data_in,
          enable => enable,
          reset_n => reset_n,
          data_out => data_out
        );

   -- Stimulus process
   stim_proc: process
   begin
		-- hold reset state for 100 ns.
		wait for 100 ns;

		-- insert stimulus here

		-- Output: 0
		enable <= '0';
		reset_n <= '0';
		data_in <= '1';

		wait for 40 ns;

		-- Output: 0
		reset_n <= '1';
		data_in <= '1';

		wait for 40 ns;

		-- Output: 1
		enable <= '1';
		data_in <= '1';

		wait for 40 ns;

		-- Output: 0
		reset_n <= '0';
		data_in <= '1';

		wait for 40 ns;

		-- Output: 0
		reset_n <= '1';
		data_in <= '0';

		wait for 40 ns;

		-- Output: dovrebbe essere 1 ma non va ad 1 poichè d non è presente
		-- nella sensitivity list del componente
		data_in <= '1';

		wait for 40 ns;

		-- Output: 0
		enable <= '0';
		data_in <= '1';

		wait;
   end process;

END;
