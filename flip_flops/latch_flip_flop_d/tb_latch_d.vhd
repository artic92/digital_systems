--------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:   17:03:36 01/16/2016
-- Design Name:
-- Module Name:   tb_latch_d.vhd
-- Project Name:  latch_flip_flop_d
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: latch_d
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

ENTITY tb_latch_d IS
END tb_latch_d;

ARCHITECTURE behavior OF tb_latch_d IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT latch_d
      PORT(
            d : IN  std_logic;
            q : OUT  std_logic;
            qn : OUT  std_logic
         );
    END COMPONENT;


   --Inputs
   signal d : std_logic := '0';

 	--Outputs
   signal q : std_logic;
   signal qn : std_logic;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: latch_d PORT MAP (
          d => d,
          q => q,
          qn => qn
        );

   -- Stimulus process
   stim_proc: process
   begin
      -- hold reset state for 100 ns.
--      wait for 100 ns;

      -- insert stimulus here
		d <= '1', '0' after 20 ns, '1' after 50 ns, '0' after 100 ns;

      wait;
   end process;

END;
