----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    21:23:56 12/17/2015
-- Design Name:
-- Module Name:    duty_50_to_70 - Behavioral
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

entity duty_50_to_70 is
    Port ( enable : in  STD_LOGIC;
           clock_duty_50 : in  STD_LOGIC;
           clock_duty_70 : out  STD_LOGIC);
end duty_50_to_70;

architecture Behavioral of duty_50_to_70 is

signal uscita : std_logic := '0';

begin

clock_duty_70 <= enable and uscita;

x_50_to_x_70 : process(clock_duty_50)

	variable conteggio : integer := 0;

	begin
		if rising_edge(clock_duty_50) then
			if conteggio < 7 then
				uscita <= '1';
				conteggio := conteggio +1 ;
			elsif conteggio < 9 then
				uscita <= '0';
				conteggio := conteggio +1 ;
			else
				conteggio := 0;
			end if;
		end if;
end process;

end Behavioral;

