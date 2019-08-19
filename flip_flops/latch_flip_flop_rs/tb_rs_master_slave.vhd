--------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:   15:50:27 11/12/2012
-- Design Name:
-- Module Name:   tb_rs_master_slave.vhd
-- Project Name:  latch_flip_flop_rs
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: rs_master_slave
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

ENTITY tb_rs_master_slave IS
END tb_rs_master_slave;

ARCHITECTURE behavior OF tb_rs_master_slave IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT rs_master_slave
      PORT(
            R : IN  std_logic;
            S : IN  std_logic;
            clock : IN  std_logic;
            Q : OUT  std_logic;
            NQ : OUT  std_logic
         );
    END COMPONENT;


   --Inputs
   signal R : std_logic := '0';
   signal S : std_logic := '0';
   signal clock : std_logic := '0';

 	--Outputs
   signal Q : std_logic;
   signal NQ : std_logic;

   -- Clock period definitions
   constant clock_period : time := 10 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: rs_master_slave PORT MAP (
          R => R,
          S => S,
          clock => clock,
          Q => Q,
          NQ => NQ
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

		r <= '0';
		s <= '0';
		wait for clock_period*2;

      s <= '1';

      wait for clock_period*4;

		s <= '0';
      r <= '1';

      wait for clock_period*4;

		s <= '1';

      wait for clock_period*4;

		r <= '0';

		wait for clock_period*4;

		s <= '0';
		r <= '1';

      wait for clock_period;

		s <= '1';

		wait for clock_period*10;

		r <= '0';

      wait;
   end process;

END;
