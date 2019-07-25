----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    15:22:10 12/06/2015
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
	Port(	A : IN std_logic_vector(7 downto 0);
			B : IN std_logic_vector(7 downto 0);
			P : IN std_logic_vector(15 downto 0);
			clock : IN std_logic;
			reset_n : IN std_logic;
			load_a : IN std_logic;
			load_b : IN std_logic;
			done : IN std_logic;
			value : OUT std_logic_vector(15 downto 0);
			enable : OUT std_logic_vector(3 downto 0)
);
end control_unit;

architecture Behavioral of control_unit is

begin

cu : process(clock, reset_n, load_a, load_b, done)
begin
	if(reset_n = '0') then
			value <= x"0000";
			enable <= "0000";
	elsif(clock = '1' and clock'event) then
		if(load_a = '1') then
			value <= x"A0" & A;
			enable <= "1011";
		elsif(load_b = '1') then
			value <=  x"B0" & B;
			enable <= "1011";
		elsif(done = '1') then
			value <= P;
			enable <= "1111";
		end if;
	end if;
end process;


end Behavioral;

