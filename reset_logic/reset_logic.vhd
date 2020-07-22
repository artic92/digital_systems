----------------------------------------------------------------------------------
--! @file reset_logic.vhd
--! @author Antonio Riccio
--! @brief Block generating a delayed reset signal
--! @copyright
--! 2020 Antonio Riccio <antonio.riccio.27@gmail.com>
--! This program is free software; you can redistribute it and/or modify it under
--! the terms of the GNU General Public License as published by the
--!  either version 3 of the License, or any later version.
--! This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
--! without even the implied warranty of MERCHANTABILITY
--! or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
--! You should have received a copy of the GNU General Public License along with this program;
--! if not, write to the Free Software Foundation, Inc.,
--! 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
----------------------------------------------------------------------------------

--! Use standard library
library ieee;
use ieee.std_logic_1164.all;
--! Needed for the + operator
use ieee.numeric_std.all;

--! This block sets the reset signal after max_delay clock cycles
--! @note it is assumed a clock of 50 MHz frequency
--! @note the reset signal is 0-active
entity reset_logic is
   port (
      clock   : in std_logic;   --! Input clock
      reset_n : out std_logic); --! Reset to generate (0-active)
end reset_logic;

--! Prototypal architecture
architecture proto of reset_logic is

   --! delay in clock cycles (1 second delay)
   constant max_delay    : natural := 50000000;

   signal start_counting : std_logic;
   signal count_hit      : std_logic;
   signal reset_delay    : std_logic_vector (23 downto 0) := (others => '0');

begin

   control_logic : process (clock)
      variable phase : natural := 0; --! state variable
   begin
      if (rising_edge(clock)) then
         if (phase = 0) then        --! wait cycle
            phase          :=  1;
            start_counting <= '0';
            reset_n        <= '0';
         elsif (phase = 1) then     --! wait cycle
            phase          :=  2;
            start_counting <= '0';
            reset_n        <= '0';
         elsif (phase = 2) then     --! wait cycle
            phase          :=  3;
            start_counting <= '0';
            reset_n        <= '0';
         elsif (phase = 3) then     --! start the counter
            phase          :=  4;
            start_counting <= '1';
            reset_n        <= '0';
         elsif (phase = 4) then     --! waits for counting termination
            start_counting <= '1';
            reset_n        <= '0';
            if (count_hit = '1') then
               phase := 5;
            else
               phase := 4;
            end if;
         elsif (phase = 5) then     --! de-activate the reset
            phase          :=  5;
            start_counting <= '0';
            reset_n        <= '1';
         end if;
      end if;
   end process control_logic;

   --! @brief counter modulo max_delay
   --! this block implements the delay after that the reset it de-asserted
   delay_switch_reset_n : process (clock)
   begin
      if (rising_edge(clock)) then
         if (start_counting = '1') then
            if (unsigned(reset_delay) = max_delay-1) then
                  count_hit <= '1';
                  reset_delay <= (others => '0');
               else
                  count_hit <= '0';
                  reset_delay <= std_logic_vector(unsigned(reset_delay) + 1);
            end if;
         end if;
      end if;
   end process delay_switch_reset_n;

end proto;
