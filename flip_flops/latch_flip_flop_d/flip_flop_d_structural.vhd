----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    15:50:06 01/16/2016
-- Design Name:
-- Module Name:    flip_flop_d_structural - Structural
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

entity flip_flop_d_structural is
	generic( rising_falling : natural := 0 );
    Port ( d : in  STD_LOGIC;
           clock : in  STD_LOGIC;
           q : out  STD_LOGIC;
           qn : out  STD_LOGIC);
end flip_flop_d_structural;

architecture Structural of flip_flop_d_structural is

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

signal r1, q1, qn1, qn2 : std_logic;

begin

rising_edge_or: if (rising_falling = 1) generate
	r1 <= qn2 or clock;
end generate;

falling_edge_and: if (rising_falling = 0) generate
	r1 <= qn2 and clock;
end generate;

latch1: latch_rs
	PORT MAP(
		r => r1,
		s => d,
		q => q1,
		qn => qn1
	);

latch2: latch_rs
	PORT MAP(
		r => qn1,
		s => clock,
		q => open,
		qn => qn2
	);

latch3: latch_rs
	PORT MAP(
		r => qn2,
		s => q1,
		q => q,
		qn => qn
	);

end Structural;

