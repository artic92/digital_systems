----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    14:04:51 12/14/2015
-- Design Name:
-- Module Name:    due_contatori - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.math_real.ceil;
use IEEE.math_real.log2;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity due_contatori is
	generic ( 	max_conteggio1 : integer := 16;
				max_conteggio2 : natural := 60);
    Port (  clock : in  STD_LOGIC;
            count_in : in  STD_LOGIC;
            reset_n : in  STD_LOGIC;
			load_conteggio1 : in STD_LOGIC;
			load_conteggio2 : in STD_LOGIC;
			conteggio1_in : in STD_LOGIC_VECTOR (natural(ceil(log2(real(max_conteggio1))))-1 downto 0);
			conteggio2_in : in STD_LOGIC_VECTOR (natural(ceil(log2(real(max_conteggio2))))-1 downto 0);
            conteggio2_out : out  STD_LOGIC_VECTOR ((natural(ceil(log2(real(max_conteggio2)))))-1 downto 0);
            count_hit : out  STD_LOGIC);
end due_contatori;

architecture Behavioral of due_contatori is

signal conteggio2 : std_logic := '0';
signal conteggio1 : std_logic_vector (natural(ceil(log2(real(max_conteggio1))))-1 downto 0) := (others => '0');
signal pre_conteggio2_out : std_logic_vector (natural(ceil(log2(real(max_conteggio2))))-1 downto 0) := (others => '0');

begin

count_hit <= conteggio2;

process (clock, count_in, reset_n, conteggio1, conteggio1_in, conteggio2_in, pre_conteggio2_out)
begin
	if reset_n = '0' then
		conteggio1 <= (conteggio1'range => '0');
		pre_conteggio2_out <= (pre_conteggio2_out'range => '0');
	elsif clock = '1' and clock'event then
		if load_conteggio1 = '1' then
			conteggio1 <= conteggio1_in;
		end if;
		if load_conteggio2 = '1' then
			pre_conteggio2_out <= conteggio2_in;
		end if;
		if count_in = '1' then
			if conteggio1 = max_conteggio1 then
				conteggio1 <= (conteggio1'range => '0');
				conteggio2 <= '1';
				if pre_conteggio2_out = max_conteggio2 then
					pre_conteggio2_out <= (pre_conteggio2_out'range => '0');
				else
					pre_conteggio2_out <= pre_conteggio2_out + 1;
				end if;
			else
				conteggio1 <= conteggio1 + 1;
				conteggio2 <= '0';
			end if;
		end if;
	end if;
	conteggio2_out <= pre_conteggio2_out;
end process;

end Behavioral;
