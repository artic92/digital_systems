----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    20:35:53 01/15/2016
-- Design Name:
-- Module Name:    rigaMAC - Structural
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

entity rigaMAC is
	generic(n : natural := 8);
    Port ( 	A : in  STD_LOGIC_VECTOR (n-1 downto 0);
           	bi : in  STD_LOGIC;
           	somma_parziale_in : in  STD_LOGIC_VECTOR (n-1 downto 0);
           	somma_parziale_out : out  STD_LOGIC_VECTOR (n-1 downto 0);
			carry_out : out STD_LOGIC);
end rigaMAC;

architecture Structural of rigaMAC is

COMPONENT cellaMAC
	PORT(
		xi : IN std_logic;
		yi : IN std_logic;
		sum_in : IN std_logic;
		carry_in : IN std_logic;
		carry_out : OUT std_logic;
		sum_out : OUT std_logic
		);
END COMPONENT;

signal carry_sig : std_logic_vector (n downto 0) := (others => '0');

begin

-- this row is necessary to remove a warning
carry_sig(0) <= '0';

celle_gen: for i in 0 to n-1 generate
	cellaMAC_i: cellaMAC
	PORT MAP(
		xi => A(i),
		yi => bi,
		sum_in => somma_parziale_in(i),
		carry_in => carry_sig(i),
		carry_out => carry_sig(i+1),
		sum_out => somma_parziale_out(i)
	);
end generate;

carry_out <= carry_sig(n);

end Structural;

