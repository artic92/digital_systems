----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    17:28:34 11/06/2015
-- Design Name:
-- Module Name:    latch_d_enabled_behavioral - Behavioral
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

entity latch_d_enabled_behavioral is
    Port ( 	data_in : in  STD_LOGIC;
           	enable : in  STD_LOGIC;
			reset_n : in STD_LOGIC;
           	data_out : out  STD_LOGIC);
end latch_d_enabled_behavioral;

architecture Behavioral of latch_d_enabled_behavioral is

begin

	process(data_in, enable, reset_n)
	begin
		if (reset_n = '0') then
			data_out <= '0';
		elsif (enable = '1') then
			data_out <= data_in;
		end if;
	end process;

end Behavioral;
