library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.memory_cell_pkg.all;

entity tb_memory_cell is
end entity;

architecture tb of tb_memory_cell is

   -- assuming 50 MHz system clock
   constant TB_CLK_PERIOD     : time := 20 ns;

   -- testbench signals
   signal tb_clock            : std_logic;
   signal tb_reset_n          : std_logic;
   signal tb_terminate        : boolean;

   -- uut signals
   signal load                : std_logic;
   signal I                   : std_logic_vector(memory_cell_parallelism_bit-1 downto 0);
   signal O                   : std_logic_vector(memory_cell_parallelism_bit-1 downto 0);

   component memory_cell is
      generic (
         n 						: natural;
         delay 				: time);
       port (
         clock 				: in   std_logic;
         async_reset_n		: in   std_logic;
         load 					: in   std_logic;
         I 						: in   std_logic_vector(n-1 downto 0);
         O						: out  std_logic_vector(n-1 downto 0));
   end component;

begin

   uut : memory_cell
      generic map (
         n     => memory_cell_parallelism_bit,
         delay => memory_cell_parallelism_delay)
      port map (
         clock         => tb_clock,
         async_reset_n => tb_reset_n,
         load          => load,
         I             => I,
         O             => O);

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

      tb_reset_n        <= '0';
      wait for 10*TB_CLK_PERIOD;
      tb_reset_n        <= '1';

      report "************************************";
      report "[testbench] test #1: loading a value";
      report "************************************";
      I                 <= "1";
      load              <= '0';
      wait for 1*TB_CLK_PERIOD;
      load              <= '1';

      wait for 2*TB_CLK_PERIOD;

      assert (O = I)
         report "[testbench] values mismatch!" &
            " actual=" & integer'image(to_integer(unsigned(O))) &
            ", expected=" & integer'image(to_integer(unsigned(I)))
      severity failure;

      wait for 2*TB_CLK_PERIOD;

      report "********************************************";
      report "[testbench] test #2: resetting while loading";
      report "********************************************";
      load              <= '1';
      tb_reset_n        <= '0';
      wait for 10*TB_CLK_PERIOD;
      tb_reset_n        <= '1';

      assert (O = "0")
         report "[testbench] values mismatch!" &
            " actual=" & integer'image(to_integer(unsigned(O))) &
            ", expected=" & integer'image(to_integer(unsigned(I)))
         severity failure;

      tb_terminate     <= true;
      report "****************************************************************";
      report "############################### TESTSUITE COMPLETED SUCCESSFULLY";
      report "****************************************************************";
      wait;
   end process;

end tb;
