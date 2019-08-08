----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    16:56:37 12/20/2015
-- Design Name:
-- Module Name:    anodes_manager - DataFlow
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

entity anodes_manager is
    Port ( counter : in  STD_LOGIC_VECTOR (1 downto 0);
           enable_digit : in  STD_LOGIC_VECTOR (3 downto 0);
           anodes : out  STD_LOGIC_VECTOR (3 downto 0));
end anodes_manager;

architecture DataFlow of anodes_manager is

signal anodes_config : std_logic_vector(3 downto 0) := (others => '0');

begin

anodes <= not anodes_config or not enable_digit;

with counter select anodes_config <= x"1" when "00",
																						  x"2" when "01",
																						  x"4" when "10",
																						  x"8" when "11",
																						  x"0" when others;

end DataFlow;

