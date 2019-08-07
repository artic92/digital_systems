----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    12:36:38 12/21/2015
-- Design Name:
-- Module Name:    hex2bcd - Behavioral
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity hex2bcd is
	generic( n : positive := 16 );
	Port( 	clock : in STD_LOGIC;
	        reset_n : in STD_LOGIC;
			binary_in : in STD_LOGIC_VECTOR (n-1 downto 0);
			bcd0, bcd1, bcd2, bcd3, bcd4 : out STD_LOGIC_VECTOR (3 downto 0) );
end hex2bcd;

architecture Behavioral of hex2bcd is

type state is (start, shift, done);
signal current_state, next_state: state;

signal binary, binary_reg_in : std_logic_vector(n-1 downto 0) := (others => '0');
signal bcds, bcds_reg, bcds_reg_in, bcds_out_reg, bcds_out_reg_in: std_logic_vector(19 downto 0) := (others => '0');
signal shift_counter, shift_counter_reg_in : natural range 0 to n := 0;

begin

bcd4 <= bcds_out_reg(19 downto 16);
bcd3 <= bcds_out_reg(15 downto 12);
bcd2 <= bcds_out_reg(11 downto 8);
bcd1 <= bcds_out_reg(7 downto 4);
bcd0 <= bcds_out_reg(3 downto 0);

bcds_out_reg_in <= bcds when current_state = done else
						                  bcds_out_reg;

bcds_reg(19 downto 16) <= bcds(19 downto 16) + 3 when bcds(19 downto 16) > 4 else
								                    	bcds(19 downto 16);
bcds_reg(15 downto 12) <= bcds(15 downto 12) + 3 when bcds(15 downto 12) > 4 else
								                     	bcds(15 downto 12);
bcds_reg(11 downto 8) <= bcds(11 downto 8) + 3 when bcds(11 downto 8) > 4 else
							                      		bcds(11 downto 8);
bcds_reg(7 downto 4) <= bcds(7 downto 4) + 3 when bcds(7 downto 4) > 4 else
							                     		bcds(7 downto 4);
bcds_reg(3 downto 0) <= bcds(3 downto 0) + 3 when bcds(3 downto 0) > 4 else
							                    		bcds(3 downto 0);

status_reg: process(clock, reset_n)
begin
  if (reset_n = '0') then
		binary <= (others => '0');
		bcds <= (others => '0');
		current_state <= start;
		bcds_out_reg <= (others => '0');
		shift_counter <= 0;
  elsif (rising_edge(clock)) then
		binary <= binary_reg_in;
		bcds <= bcds_reg_in;
		current_state <= next_state;
		bcds_out_reg <= bcds_out_reg_in;
		shift_counter <= shift_counter_reg_in;
  end if;
end process;

fsm: process(current_state, binary, binary_in, bcds, bcds_reg, shift_counter)
begin

  bcds_reg_in <= bcds;
  binary_reg_in <= binary;
  shift_counter_reg_in <= shift_counter;

  case current_state is
		when start =>
						binary_reg_in <= binary_in;
						bcds_reg_in <= (others => '0');
						shift_counter_reg_in <= 0;
						next_state <= shift;
		when shift =>
						if (shift_counter = n) then
							next_state <= done;
						else
							binary_reg_in <= binary(n-2 downto 0) & '0';
							bcds_reg_in <= bcds_reg(18 downto 0) & binary(n-1);
							shift_counter_reg_in <= shift_counter + 1;
							next_state <= shift;
						end if;
		when done =>
						next_state <= start;
  end case;

end process;

end Behavioral;
