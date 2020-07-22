library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reset_logic is
   port (
      clock   : in std_logic;
      reset_n : out std_logic);
end reset_logic;

architecture proto of reset_logic is

   constant max_delay    : natural := 50000000; -- 1 second delay (assuming 50MHz base frequency)

   signal start_counting : std_logic;
   signal count_hit      : std_logic;
   signal reset_delay    : std_logic_vector (23 downto 0) := (others => '0');

begin

   control_logic : process (clock)
      variable phase : natural := 0;
   begin
      if (rising_edge(clock)) then
         if (phase = 0) then        -- wait cycle
            phase          :=  1;
            start_counting <= '0';
            reset_n        <= '0';
         elsif (phase = 1) then     -- wait cycle
            phase          :=  2;
            start_counting <= '0';
            reset_n        <= '0';
         elsif (phase = 2) then     -- wait cycle
            phase          :=  3;
            start_counting <= '0';
            reset_n        <= '0';
         elsif (phase = 3) then
            phase          :=  4;
            start_counting <= '1';
            reset_n        <= '0';
         elsif (phase = 4) then
            start_counting <= '1';
            reset_n        <= '0';
            if (count_hit = '1') then
               phase := 5;
            else
               phase := 4;
            end if;
         elsif (phase = 5) then
            phase          :=  5;
            start_counting <= '0';
            reset_n        <= '1';
         end if;
      end if;
   end process control_logic;

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
