----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    10:36:19 12/09/2015
-- Design Name:
-- Module Name:    inverter_chain - Behavioral
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

entity inverter_chain is
	generic ( delay : time := 11 ns);
    Port ( i : in  STD_LOGIC;
           o : out  STD_LOGIC:='0');
end inverter_chain;

architecture Behavioral of inverter_chain is

COMPONENT inverter
	generic ( delay : time := 1 ps);
	Port(	a : in  STD_LOGIC;
			b : out  STD_LOGIC);
END COMPONENT;

signal sig : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
attribute KEEP : string;
attribute KEEP of sig : signal is "TRUE";

begin

sig(0) <= i;

ff : for i in 0 to 0 generate
		sig(i+1) <= not sig(i) after delay ;
end generate;

o <= sig(1);

end Behavioral;

