----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    16:19:03 01/16/2016
-- Design Name:
-- Module Name:    latch_d - Structural
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

entity latch_d is
    Port ( d : in  STD_LOGIC;
           q : out  STD_LOGIC;
           qn : out  STD_LOGIC);
end latch_d;

architecture Structural of latch_d is

COMPONENT latch_rs
	generic( delay_nor_nand : time := 0 ns;
			 nor_nand : natural := 0); -- NOR => falling, NAND => rising
	PORT(
		r : IN std_logic;
		s : IN std_logic;
		q : OUT std_logic;
		qn : OUT std_logic
		);
END COMPONENT;

signal not_d : std_logic;

begin

not_d <= not d;

latch_d_gen: latch_rs
	PORT MAP(
		r => not_d,
		s => d,
		q => q,
		qn => qn
	);

end Structural;

