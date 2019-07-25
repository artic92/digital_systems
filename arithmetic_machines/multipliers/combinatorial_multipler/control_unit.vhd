----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    17:47:50 12/05/2015
-- Design Name:
-- Module Name:    control_unit - Behavioral
-- Project Name:
-- Target Devices:
-- Tool versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control_unit is
PORT(
		in_byte : IN std_logic_vector(7 downto 0);
		P : IN std_logic_vector(15 downto 0);
		clock : IN std_logic;
		reset_n : IN std_logic;
		load_a : IN std_logic;
		load_b : IN std_logic;
		enable : OUT std_logic_vector(3 downto 0);
		A : OUT std_logic_vector(7 downto 0);
		B : OUT std_logic_vector(7 downto 0);
		value : OUT std_logic_vector(15 downto 0)
		);
end control_unit;

architecture Behavioral of control_unit is

begin

process(clock, reset_n, load_a, load_b, in_byte, P)
begin
	if(reset_n = '0') then
		enable <= (others => '0');
		value <= (others => '0');
		A <= (others => '0');
		B <= (others => '0');
	elsif(clock = '1' and clock'event) then
		if(load_a = '1') then
			enable <= "1011";
			value <= x"A0" & in_byte;
			A <= in_byte;
		elsif(load_b = '1') then
			enable <= "1011";
			value <= x"B0" & in_byte;
			B <= in_byte;
		else
			enable <= "1111";
			value <= P;
		end if;
	end if;
end process;

end Behavioral;

