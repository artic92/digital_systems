--------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:   19:45:37 11/20/2015
-- Design Name:
-- Module Name:
-- Project Name:  Moltiplicatore
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: moltiplicatore_somma_per_righe
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

ENTITY tb_moltiplicatore_mac IS
END tb_moltiplicatore_mac;

ARCHITECTURE behavior OF tb_moltiplicatore_mac IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT moltiplicatore_mac
      generic(   n : natural := 8;
                  m : natural := 8);
      Port ( A : in  STD_LOGIC_VECTOR (n-1 downto 0);
            B : in  STD_LOGIC_VECTOR (m-1 downto 0);
            P : out  STD_LOGIC_VECTOR (n+m-1 downto 0));
    END COMPONENT;

	 constant n,m : natural := 16;

   --Inputs
   signal A : std_logic_vector(n-1 downto 0) := (others => '0');
   signal B : std_logic_vector(m-1 downto 0) := (others => '0');

 	--Outputs
   signal P : std_logic_vector(n+m-1 downto 0);

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: moltiplicatore_mac
		generic map(n, m)
		PORT MAP (
          A => A,
          B => B,
          P => P
        );

   -- Stimulus process
   stim_proc: process
   begin
      -- hold reset state for 100 ns.
      wait for 100 ns;

--		A <= x"02";
--		B <= x"02";

      -- insert stimulus here
		-- Test esaustivo
		for i in 0 to (2**n)-1 loop
			A <= A + 1;
			for j in 0 to (2**n)-1 loop
				B <= B + 1;
				wait for 20 ns;
				assert P = std_logic_vector(A*B) report "Uncorrect result value" severity error;
			end loop;
			B <= (B'range => '0');
		end loop;

      wait;
   end process;

END;
