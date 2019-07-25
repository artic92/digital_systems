--------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:   16:17:20 11/18/2015
-- Design Name:
-- Module Name:   tb_somma_righe.vhd
-- Project Name:  combinatorial_multiplier
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: somma_righe
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

ENTITY tb_somma_righe IS
END tb_somma_righe;

ARCHITECTURE behavior OF tb_somma_righe IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT somma_righe
		generic ( 	n: natural := 4;
					m : natural := 4);
		PORT(	PROD_PARZIALI : IN  std_logic_vector(n*m-1 downto 0);
				P : OUT  std_logic_vector(n+m-1 downto 0));
    END COMPONENT;

	constant n : natural := 3;
	constant m : natural := 4;

	--Inputs
	signal PROD_PARZIALI : std_logic_vector(n*m-1 downto 0) := (others => '0');
	signal P : std_logic_vector(n+m-1 downto 0) := (others => '0');

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: somma_righe
		generic map(n, m)
		PORT MAP (
          PROD_PARZIALI => PROD_PARZIALI,
          P => P
        );

   -- Stimulus process
   stim_proc: process

	variable err_cnt : natural := 0;

   begin
      -- hold reset state for 100 ns.
      wait for 100 ns;

      -- insert stimulus here
		-- test 1 (n = m = 4) (1010*1000)
--		PROD_PARZIALI <= "1010000000000000";
--		wait for 20 ns;
--		assert (P = "01010000") report "Test1 Failed!" severity error;
--		if (P /= "01010000") then
--	    err_cnt := err_cnt+1;
--		end if;

		-- test 2 (n = 4, m = 3)(1010*100)
--		PROD_PARZIALI <= "101000000000";
--		wait for 20 ns;
--		assert (P = "0101000") report "Test Failed!" severity error;
--		if (P /= "0101000") then
--	    err_cnt := err_cnt+1;
--		end if;

		-- test 3 (n = 3, m = 4)(110*1100)
		PROD_PARZIALI <= "110110000000";
		wait for 20 ns;
		assert (P = "1001000") report "Test Failed!" severity error;
		if (P /= "1001000") then
	    err_cnt := err_cnt+1;
		end if;

		-- test 4 (n = 3, m = 4)(111*1111)
		PROD_PARZIALI <= "111111111111";
		wait for 20 ns;
		assert (P = "1101001") report "Test Failed!" severity error;
		if (P /= "1101001") then
	    err_cnt := err_cnt+1;
		end if;

		-- summary of all the tests
		if (err_cnt=0) then
			assert false
			report "Testbench of carry select adder completely successfully!"
			severity note;
		else
			assert true
			report "Something wrong, check again pls!"
			severity error;
		end if;

      wait;
   end process;

END;
