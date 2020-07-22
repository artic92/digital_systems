library ieee;
use ieee.std_logic_1164.all;

entity reset_logic_tb is
end entity reset_logic_tb;

architecture testbench of reset_logic_tb is

   constant CLOCK_PERIOD : time := 20 ns;

   component reset_logic is
      port (
         clock   : in std_logic;
         reset_n : out std_logic);
   end component;

   signal clock         : std_logic;
   signal reset_n       : std_logic;
   signal terminate_sim : std_logic;

begin

   uut : reset_logic
      port map (
         clock => clock,
         reset_n => reset_n
      );

   clock_gen : process
   begin
      clock <= '0';
      wait for CLOCK_PERIOD/2;
      clock <= '1';
      wait for CLOCK_PERIOD/2;

      if (terminate_sim = '1') then
         wait;
      end if;
   end process clock_gen;

   wave_gen : process
   begin
      terminate_sim <= '0';

      wait for 1000*CLOCK_PERIOD;

      assert (reset_n = '1')
         report "**************** ERROR: reset_n is not high (expected 0)"
         severity failure;

      terminate_sim <= '1';
      wait;
   end process wave_gen;

end testbench;
