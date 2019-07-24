--------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:   14:16:34 11/15/2015
-- Design Name:
-- Module Name:   tb_carry_save_n_bit.vhd
-- Project Name:  carry_save
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: carry_save_n_bit
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

ENTITY tb_carry_save_n_bit IS
END tb_carry_save_n_bit;

ARCHITECTURE behavior OF tb_carry_save_n_bit IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT carry_save_n_bit
      generic ( n : natural := 8 );
      PORT(
            A : IN  std_logic_vector(n-1 downto 0);
            B : IN  std_logic_vector(n-1 downto 0);
            C : IN  std_logic_vector(n-1 downto 0);
            S : OUT  std_logic_vector(n+1 downto 0)
         );
    END COMPONENT;

	 constant n : natural := 4;

   --Inputs
   signal A : std_logic_vector(n-1 downto 0) := (others => '0');
   signal B : std_logic_vector(n-1 downto 0) := (others => '0');
   signal C : std_logic_vector(n-1 downto 0) := (others => '0');

 	--Outputs
   signal S : std_logic_vector(n+1 downto 0);

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: carry_save_n_bit
		generic map(n)
		PORT MAP (
          A => A,
          B => B,
          C => C,
          S => S
        );

   -- Stimulus process
   stim_proc: process

	variable err_cnt: integer :=0;

   begin
      -- hold reset state for 100 ns.
      wait for 100 ns;

		-- insert stimulus here
		-- Test esaustivo
		for j in 0 to (2**n)-1 loop
			A <= A + 1;
			for i in 0 to (2**n)-1 loop
				B <= B + 1;
				for k in 0 to (2**n)-1 loop
					C <= C + 1;
					wait for 20 ns;
					assert S = (A + B + C) report "Uncorrect value" severity error;
				end loop;
			end loop;
		end loop;

--		C <= x"00";
--
--		-- test 1
--		A <= x"01";
--		B <= x"02";
--		wait for 20 ns;
--
--		-- test 2
--		A <= x"FF";
--		B <= x"01";
--		wait for 20 ns;
--
--		-- test 3
--		A <= x"01";
--		B <= x"FF";
--		wait for 20 ns;
--
--		-- test 4
--		A <= x"0F";
--		B <= x"F0";
--		wait for 20 ns;
--
--		-- test 5
--		A <= x"FF";
--		B <= x"FF";
--		C <= x"FF";
--		wait for 20 ns;

      wait;
   end process;

END;
