--------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:   15:33:01 01/16/2016
-- Design Name:
-- Module Name:   tb_latch_rs.vhd
-- Project Name:  latch_flip_flop_rs
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: latch_rs
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

ENTITY tb_latch_rs IS
END tb_latch_rs;

ARCHITECTURE behavior OF tb_latch_rs IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT latch_rs
      generic(   delay_nor_nand : time := 1 ns;
                 nor_nand : natural := 1);
      PORT(
            r : IN  std_logic;
            s : IN  std_logic;
            q : OUT  std_logic;
            qn : OUT  std_logic
         );
    END COMPONENT;

   --Inputs
   signal r : std_logic := '0';
   signal s : std_logic := '0';

 	--Outputs
   signal q : std_logic;
   signal qn : std_logic;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: latch_rs PORT MAP (
          r => r,
          s => s,
          q => q,
          qn => qn
        );

   -- Stimulus process
   stim_proc: process
   begin
      -- hold reset state for 100 ns.
--      wait for 100 ns;

      -- insert stimulus here
		-- NOR architecture tests (1-attive signals)
--		r <= '0', '0' after 5 ns, '1' after 20 ns, '0' after 30 ns;
--		s <= '1', '0' after 5 ns, '1' after 20 ns, '0' after 30 ns;

		-- NAND architecture tests (0-attive signals)
		r <= '1', '1' after 5 ns, '0' after 20 ns, '1' after 30 ns;
		s <= '0', '1' after 5 ns, '0' after 20 ns, '1' after 30 ns;

      wait;
   end process;

END;
