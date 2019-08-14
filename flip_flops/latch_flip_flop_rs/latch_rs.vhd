----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    15:25:03 01/16/2016
-- Design Name:
-- Module Name:    latch_rs - DataFlow
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

entity latch_rs is
	generic( delay_nor_nand : time := 0 ns;
			 nor_nand : natural := 0);
    Port ( r : in  STD_LOGIC;
           s : in  STD_LOGIC;
           q : out  STD_LOGIC;
           qn : out  STD_LOGIC);
end latch_rs;

architecture DataFlow of latch_rs is

-- Setting the following variables impose a certain intial state into the latch
signal G1, G2 : std_logic; --:= '0';

begin

nor_gen: if (nor_nand = 0) generate
	G1 <= r nor G2 after delay_nor_nand;
	G2 <= s nor G1 after delay_nor_nand;
end generate;

nand_generate: if (nor_nand = 1) generate
	G1 <= r nand G2 after delay_nor_nand;
	G2 <= s nand G1 after delay_nor_nand;
end generate;

q <= G1;
qn <= G2;

end DataFlow;
