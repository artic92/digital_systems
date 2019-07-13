--------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:   08:59:48 11/13/2015
-- Design Name:
-- Module Name:   tb_carry_ripple_n_bit.vhd
-- Project Name:  carry_ripple
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: ripple_carry_adder
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
use IEEE.std_logic_signed.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;

ENTITY tb_carry_ripple_n_bit IS
END tb_carry_ripple_n_bit;

ARCHITECTURE behavior OF tb_carry_ripple_n_bit IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT ripple_carry_adder
      generic (n : natural := 4);
      PORT(
            A : IN  std_logic_vector(n-1 downto 0);
            B : IN  std_logic_vector(n-1 downto 0);
            c_in : IN  std_logic;
            ovfl : OUT  std_logic;
            S : OUT  std_logic_vector(n-1 downto 0)
         );
    END COMPONENT;

    constant n : natural := 8;

   --Inputs
   signal A : std_logic_vector(n-1 downto 0) := (others => '0');
   signal B : std_logic_vector(n-1 downto 0) := (others => '0');
   signal c_in : std_logic := '0';

 	--Outputs
   signal ovfl : std_logic;
   signal S : std_logic_vector(n-1 downto 0);

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: ripple_carry_adder
	generic map(n => 8)
	PORT MAP (
          A => A,
          B => B,
          c_in => c_in,
          ovfl => ovfl,
          S => S
        );

   -- Stimulus process
   stim_proc: process
   begin
      -- hold reset state for 100 ns.
      wait for 100 ns;

      -- insert stimulus here
		-- Test esaustivo
		-- NB: l'assert non restituisce errore poichè la somma tra A e B viene convertita in uno std_logic_vector della
		-- stessa dimensione di S (n-1 bit). Pertanto, anche se una particolare somma richiede un numero superiore di
		-- bit, quello che viene trasferito in S sono i primi n-1 bit. Quindi l'assert verifica solo i primi n-1 bit della somma
		-- e non restituisce errore.
		for j in 0 to (2**n)-1 loop
			A <= A + 1;
			for i in 0 to (2**n)-1 loop
				B <= B + 1;
				wait for 20 ns;
				assert S = (A + B) report "Uncorrect value" severity error;
			end loop;
		end loop;

      wait;
   end process;

END;
