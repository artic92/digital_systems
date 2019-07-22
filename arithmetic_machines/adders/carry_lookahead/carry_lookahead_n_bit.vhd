----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    15:18:59 11/15/2015
-- Design Name:
-- Module Name:    carry_lookahead_n_bit - Structural
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

entity carry_lookahead_n_bit is
	generic ( n : natural := 8 );
    Port ( 	A : in  STD_LOGIC_VECTOR (n-1 downto 0);
			B : in  STD_LOGIC_VECTOR (n-1 downto 0);
			c_in : in  STD_LOGIC;
			ovfl : out  STD_LOGIC;
			S : out  STD_LOGIC_VECTOR (n-1 downto 0));
end carry_lookahead_n_bit;

architecture Structural of carry_lookahead_n_bit is

COMPONENT full_adder
	PORT(
		a : IN std_logic;
		b : IN std_logic;
		c_in : IN std_logic;
		c_out : OUT std_logic;
		s : OUT std_logic
		);
END COMPONENT;

signal p, g : std_logic_vector(n-1 downto 0) := (others => '0');
signal c : std_logic_vector(n downto 0) := (others => '0');

begin

c(0) <= c_in;

-- carry flag for natural binary numbers
--ovfl <= c(n);

-- overflow flag for 2-complement numbers
ovfl <= c(n) xor c(n-1);

-- conditional assignment which returns the sum ONLY if no overflow occurred
--S <= (others => '0') when (ovfl_sig = '1') else
--			pre_s;

-- bit per bit ORing and ANDing performed automatically
p <= A or B;
g <= A and B;

wire_gen :	for i in 0 to n-1 generate
	c(i+1) <= (g(i) or (p(i) and c(i)));
end generate;

adder_gen : for i in 0 to n-1 generate
	Full_adder_i : full_adder
		PORT MAP(a => A(i), b => B(i), c_in => c(i), c_out => open, s => S(i));
end generate;

end Structural;
