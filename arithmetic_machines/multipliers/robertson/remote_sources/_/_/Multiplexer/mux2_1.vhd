----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    23:01:57 01/19/2016
-- Design Name:
-- Module Name:    mux2_1 - Behavioral
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

entity mux2_1 is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           sel : in  STD_LOGIC;
           o : out  STD_LOGIC);
end mux2_1;

architecture Behavioral of mux2_1 is

begin

process(a, b, sel)
begin
	if (sel = '0') then
		o <= a;
	else
		o <= b;
	end if;
end process;

end Behavioral;

architecture DataFlow of mux2_1 is

begin

o <= (a and (not sel)) or (b and sel);

end DataFlow;

architecture Structural of mux2_1 is

signal r1 : STD_LOGIC := '0';
signal r2 : STD_LOGIC := '0';

component AND2
	port (
				I0 : in STD_LOGIC; I1: in STD_LOGIC;
				O : out STD_LOGIC
				);
end component;

component OR2
	port(
				I0 : in STD_LOGIC; I1: in STD_LOGIC;
				O : out STD_LOGIC
				);
end component;

begin
my_and1 : AND2
port map(I0 => a, I1 => (not sel), O=> r1);

my_and2 : AND2
port map(I0 => b, I1 => sel, O => r2);

my_or : OR2
port map(I0 => r1, I1 => r2, O => o);

end Structural;
