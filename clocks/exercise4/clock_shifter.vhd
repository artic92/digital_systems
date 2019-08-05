----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:    19:47:43 12/11/2015
-- Design Name:
-- Module Name:    clock_shifter - Behavioral
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

entity clock_shifter is
	generic ( clock_period : time := 230 ns );
       Port ( clk_base : in  STD_LOGIC;
              enable : in  STD_LOGIC;
              clk90 : out  STD_LOGIC;
              clk180 : out  STD_LOGIC;
              clk270 : out  STD_LOGIC;
              clk2x : out  STD_LOGIC);
end clock_shifter;

architecture Behavioral of clock_shifter is

signal clk90_sig, clk180_sig, clk270_sig : std_logic;

begin

clk90 <= clk90_sig;
clk180 <= clk180_sig;
clk270 <= clk270_sig;

clk90_sig <= (clk_base and enable) after clock_period/4;
clk180_sig <= clk90_sig after clock_period/4;
clk270_sig <= clk180_sig after clock_period/4;
clk2x <= clk270_sig after clock_period/4;

end Behavioral;

architecture Structural of clock_shifter is

COMPONENT inverter_chain is
	generic (n : natural := 3;
		  delay_inverter : time := 2 ns);
       Port ( i : in  STD_LOGIC;
              o : out  STD_LOGIC);
end COMPONENT;

signal clk_sig_out :std_logic_vector(4 downto 1);
signal i_primo_inv:std_logic;

attribute KEEP : string;
attribute KEEP of clk_sig_out : signal is "true";

begin

clk90 <= not clk_sig_out(1);
clk180 <= clk_sig_out(2);
clk270 <= not clk_sig_out(3);
clk2x <= clk_sig_out(4);

i_primo_inv <= clk_base and enable;

-- NB. Ritardo di 57.5 ns (n = 2875)
-- 	Ritado di 2,5 ns (n = 125)

-- ATTENZIONE in unit ddm Conflict on KEEP property on signal clk_sig_out<1> and clk_sig_out<3> clk_sig_out<3> signal will be lost.

clk_out_90 : inverter_chain
	generic map(n=> 125, delay_inverter => 20 ps)
--	generic map(n=> 2875, delay_inverter => 20 ps)
	port map(i => i_primo_inv, o => clk_sig_out(1));

clk_out_gen : for i in 1 to 3 generate
	clk_out_k90 : inverter_chain
		generic map(n=> 125, delay_inverter => 20 ps)
--		generic map(n=> 2875, delay_inverter => 20 ps)
		port map(i => clk_sig_out(i), o => clk_sig_out(i+1));
end generate;

end Structural;

