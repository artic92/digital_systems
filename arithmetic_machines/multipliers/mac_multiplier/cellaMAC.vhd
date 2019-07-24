----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    20:22:16 01/15/2016
-- Design Name:
-- Module Name:    cellaMAC - Structural
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

entity cellaMAC is
    Port ( xi : in  STD_LOGIC;
           yi : in  STD_LOGIC;
           sum_in : in  STD_LOGIC;
           carry_in : in  STD_LOGIC;
           carry_out : out  STD_LOGIC;
           sum_out : out  STD_LOGIC);
end cellaMAC;

architecture Structural of cellaMAC is

COMPONENT fullAdder
	PORT(
		a : IN std_logic;
		b : IN std_logic;
		c_in : IN std_logic;
		s : OUT std_logic;
		c_out : OUT std_logic
		);
END COMPONENT;

signal prod_parziale : std_logic := '0';

begin

prod_parziale <= xi and yi;

sommatore: fullAdder
PORT MAP(
	a => sum_in,
	b => prod_parziale,
	c_in => carry_in,
	s => sum_out,
	c_out => carry_out
);

end Structural;

