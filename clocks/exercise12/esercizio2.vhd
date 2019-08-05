----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    10:53:26 12/09/2015
-- Design Name:
-- Module Name:    esercizio_2 - Behavioral
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

-- Cristan made
entity esercizio_2 is
    Port (  en_n : in STD_LOGIC;
			clock : out  STD_LOGIC);
end esercizio_2;

architecture Behavioral of esercizio_2 is

COMPONENT inverter_chain
	generic ( delay : time := 11 ns);
	Port ( i : in  STD_LOGIC;
		   o : out  STD_LOGIC);
END COMPONENT;

signal o_inv : STD_LOGIC_VECTOR(10 downto 0);
signal d_en, i_inv, pattern: STD_LOGIC :='0';

begin

d_en <= not en_n;
clock <= pattern;

i_inv <= '1' when o_inv(10) = '1'
					 else '0';

with o_inv select pattern <= '0' when "00000000000",
							 '1' when "00000000001",
							 '0' when "00000000011",
							 '1' when "00000000111",
							 '0' when "00000001111",
							 '1' when "00000011111",
							 '0' when "00000111111",
							 '1' when "00001111111",
							 '0' when "00011111111",
							 '1' when "00111111111",
							 '0' when "01111111111",
							 '0' when "11111111111",
							 -- si inverte il meccanismo
							 '1' when "11111111110",
							 '0' when "11111111100",
							 '1' when "11111111000",
							 '0' when "11111110000",
							 '1' when "11111100000",
							 '0' when "11111000000",
							 '1' when "11110000000",
							 '0' when "11100000000",
							 '1' when "11000000000",
							 '0' when "10000000000",
							 'Z' when others;

-- Si usa un unico inverter con mega ritardo poichè la simulazione richiede troppo tempo
inv1 : inverter_chain
	generic map( delay => 25 ns)
	port map(i_inv,o_inv(0));

inv2 : inverter_chain
	generic map( delay => 35 ns)
	port map(i_inv,o_inv(1));

inv3 : inverter_chain
	generic map( delay => 50 ns)
	port map(i_inv,o_inv(2));

inv4 : inverter_chain
	generic map( delay => 75 ns)
	port map(i_inv,o_inv(3));

inv5 : inverter_chain
	generic map( delay => 105 ns)
	port map(i_inv,o_inv(4));

inv6 : inverter_chain
	generic map( delay => 110 ns)
	port map(i_inv,o_inv(5));

inv7 : inverter_chain
	generic map( delay => 155 ns)
	port map(i_inv,o_inv(6));

inv8 : inverter_chain
	generic map( delay => 175 ns)
	port map(i_inv,o_inv(7));

inv9 : inverter_chain
	generic map( delay => 195 ns)
	port map(i_inv,o_inv(8));

inv10 : inverter_chain
	generic map( delay => 235 ns)
	port map(i_inv,o_inv(9));

inv11 : inverter_chain
	generic map( delay => 280 ns)
	port map(i_inv,o_inv(10));

end Behavioral;

