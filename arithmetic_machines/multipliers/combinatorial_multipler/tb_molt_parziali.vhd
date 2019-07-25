--------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:   12:31:30 11/18/2015
-- Design Name:
-- Module Name:   tb_molt_parziali.vhd
-- Project Name:  combinatorial_multiplier
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: prodotto_parziale
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

ENTITY tb_molt_parziali IS
END tb_molt_parziali;

ARCHITECTURE behavior OF tb_molt_parziali IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT prodotto_parziale
      generic (  n: natural := 4;
                  m : natural := 4);
      PORT(
            A : IN  std_logic_vector(n-1 downto 0);
            B : IN  std_logic_vector(m-1 downto 0);
            O : OUT  std_logic_vector(n*m-1 downto 0)
         );
    END COMPONENT;

	 constant n : natural := 4;
	 constant m : natural := 3;

   --Inputs
   signal A : std_logic_vector(n-1 downto 0) := (others => '0');
   signal B : std_logic_vector(m-1 downto 0) := (others => '0');

 	--Outputs
   signal O : std_logic_vector(n*m-1 downto 0);

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: prodotto_parziale
		generic map(n, m)
		PORT MAP (
          A => A,
          B => B,
          O => O
        );

   -- Stimulus process
   stim_proc: process
   begin
      -- hold reset state for 100 ns.
      wait for 100 ns;

      -- insert stimulus here
--		A <= "1010";
--		B <= "1000";
--		wait for 20 ns;
--
--		A <= "1111";
--		B <= "1111";
--		wait for 20 ns;

		A <= "1010";
		B <= "100";
		wait for 20 ns;

		A <= "1111";
		B <= "111";
		wait for 20 ns;

		A <= "1010";
		B <= "000";
		wait for 20 ns;

      wait;
   end process;

END;
