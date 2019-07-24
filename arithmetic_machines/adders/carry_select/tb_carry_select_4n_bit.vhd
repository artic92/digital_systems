--------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:   12:48:34 11/15/2015
-- Design Name:
-- Module Name:   tb_carry_select_4n_bit.vhd
-- Project Name:  carry_select
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: carry_select_4n_bit
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

ENTITY tb_carry_select_4n_bit IS
END tb_carry_select_4n_bit;

ARCHITECTURE behavior OF tb_carry_select_4n_bit IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT carry_select_4n_bit
		PORT(
			A : IN  std_logic_vector(7 downto 0);
			B : IN  std_logic_vector(7 downto 0);
			c_in : IN  std_logic;
			ovfl : OUT  std_logic;
			S : OUT  std_logic_vector(7 downto 0)
			);
    END COMPONENT;


   --Inputs
   signal A : std_logic_vector(7 downto 0) := (others => '0');
   signal B : std_logic_vector(7 downto 0) := (others => '0');
   signal c_in : std_logic := '0';

 	--Outputs
   signal ovfl : std_logic;
   signal S : std_logic_vector(7 downto 0);

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   	uut: carry_select_4n_bit PORT MAP (
          A => A,
          B => B,
          c_in => c_in,
          ovfl => ovfl,
          S => S
        );

   	-- Stimulus process
   	stim_proc: process

	variable err_cnt: integer :=0;

	begin
		-- hold reset state for 100 ns.
		wait for 100 ns;

		-- insert stimulus here
		c_in <= '0';

		-- test 1
		A <= x"01";
		B <= x"02";
		wait for 20 ns;
		assert (S = x"03" and ovfl = '0') report "Test1 Failed!" severity error;
		if (S /= x"03" and ovfl /= '0') then
		err_cnt := err_cnt+1;
		end if;

		-- test 2
		A <= x"FF";
		B <= x"01";
		wait for 20 ns;
		assert (S = x"00" and ovfl = '1') report "Test2 Failed!" severity error;
		if (S /= x"00" and ovfl /= '1') then
			err_cnt := err_cnt+1;
		end if;

		-- test 3
		A <= x"01";
		B <= x"FF";
		wait for 20 ns;
		assert (S = x"00" and ovfl = '1') report "Test3 Failed!" severity error;
		if (S /= x"00" and ovfl /= '1') then
		err_cnt := err_cnt+1;
		end if;

		-- test 4
		A <= x"0F";
		B <= x"F0";
		wait for 20 ns;
		assert (S = x"FF" and ovfl = '0') report "Test4 Failed!" severity error;
		if (S /= x"FF" and ovfl /= '0') then
		err_cnt := err_cnt+1;
		end if;

		-- test 5 (subtract) 15-1
		c_in <= '1';
		wait for 20 ns;
		A <= x"0F";
		B <= x"0E"; -- 1 in complementi alla base
		wait for 20 ns;
		assert (S = x"1E" and ovfl = '0') report "Test5 Failed!" severity error;
		if (S /= x"1E" and ovfl /= '0') then
			err_cnt := err_cnt+1;
		end if;

		-- summary of all the tests
		if (err_cnt = 0) then
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
