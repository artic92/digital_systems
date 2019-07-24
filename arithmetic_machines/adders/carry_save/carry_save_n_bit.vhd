----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    13:30:47 11/15/2015
-- Design Name:
-- Module Name:    carry_save_n_bit - Structural
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

entity carry_save_n_bit is
	generic ( n : natural := 8 );
    Port ( A : in  STD_LOGIC_VECTOR (n-1 downto 0);
           B : in  STD_LOGIC_VECTOR (n-1 downto 0);
           C : in  STD_LOGIC_VECTOR (n-1 downto 0);
           S : out  STD_LOGIC_VECTOR (n+1 downto 0));
			  -- + 2 bit = log2M com M numero di stringhe sono i bit di carry
end carry_save_n_bit;

architecture Structural of carry_save_n_bit is

COMPONENT carry_save_logic
	generic (n : natural := 4);
	PORT(
			A : IN std_logic_vector(n-1 downto 0);
			B : IN std_logic_vector(n-1 downto 0);
			C : IN std_logic_vector(n-1 downto 0);
			CS : OUT std_logic_vector(n-1 downto 0);
			T : OUT std_logic_vector(n-1 downto 0)
	);
END COMPONENT;

COMPONENT ripple_carry_adder
	generic (n : natural := 4);
	PORT(
			A : IN std_logic_vector(n-1 downto 0);
			B : IN std_logic_vector(n-1 downto 0);
			c_in : IN std_logic;
			ovfl : OUT std_logic;
			S : OUT std_logic_vector(n-1 downto 0)
	);
END COMPONENT;


signal cs : std_logic_vector (n-1 downto 0) := (others => '0');
signal t : std_logic_vector (n downto 0) := (others => '0');

begin

S(0) <= t(0) ;

CSL : carry_save_logic
	generic map (n)
	PORT MAP(A => A, B => B, C => C, CS => cs, T => t(n-1 downto 0));

RCA : ripple_carry_adder
	generic map (n)
	PORT MAP(A => cs, B => t(n downto 1), c_in => '0', ovfl => S(n+1), S => S(n downto 1));

end Structural;

