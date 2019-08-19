--------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:   18:20:44 11/06/2015
-- Design Name:
-- Module Name:   tb_flip_flop_d_behavioral.vhd
-- Project Name:  latch_flip_flop_d
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: flip_flop_d_behavioral
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

ENTITY tb_flip_flop_d_behavioral IS
END tb_flip_flop_d_behavioral;

ARCHITECTURE behavior OF tb_flip_flop_d_behavioral IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT flip_flop_d_behavioral
      PORT(
            data_in : IN  std_logic;
            reset_n : IN  std_logic;
            clock : IN  std_logic;
            data_out : OUT  std_logic
         );
    END COMPONENT;


   --Inputs
   signal data_in : std_logic := '0';
   signal reset_n : std_logic := '0';
   signal clock : std_logic := '0';

 	--Outputs
   signal data_out : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: flip_flop_d_behavioral PORT MAP (
          data_in => data_in,
          reset_n => reset_n,
          clock => clock,
          data_out => data_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clock <= '0';
		wait for clk_period/2;
		clock <= '1';
		wait for clk_period/2;
   end process;


   -- Stimulus process
   stim_proc: process
   begin
      -- hold reset state for 50 ns.
      wait for 50 ns;

      -- insert stimulus here

		-- Output 0
		data_in <= '1';
		reset_n <= '0';
		wait for 20 ns;

		-- Output 1
		reset_n <= '1';
		wait for 20 ns;

		-- Output 0
		data_in <= '0';
		wait for 20 ns;

      wait;
   end process;

END;
