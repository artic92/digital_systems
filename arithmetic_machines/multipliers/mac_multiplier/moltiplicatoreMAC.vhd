----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    20:28:17 01/15/2016
-- Design Name:
-- Module Name:    moltiplicatore_mac - Structural
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

entity moltiplicatore_mac is
	generic(n : natural := 8;
				m : natural := 8);
    Port ( A : in  STD_LOGIC_VECTOR (n-1 downto 0);
           B : in  STD_LOGIC_VECTOR (m-1 downto 0);
           P : out  STD_LOGIC_VECTOR ((n+m)-1 downto 0));
end moltiplicatore_mac;

architecture Structural of moltiplicatore_mac is

COMPONENT rigaMAC
	generic(n : natural := n);
	PORT(
		A : IN std_logic_vector(n-1 downto 0);
		bi : IN std_logic;
		somma_parziale_in : IN std_logic_vector(n-1 downto 0);
		somma_parziale_out : OUT std_logic_vector(n-1 downto 0);
		carry_out : OUT std_logic
		);
END COMPONENT;

signal somme_parziali_sig : std_logic_vector(n*(m+1)+m downto 1) := (others => '0');

begin

-- this row is necessary to remove a warning
somme_parziali_sig(n downto 1) <= (others => '0');

righe_mac_gen: for i in 0 to m-1 generate
		rigaMAC_i: rigaMAC
		PORT MAP(
			A => A,
			bi => B(i),
			somma_parziale_in => somme_parziali_sig((n+1)*(i+1)-1 downto (n+1)*i+1),
			somma_parziale_out => somme_parziali_sig((n+1)*(i+2)-2 downto (n+1)*(i+1)),
			carry_out => somme_parziali_sig((n+1)*(i+2)-1)
	);
	P(i) <= somme_parziali_sig((n+1)*(i+1));
end generate;

P(n+m-1 downto m) <= somme_parziali_sig(n*(m+1)+m downto (n*m)+m+1);

end Structural;

