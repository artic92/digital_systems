--------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:   14:50:11 11/30/2015
-- Design Name:
-- Module Name:   tb_divisore_complementi_a_1.vhd
-- Project Name:  divider_1s_complement
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: divisore_complementi_a_1
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

ENTITY tb_divisore_complementi_a_1 IS
END tb_divisore_complementi_a_1;

ARCHITECTURE behavior OF tb_divisore_complementi_a_1 IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT divisore_complementi_a_1
      PORT(
            D : IN  std_logic_vector(7 downto 0);
            V : IN  std_logic_vector(3 downto 0);
            enable : IN  std_logic;
            reset_n : IN  std_logic;
            clock : IN  std_logic;
            done : OUT  std_logic;
            div_per_zero : OUT  std_logic;
            Q : OUT  std_logic_vector(3 downto 0);
            R : OUT  std_logic_vector(3 downto 0)
         );
    END COMPONENT;


   --Inputs
   signal D : std_logic_vector(7 downto 0) := (others => '0');
   signal V : std_logic_vector(3 downto 0) := (others => '0');
   signal enable : std_logic := '0';
   signal reset_n : std_logic := '0';
   signal clock : std_logic := '0';

 	--Outputs
   signal done : std_logic;
   signal div_per_zero : std_logic;
   signal Q : std_logic_vector(3 downto 0);
   signal R : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: divisore_complementi_a_1 PORT MAP (
          D => D,
          V => V,
          enable => enable,
          reset_n => reset_n,
          clock => clock,
          done => done,
          div_per_zero => div_per_zero,
          Q => Q,
          R => R
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

--      wait for clock_period*10;

      -- insert stimulus here
		reset_n <= '0';
		enable <= '1';
		wait for clock_period;
		reset_n <= '1';
		D <= "00000101";
		V <= "0000";
		wait for clock_period;
		enable <= '0';

		wait for 200 ns;
		reset_n <= '0';
		enable <= '1';
		wait for clock_period;
		reset_n <= '1';
		D <= "00000100";
		V <= "1010";
		wait for clock_period;
		enable <= '0';

		wait for 200 ns;
		reset_n <= '0';
		enable <= '1';
		wait for clock_period;
		reset_n <= '1';
		D <= "00000100";
		V <= "0010";
		wait for clock_period;
		enable <= '0';

		wait for 200 ns;
		reset_n <= '0';
		enable <= '1';
		wait for clock_period;
		reset_n <= '1';
		D <= "10000100";
		V <= "0010";
		wait for clock_period;
		enable <= '0';

      wait;
   end process;

END;
