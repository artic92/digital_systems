----------------------------------------------------------------------------------
--! @file counter_modulo_n.vhd
--! @author Antonio Riccio
--! @brief Configurable counter
--! @version 1.0
--! @date 13:49:26 12/20/2015
--! @copyright GNU Public License
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.math_real.ceil;
use ieee.math_real.log2;

entity counter_modulo_n is
	generic (
		n : natural);  				 --! modulo of the counter
	port (
		clock      : in  std_logic; --! system clock
		reset_n    : in  std_logic; --! 0-active asynchronous reset
		count_en   : in  std_logic; --! 1-active, when asserted start the count
      up_down    : in  std_logic; --! when 0 counts upwards, when 1 counts backwards
		count_load : in  std_logic; --! 1-active, when asserted triggers latches the couting value on count_in
		count_in   : in  std_logic_vector ((natural(ceil(log2(real(n)))))-1 downto 0); --! value from which start to count (default is 0)
      count_out  : out std_logic_vector ((natural(ceil(log2(real(n)))))-1 downto 0); --! value of the actual count
      count_hit  : out std_logic); --! when asserted indicates the counter has reached the configured modulo
end counter_modulo_n;

architecture functional of counter_modulo_n is

signal pre_count_out : std_logic_vector (natural(ceil(log2(real(n))))-1 downto 0);

begin

process(clock, reset_n, up_down)
begin
	if (reset_n = '0') then
		count_hit <= '0';
		if(up_down = '0') then
			pre_count_out <= (others => '0');
		else
			pre_count_out <= conv_STD_LOGIC_VECTOR(n-1, natural(ceil(log2(real(n)))));
		end if;
	elsif (rising_edge(clock)) then
		if (count_load = '1') then
			pre_count_out <= count_in;
		elsif (count_en = '1') then
			if (up_down = '0') then
				if (pre_count_out = n-1) then
					count_hit <= '1';
					pre_count_out <= (others => '0');
				else
					count_hit <= '0';
					pre_count_out <= pre_count_out + 1;
				end if;
			else
				if (pre_count_out = 0) then
					count_hit <= '1';
					pre_count_out <= conv_STD_LOGIC_VECTOR(n-1, natural(ceil(log2(real(n)))));
				else
					count_hit <= '0';
					pre_count_out <= pre_count_out - 1;
				end if;
			end if;
		end if;
	end if;
end process;

count_out <= pre_count_out;

end functional;

