----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    13:21:12 11/15/2015
-- Design Name:
-- Module Name:    carry_save_logic - Structural
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

entity carry_save_logic is
	generic (n : natural := 4);
    Port ( A : in  STD_LOGIC_VECTOR (n-1 downto 0);
           B : in  STD_LOGIC_VECTOR (n-1 downto 0);
           C : in  STD_LOGIC_VECTOR (n-1 downto 0);
           CS : out  STD_LOGIC_VECTOR (n-1 downto 0);
           T : out  STD_LOGIC_VECTOR (n-1 downto 0));
end carry_save_logic;

architecture Structural of carry_save_logic is

COMPONENT full_adder
	PORT(
		a : IN std_logic;
		b : IN std_logic;
		c_in : IN std_logic;
		c_out : OUT std_logic;
		s : OUT std_logic
		);
END COMPONENT;

begin

sc_gen : for i in n-1 downto 0 generate

cs_i : full_adder
	PORT MAP(a => A(i), b => B(i), c_in => C(i), c_out => CS(i), s => T(i));
end generate;

end Structural;

