----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    11:36:34 12/14/2015
-- Design Name:
-- Module Name:    pattern_generator - Behavioral
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

entity pattern_generator is
	generic (	clock_period_in : time := 10 ns;
				clock_period : time := 230 ns);
	Port ( 	clock : in  STD_LOGIC;
			pattern : out  STD_LOGIC;
			clk90 : out STD_LOGIC;
			clk180 : out STD_LOGIC;
			clk270 : out STD_LOGIC;
			clk360 : out STD_LOGIC);
end pattern_generator;

architecture Behavioral of pattern_generator is

signal clk90_sig, clk180_sig, clk270_sig, pattern_sig : std_logic := '0';

begin

pattern <= pattern_sig;
clk90 <= clk90_sig;
clk180 <= clk180_sig;
clk270 <= clk270_sig;

------------------------------------------------------------------
-- Phase shifting
clk90_sig <= pattern_sig after clock_period/4;
clk180_sig <= clk90_sig after clock_period/4;
clk270_sig <= clk180_sig after clock_period/4;
clk360 <= clk270_sig after clock_period/4;
------------------------------------------------------------------

pattern_generator : process
begin
		pattern_sig <= 	'0', '1' after (clock_period_in/2) + (14*clock_period_in),
						'0' after 24*clock_period_in,
						'1' after 38*clock_period_in,
						'0' after (clock_period_in/2) + (47*clock_period_in);
		wait for (clock_period_in/2) + (47*clock_period_in);
end process;

end Behavioral;

