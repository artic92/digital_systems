----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    22:10:19 12/16/2015
-- Design Name:
-- Module Name:    freq_multiplier - Behavioral
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

entity freq_multiplier is
	generic ( 	periodo_freq_in : time := 10 ns;
				mult_factor : natural := 2 );
    Port ( enable : in  STD_LOGIC;
           clock : in  STD_LOGIC;
           clock_out : out  STD_LOGIC);
end freq_multiplier;

architecture Behavioral of freq_multiplier is

constant period_multiplied_freq : time := (periodo_freq_in/mult_factor);

signal d_clk : std_logic_vector (mult_factor-1 downto 0) := (others => '0');
signal clock_multiplied : std_logic := '0';

begin

clock_out <= enable and clock_multiplied;

--- Genero mult_factor clock sfasati di  (periodo_freq_in/mult_factor)/ ns
d_clk(0) <= clock after period_multiplied_freq/2;

cycle : for i in 0 to mult_factor-2 generate
			d_clk (i+1) <= d_clk(i) after period_multiplied_freq/2;
end generate;

--- Creo il clock con frequenza mult_factor volte il clock base
clk1 : process (d_clk)
begin
	for i in 0 to mult_factor-1 loop
		clock_multiplied <= not clock_multiplied;
	end loop;
end process;

end Behavioral;

