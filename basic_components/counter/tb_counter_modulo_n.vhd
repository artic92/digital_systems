----------------------------------------------------------------------------------
--! @file tb_counter_modulo_n.vhd
--! @author Antonio Riccio
--! @brief Testbench for the configurable counter
--! @version 1.0
--! @date 30/07/2020
--! @copyright GNU Public License
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.ceil;
use ieee.math_real.log2;


use work.counter_modulo_n_pkg.all;

entity tb_counter_modulo_n is
end entity;

architecture tb of tb_counter_modulo_n is

   -- assuming 50 MHz system clock
   constant TB_CLK_PERIOD     : time := 20 ns;

   -- testbench signals
   signal tb_clock            : std_logic;
   signal tb_reset_n          : std_logic;
   signal tb_terminate        : boolean;

   -- uut signals
   signal count_en            : std_logic;
   signal up_down             : std_logic;
   signal count_load          : std_logic;
   signal count_in            : std_logic_vector ((natural(ceil(log2(real(counter_modulo)))))-1 downto 0);
   signal count_out           : std_logic_vector ((natural(ceil(log2(real(counter_modulo)))))-1 downto 0);
   signal count_hit           : std_logic;

   component counter_modulo_n is
      generic (
         n : natural);
      port (
         clock      : in  std_logic;
         reset_n    : in  std_logic;
         count_en   : in  std_logic;
         up_down    : in  std_logic;
         count_load : in  std_logic;
         count_in   : in  std_logic_vector ((natural(ceil(log2(real(n)))))-1 downto 0);
         count_out  : out std_logic_vector ((natural(ceil(log2(real(n)))))-1 downto 0);
         count_hit  : out std_logic);
   end component;

begin

   uut : counter_modulo_n
      generic map (
         n => counter_modulo)
      port map (
         clock      => tb_clock,
         reset_n    => tb_reset_n,
         count_en   => count_en,
         up_down    => up_down,
         count_load => count_load,
         count_in   => count_in,
         count_out  => count_out,
         count_hit  => count_hit);

   clk_gen : process
   begin
      tb_clock <= '0';
      wait for TB_CLK_PERIOD/2;
      tb_clock <= '1';
      wait for TB_CLK_PERIOD/2;

      if (tb_terminate = true) then
         wait;
      end if;
   end process;

   wavegen : process
   begin
      tb_terminate      <= false;


      report "********************************************************";
      report "[testbench] test #1: reset the component in upward count";
      report "********************************************************";
      tb_reset_n        <= '0';
      up_down           <= '0';
      wait for 5*TB_CLK_PERIOD;

      assert (count_out = x"0")
      report "[testbench] values mismatch!" &
         " actual=" & integer'image(to_integer(unsigned(count_out))) &
         ", expected=0"
      severity failure;

      wait for 5*TB_CLK_PERIOD;
      tb_reset_n        <= '1';

      report "************************************************";
      report "[testbench] test #2: executing upward count";
      report "************************************************";
      wait for 1*TB_CLK_PERIOD;
      count_en          <= '1';
      wait for 1*TB_CLK_PERIOD;

      wait until (count_hit = '1');
      count_en          <= '0';


      wait for 10*TB_CLK_PERIOD;


      report "**********************************************************";
      report "[testbench] test #3: reset the component in downward count";
      report "**********************************************************";
      tb_reset_n        <= '0';
      up_down           <= '1';

      wait for 2*TB_CLK_PERIOD;

      assert (count_out = x"F")
      report "[testbench] values mismatch!" &
         " actual=" & integer'image(to_integer(unsigned(count_out))) &
         ", expected=F"
      severity failure;

      wait for 5*TB_CLK_PERIOD;
      tb_reset_n        <= '1';

      report "***********************************";
      report "[testbench] test #4: downward count";
      report "***********************************";
      wait for 1*TB_CLK_PERIOD;
      count_en          <= '1';
      wait for 1*TB_CLK_PERIOD;

      wait until (count_hit = '1');
      count_en          <= '0';


      wait for 10*TB_CLK_PERIOD;


      report "***************************************************";
      report "[testbench] test #5: upward count starting from 0xA";
      report "***************************************************";
      tb_reset_n        <= '0';
      up_down           <= '0';
      wait for 5*TB_CLK_PERIOD;
      tb_reset_n        <= '1';

      wait for 2*TB_CLK_PERIOD;
      count_in          <= x"A";
      wait for 2*TB_CLK_PERIOD;
      count_load        <= '1';
      count_en          <= '1';
      wait for 2*TB_CLK_PERIOD;
      count_load        <= '0';

      wait until (count_hit = '1');
      count_en          <= '0';

      assert (count_out = x"F")
      report "[testbench] values mismatch!" &
         " actual=" & integer'image(to_integer(unsigned(count_out))) &
         ", expected=F"
      severity failure;

      wait for 5*TB_CLK_PERIOD;

      count_en          <= '1';
      wait until (count_hit = '1');
      count_en          <= '0';

      assert (count_out = x"F")
      report "[testbench] values mismatch!" &
         " actual=" & integer'image(to_integer(unsigned(count_out))) &
         ", expected=F"
      severity failure;


      wait for 10*TB_CLK_PERIOD;


      tb_terminate     <= true;
      report "****************************************************************";
      report "############################### TESTSUITE COMPLETED SUCCESSFULLY";
      report "****************************************************************";
      wait;
   end process;

end tb;
