----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    11:04:29 11/11/2012
-- Design Name:
-- Module Name:    latch_rs_enabled - Behavioral
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

entity latch_rs_enabled is
	generic( delay : time );
    Port ( r : in  STD_LOGIC;
           s : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           Q : out  STD_LOGIC;
           NQ : out  STD_LOGIC);
end latch_rs_enabled;

architecture Behavioral of latch_rs_enabled is

COMPONENT latch_rs
	generic( delay_nor_nand : time := 0 ns;
			 nor_nand : natural := 0); -- 0:NOR => falling, 1:NAND => rising
	PORT(
		r : IN std_logic;
		s : IN std_logic;
		q : OUT std_logic;
		qn : OUT std_logic
		);
END COMPONENT;

signal clocked_r, clocked_s : std_logic;

begin

clocked_s <= s and enable;
clocked_r <= r and enable;

latch: latch_rs
	generic map (delay_nor_nand => delay)
	PORT MAP(
		r => clocked_r,
		s => clocked_s,
		q => Q,
		qn => NQ
	);

end Behavioral;

