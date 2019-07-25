--------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:   14:03:40 11/25/2015
-- Design Name:
-- Module Name:   tb_moltiplicatore_booth.vhd
-- Project Name:  booth
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: moltiplicatore_Booth
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
USE ieee.numeric_std.ALL;

ENTITY tb_moltiplicatore_booth IS
END tb_moltiplicatore_booth;

ARCHITECTURE behavior OF tb_moltiplicatore_booth IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT moltiplicatore_booth
      generic(   n : natural := 4;
                  m : natural := 4);
      PORT(
            A : IN  std_logic_vector(n-1 downto 0);
            B : IN  std_logic_vector(m-1 downto 0);
            enable : IN  std_logic;
            reset_n : IN  std_logic;
            clock : IN  std_logic;
            done : OUT  std_logic;
            P : OUT  std_logic_vector(n+m-1 downto 0)
         );
    END COMPONENT;

	 constant n,m : natural := 8;

   --Inputs
   signal A : std_logic_vector(n-1 downto 0) := (others => '0');
   signal B : std_logic_vector(m-1 downto 0) := (others => '0');
   signal enable : std_logic := '0';
   signal reset_n : std_logic := '0';
   signal clock : std_logic := '0';

 	--Outputs
   signal done : std_logic;
   signal P : std_logic_vector(n+m-1 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: moltiplicatore_booth
		generic map(n,m)
		PORT MAP (
          A => A,
          B => B,
          enable => enable,
          reset_n => reset_n,
          clock => clock,
          done => done,
          P => P
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
		-- Test esaustivo
		for i in 0 to (2**n)-1 loop
			A <= A + 1;
			for j in 0 to (2**n)-1 loop
				reset_n <= '0';
				enable <= '1';
				wait for clock_period;
				reset_n <= '1';
				B <= B + 1;
				wait for clock_period;
				enable <= '0';
				wait until done = '1';
				assert P = std_logic_vector(signed(A)*signed(B)) report "Uncorrect result value" severity error;
				wait for 2*clock_period;
			end loop;
			B <= (B'range => '0');
		end loop;

--		 n = m = 4
		-- CASO KE DAVA ERRORE (NON FACCIO CORREZIONE FINALE DP SUB NEGATIVA)
--		reset_n <= '0';
--		enable <= '1';
--		wait for clock_period;
--		reset_n <= '1';
--		A <= "1100";
--		B <= "1111";
--		wait for clock_period;
--		enable <= '0';
--		wait until done = '1';
--		assert P = std_logic_vector(signed(A)*signed(B)) report "Uncorrect result value" severity error;
--
--		wait for 2*clock_period;
--		reset_n <= '0';
--		enable <= '1';
--		wait for clock_period;
--		reset_n <= '1';
--		A <= "0100";
--		B <= "1101";
--		wait for clock_period;
--		enable <= '0';
--		wait until done = '1';
--		assert P = std_logic_vector(signed(A)*signed(B)) report "Uncorrect result value" severity error;
--
--		wait for 2*clock_period;
--		reset_n <= '0';
--		enable <= '1';
--		wait for clock_period;
--		reset_n <= '1';
--		B <= "1011";
--		A <= "1011";
--		wait for clock_period;
--		enable <= '0';
--		wait until done = '1';
--		assert P = std_logic_vector(signed(A)*signed(B)) report "Uncorrect result value" severity error;
--
--		-- CASO PARTICOLARE: segno errato: estensione del segno (risolto con istruzione condizionata)
--		wait for 2*clock_period;
--		reset_n <= '0';
--		enable <= '1';
--		wait for clock_period;
--		reset_n <= '1';
--		A <= "1000";
--		B <= "0001";
--		wait for clock_period;
--		enable <= '0';
--		wait until done = '1';
--		assert P = std_logic_vector(signed(A)*signed(B)) report "Uncorrect result value" severity error;
--
--		-- CASO PARTICOLARE: segno errato: dovrebbe essere zero ma è 1 (risolto con xor)
--		wait for 2*clock_period;
--		reset_n <= '0';
--		enable <= '1';
--		wait for clock_period;
--		reset_n <= '1';
--		A <= "1000";
--		B <= "1000";
--		wait for clock_period;
--		enable <= '0';
--		wait until done = '1';
--		assert P = std_logic_vector(signed(A)*signed(B)) report "Uncorrect result value" severity error;
--
--		-- CASO PARTICOLARE: segno errato: dovrebbe essere zero ma è 1 (risolto con istruzione condizionata)
--		wait for 2*clock_period;
--		reset_n <= '0';
--		enable <= '1';
--		wait for clock_period;
--		reset_n <= '1';
--		A <= "0000";
--		B <= "1000";
--		wait for clock_period;
--		enable <= '0';
--		assert P = std_logic_vector(signed(A)*signed(B)) report "Uncorrect result value" severity error;

      wait;
   end process;

END;
