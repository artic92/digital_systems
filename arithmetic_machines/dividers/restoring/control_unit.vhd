----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    15:22:10 12/06/2015
-- Design Name:
-- Module Name:    control_unit - Behavioral
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

entity control_unit is
	Port( D : IN std_logic_vector(6 downto 0);
		  V : IN std_logic_vector(3 downto 0);
		  Q : IN std_logic_vector(3 downto 0);
		  R : IN std_logic_vector(3 downto 0);
		  clock : IN std_logic;
		  reset_n : IN std_logic;
		  load_d : IN std_logic;
		  load_v : IN std_logic;
		  done : IN std_logic;
		  div_0 : IN std_logic;
		  value : OUT std_logic_vector(15 downto 0);
		  enable : OUT std_logic_vector(3 downto 0)
);
end control_unit;

architecture Behavioral of control_unit is

begin

cu : process(clock, reset_n, load_d, load_v, done, div_0)
begin
	if(reset_n = '0') then
			value <= x"0000";
			enable <= "0000";
	elsif(clock = '1' and clock'event) then
		if(load_d = '1') then
			value <= '0' & D & x"0" & V;
			enable <= "1101";
		elsif(load_v = '1') then
			value <= '0' & D & x"0" & V;
			enable <= "1101";
		elsif(done = '1') then
			if(div_0 = '1') then
				value <= x"EEEE";
				enable <= "1111";
			else
				value <= Q & x"00" & R;
				enable <= "1001";
			end if;
		end if;
	end if;
end process;


end Behavioral;

