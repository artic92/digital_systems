----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    15:44:00 11/12/2012
-- Design Name:
-- Module Name:    rs_master_slave - Behavioral
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

entity rs_master_slave is
    Port ( 	R : in  STD_LOGIC;
			S : in  STD_LOGIC;
           	clock : in  STD_LOGIC;
           	Q : out  STD_LOGIC;
           	NQ : out  STD_LOGIC);
end rs_master_slave;

architecture Behavioral of rs_master_slave is

	COMPONENT latch_rs_enabled
		generic ( delay : time );
		PORT(
			R : IN std_logic;
			S : IN std_logic;
			enable : IN std_logic;
			Q : OUT std_logic;
			NQ : OUT std_logic
			);
	END COMPONENT;

signal Q_master, NQ_master, clock_n : std_logic;

begin

clock_n <= not clock;

latch_rs_enabled_master: latch_rs_enabled
	generic map (delay => 2 ns)
	PORT MAP(
		R => R,
		S => S,
		enable => clock,
		Q => Q_master,
		NQ => NQ_master
	);

latch_rs_enabled_slave: latch_rs_enabled
	generic map (delay => 2 ns)
	PORT MAP(
		R => Q_master,
		S => NQ_master,
		enable => clock_n,
		Q => Q,
		NQ => NQ
	);


end Behavioral;

