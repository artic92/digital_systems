----------------------------------------------------------------------------------
--! @file register_n_bit.vhd
--! @author Antonio Riccio
--! @brief Description of a configurable memory block
--! @version 1.0
--! @date 18:03:04 11/07/2015
--! @copyright GNU Public License
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity register_n_bit is
	generic (
		n 						: natural;                              --! parallelism of the block
		delay 				: time);                                --! delay after which output changes when input changes and register is in transparency (load asserted)
    port (
		clock 				: in   std_logic; 							 --! system clock
		async_reset_n		: in   std_logic; 							 --! 0-active, asynchronous reset
      load 					: in   std_logic; 							 --! 1-active, synchronous load
		I 						: in   std_logic_vector(n-1 downto 0);  --! data to store, n bits
		O						: out  std_logic_vector(n-1 downto 0)); --! data stored, n bits
end register_n_bit;

architecture behavioral of register_n_bit is

begin

process (clock, load, async_reset_n)
	begin
	if (async_reset_n = '0') then
		O <=  (others => '0');
	elsif (rising_edge(clock)) then
		if (load = '1') then
			O <= I after delay;
		end if;
	end if;
end process;

end architecture behavioral;
