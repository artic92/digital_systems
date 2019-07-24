----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    12:13:29 11/15/2015
-- Design Name:
-- Module Name:    carry_select_4n_bit - Structural
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

entity carry_select_4n_bit is
	generic ( n : natural := 8);
    Port ( A : in  STD_LOGIC_VECTOR (n-1 downto 0);
           B : in  STD_LOGIC_VECTOR (n-1 downto 0);
           c_in : in  STD_LOGIC;
           ovfl : out  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR (n-1 downto 0));
end carry_select_4n_bit;

architecture Structural of carry_select_4n_bit is

COMPONENT ripple_carry_adder
	PORT(
		A : IN std_logic_vector(3 downto 0);
		B : IN std_logic_vector(3 downto 0);
		c_in : IN std_logic;
		c_out : OUT std_logic;
		S : OUT std_logic_vector(3 downto 0)
		);
END COMPONENT;

COMPONENT blocco_intermedio
	PORT(
		A : IN std_logic_vector(3 downto 0);
		B : IN std_logic_vector(3 downto 0);
		carry_select_in : IN std_logic;
		carry_select_out : OUT std_logic;
		S : OUT std_logic_vector(3 downto 0)
		);
END COMPONENT;

constant m : natural := 4;
constant numero_stadi : natural := n/m;

signal carry_sig : std_logic_vector(numero_stadi downto 1);

begin

-- Carry exit
ovfl <= carry_sig(numero_stadi);

-- First stage
Ripple_carry_primo_stadio: ripple_carry_adder
	PORT MAP(
		A => A(m-1 downto 0),
		B => B(m-1 downto 0),
		c_in => c_in,
		c_out => carry_sig(1),
		S => S(m-1 downto 0)
	);

-- Others stages generation
generazione_stadi : for i in 2 to numero_stadi generate

stadio_i : blocco_intermedio
	PORT MAP(
		A => A((i*M)-1 downto (i*M)-M),
		B => B((i*M)-1 downto (i*M)-M),
		carry_select_in => carry_sig(i-1),
		carry_select_out => carry_sig(i),
		S => S((i*M)-1 downto (i*M)-M)
	);

end generate;

end Structural;

