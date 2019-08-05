----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:    08:59:26 11/09/2015
-- Design Name:
-- Module Name:    inverter - DataFlow
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

entity inverter is
	generic (delay : time := 0 ns);
       Port ( i : in  STD_LOGIC;
           inv_o : out  STD_LOGIC);
end inverter;

architecture DataFlow of inverter is

begin

inv_o <= (not i) after delay;

end DataFlow;

