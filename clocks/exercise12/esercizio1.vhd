----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    17:42:52 12/08/2015
-- Design Name:
-- Module Name:    generatore_clock - Behavioral
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

entity generatore_clock is
    Port ( clock : out  STD_LOGIC);
end generatore_clock;

architecture Behavioral of generatore_clock is

constant pattern_period : time := 280 ns;

begin

es_1 : process
begin
	clock <= '0', '1' after 25 ns, '0' after 35 ns, '1' after 50 ns,
			 '0' after 75 ns, '1' after 105 ns, '0' after 110 ns, '1' after 155 ns,
			 '0' after 175 ns, '1' after 195 ns, '0' after 235 ns;
	wait for pattern_period;
end process;

end Behavioral;

