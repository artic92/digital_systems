----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    15:41:31 11/12/2012
-- Design Name:
-- Module Name:    latch_d_enabled - Structural
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

entity latch_d_enabled is
    Port ( 	D : in  STD_LOGIC;
			enable : in STD_LOGIC;
           	Q : out  STD_LOGIC;
           	NQ : out  STD_LOGIC);
end latch_d_enabled;

architecture Structural of latch_d_enabled is

COMPONENT latch_rs_enabled
	generic ( delay : time );
	PORT(
		R : IN std_logic;
		S : IN std_logic;
		enable : in  STD_LOGIC;
		Q : OUT std_logic;
		NQ : OUT std_logic
		);
END COMPONENT;

signal not_d : std_logic;

begin

not_d <= not D;

rs_nor_gate: latch_rs_enabled
	generic map( delay => 2 ns )
	PORT MAP(
		R => not_d,
		S => D,
		enable => enable,
		Q => Q,
		NQ => NQ
	);

end Structural;
