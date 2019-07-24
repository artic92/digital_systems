----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    11:53:44 11/15/2015
-- Design Name:
-- Module Name:    blocco_intermedio - Structural
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

entity blocco_intermedio is
	generic ( M : natural := 4 );
    Port ( A : in  STD_LOGIC_VECTOR (M-1 downto 0);
           B : in  STD_LOGIC_VECTOR (M-1 downto 0);
           carry_select_in : in  STD_LOGIC;
           carry_select_out : out  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR (M-1 downto 0));
end blocco_intermedio;

architecture Structural of blocco_intermedio is

COMPONENT mux2_1
	PORT(
			a : IN std_logic;
			b : IN std_logic;
			sel : IN std_logic;
			o : OUT std_logic
			);
END COMPONENT;

for all : mux2_1 use entity work.mux2_1(DataFlow);

COMPONENT mux2n_1
	generic ( n : natural := 4 );
	PORT(
			A : IN std_logic_vector(n-1 downto 0);
			B : IN std_logic_vector(n-1 downto 0);
			sel : IN std_logic;
			O : OUT std_logic_vector(n-1 downto 0)
			);
END COMPONENT;

COMPONENT ripple_carry_adder
	generic ( n : natural := 4 );
	PORT(
			A : IN std_logic_vector(n-1 downto 0);
			B : IN std_logic_vector(n-1 downto 0);
			c_in : IN std_logic;
			c_out : OUT std_logic;
			S : OUT std_logic_vector(n-1 downto 0)
			);
END COMPONENT;

signal carry_out_0, carry_out_1 : std_logic := '0';
signal somma_carry_0, somma_carry_1 : std_logic_vector (3 downto 0);

begin

Ripple_carry_con_carry0: ripple_carry_adder
	generic map(M)
	PORT MAP(A => A, B => B, c_in => '0', c_out => carry_out_0, S => somma_carry_0);

Ripple_carry_con_carry1: ripple_carry_adder
	generic map(M)
	PORT MAP(A => A, B => B, c_in => '1', c_out => carry_out_1, S => somma_carry_1);

--ALTERNATIVE: genearating final muxes from basic 2:1 ones
--generazione_mux : for i in M-1 downto 0 generate
--	s_select: mux2_1
--		PORT MAP(a => somma_carry_0(i), b => somma_carry_1(i), sel => carry_select_in, o => S(i));
--end generate;

s_select: mux2n_1
	generic map(M)
	PORT MAP(a => somma_carry_0, b => somma_carry_1, sel => carry_select_in, o => S);

c_out_select: mux2_1
	PORT MAP(a => carry_out_0, b => carry_out_1, sel => carry_select_in, o => carry_select_out);

end Structural;

