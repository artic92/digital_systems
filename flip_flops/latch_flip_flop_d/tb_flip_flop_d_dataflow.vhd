--------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:   21:09:08 10/28/2012
-- Design Name:
-- Module Name:   tb_flip_flop_d_dataflow.vhd
-- Project Name:  latch_flip_flop_d
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: flip_flop_d_dataflow
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes:
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;

ENTITY tb_flip_flop_d_dataflow IS
END tb_flip_flop_d_dataflow;

ARCHITECTURE behavior OF tb_flip_flop_d_dataflow IS

	-- Component Declaration for the Unit Under Test (UUT)

    COMPONENT flip_flop_d_dataflow
		generic ( td: time:=0.5 ns );
		PORT(	D:	in std_logic;
	    		C:	in std_logic;
	    		Q:	out std_logic;
		 		NQ:  out std_logic);
	 END COMPONENT;


	constant clk_period : time := 10 ns;

	signal D, Q, NQ, clk: std_logic;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: flip_flop_d_dataflow port map(D,clk,Q,NQ);

	-- Clock process definitions
	  clk_process :process
	  begin
			clk <= '0';
			wait for clk_period/2;
			clk <= '1';
			wait for clk_period/2;
	  end process;


	-- Stimulus process
	stim_proc: process
	begin
		-- hold reset state for 10 ns.
	    -- wait for 10 ns;
	    -- wait for clk_period*10;

		-- insert stimulus here
		D <= '1' after 5 ns, '0' after 15.5 ns, '0' after 18 ns,'1' after 21 ns,'0' after 23 ns,
		     '1' after 25 ns,'0' after 40 ns, '1' after 43 ns, '0' after 48 ns, '0' after 52 ns,
			 '1' after 57 ns,'0' after 61 ns,'1' after 65 ns,'0' after 69 ns;

		-- D <= '0', '1' after 70 ns, '0' after 120 ns, '1' after 190ns,'0' after 210 ns,'0' after 230 ns;

	--    other pattern:
		-- D <= not D after 6 ns;
      wait;
   end process;

END;
