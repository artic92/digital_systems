--------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:   14:03:40 11/25/2015
-- Design Name:
-- Module Name:   tb_divisore_restoring.vhd
-- Project Name:  restoring_divider
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: divisore_restoring
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
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;

ENTITY tb_divisore_restoring IS
END tb_divisore_restoring;

ARCHITECTURE behavior OF tb_divisore_restoring IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT divisore_restoring
		generic(n : natural := 4);
		PORT(
			D : IN  std_logic_vector((2*n)-2 downto 0);
			V : IN  std_logic_vector(n-1 downto 0);
			enable : IN  std_logic;
			reset_n : IN  std_logic;
			clock : IN  std_logic;
			div_per_zero : OUT  std_logic;
			done : OUT  std_logic;
			Q : OUT  std_logic_vector(n-1 downto 0);
			R : OUT  std_logic_vector(n-1 downto 0)
			);
    END COMPONENT;

	constant n : natural := 4;

   --Inputs
   signal D : std_logic_vector((2*n)-2 downto 0) := (others => '0');
   signal V : std_logic_vector(n-1 downto 0) := (others => '0');
   signal enable : std_logic := '0';
   signal reset_n : std_logic := '0';
   signal clock : std_logic := '0';

 	--Outputs
   signal done : std_logic;
   signal div_per_zero : std_logic;
   signal Q : std_logic_vector(n-1 downto 0);
   signal R : std_logic_vector(n-1 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: divisore_restoring
			generic map(n)
			PORT MAP (
			D => D,
			V => V,
			enable => enable,
			reset_n => reset_n,
			clock => clock,
			div_per_zero => div_per_zero,
			done => done,
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

      wait for clock_period*10;

      -- insert stimulus here
	   -- Exhaustive test
--		for j in 0 to (2**((2*n)-1))-2 loop
--			D <= D + 1;
--			for i in 0 to (2**n)-2 loop
--				V <= V + 1;
--				reset_n <= '0';
--				enable <= '1';
--				wait for clock_period;
--				reset_n <= '1';
--				wait for clock_period;
--				enable <= '0';
--				wait until done = '1';
--				-- Attenzione: ogni volta che il resto o il quoziente non può essere rappresentato su n bit viene restituito un errore
--				if(V /=  0) then
--					assert Q = (CONV_INTEGER(D)/CONV_INTEGER(V)) report "Uncorrect quozient value" severity error;
--					assert R = (CONV_INTEGER(D) REM CONV_INTEGER(V)) report "Uncorrect resto value" severity error;
--				end if;
--				wait for clock_period;
--			end loop;
--		end loop;

		-- Caso resto diverso da 0 e terminazione con sub (109/14)
		-- Q = 7, R = 11
		reset_n <= '0';
		enable <= '1';
		wait for clock_period;
		reset_n <= '1';
		D <= "1101101";
		V <= "1110";
		wait for clock_period;
		enable <= '0';
		wait until done = '1';
		assert Q = (CONV_INTEGER(D)/CONV_INTEGER(V)) report "Uncorrect quozient value" severity error;
		assert R = (CONV_INTEGER(D) REM CONV_INTEGER(V)) report "Uncorrect resto value" severity error;

		-- Caso resto diverso da 0 e terminazione con restoring (91/14)
		-- Q = 6, R = 7
		wait for clock_period;
		reset_n <= '0';
		enable <= '1';
		wait for clock_period;
		reset_n <= '1';
		D <= "1011011";
		V <= "1110";
		wait for clock_period;
		enable <= '0';
		wait until done = '1';
		assert Q = (CONV_INTEGER(D)/CONV_INTEGER(V)) report "Uncorrect quozient value" severity error;
		assert R = (CONV_INTEGER(D) REM CONV_INTEGER(V)) report "Uncorrect resto value" severity error;

		-- Caso resto uguale a 0 e terminazione con restoring (4/2)
		-- Q = 2, R = 0
		wait for clock_period;
		reset_n <= '0';
		enable <= '1';
		wait for clock_period;
		reset_n <= '1';
		D <= "0000100";
		V <= "0010";
		wait for clock_period;
		enable <= '0';
		wait until done = '1';
		assert Q = (CONV_INTEGER(D)/CONV_INTEGER(V)) report "Uncorrect quozient value" severity error;
		assert R = (CONV_INTEGER(D) REM CONV_INTEGER(V)) report "Uncorrect resto value" severity error;

		-- Caso resto uguale a 0 e terminazione con sub (25/5)
		-- Q = 5, R = 0
		wait for clock_period;
		reset_n <= '0';
		enable <= '1';
		wait for clock_period;
		reset_n <= '1';
		D <= "0011001";
		V <= "0101";
		wait for clock_period;
		enable <= '0';
		wait until done = '1';
		assert Q = (CONV_INTEGER(D)/CONV_INTEGER(V)) report "Uncorrect quozient value" severity error;
		assert R = (CONV_INTEGER(D) REM CONV_INTEGER(V)) report "Uncorrect resto value" severity error;

		-- Caso resto diverso da 0 e terminazione con sub (2/3)
		-- Q = 0, R = 2
		reset_n <= '0';
		enable <= '1';
		wait for clock_period;
		reset_n <= '1';
		D <= "0000010";
		V <= "0011";
		wait for clock_period;
		enable <= '0';
		wait until done = '1';
		assert Q = (CONV_INTEGER(D)/CONV_INTEGER(V)) report "Uncorrect quozient value" severity error;
		assert R = (CONV_INTEGER(D) REM CONV_INTEGER(V)) report "Uncorrect resto value" severity error;

		-- Caso divisione per 0
		-- Q = 0, R = 0, div_per_zero = 1
		wait for clock_period;
		reset_n <= '0';
		enable <= '1';
		wait for clock_period;
		reset_n <= '1';
		D <= "0000100";
		V <= "0000";
		wait for clock_period;
		enable <= '0';
		wait until done = '1';

		-- Caso dividendo 0
		-- Q = 0, R = 0
		wait for clock_period;
		reset_n <= '0';
		enable <= '1';
		wait for clock_period;
		reset_n <= '1';
		D <= "0000000";
		V <= "0100";
		wait for clock_period;
		enable <= '0';
		wait until done = '1';
		assert Q = (CONV_INTEGER(D)/CONV_INTEGER(V)) report "Uncorrect quozient value" severity error;
		assert R = (CONV_INTEGER(D) REM CONV_INTEGER(V)) report "Uncorrect resto value" severity error;

      wait;
   end process;

END;
