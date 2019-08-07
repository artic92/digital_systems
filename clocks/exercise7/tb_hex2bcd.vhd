--------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:   12:43:33 12/21/2015
-- Design Name:
-- Module Name:   tb_hex2bcd.vhd
-- Project Name:  exercise7
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: hex2bcd
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

ENTITY tb_hex2bcd IS
END tb_hex2bcd;

ARCHITECTURE behavior OF tb_hex2bcd IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT hex2bcd
      PORT(
            clock : IN  std_logic;
            reset_n : IN  std_logic;
            binary_in : IN  std_logic_vector(15 downto 0);
            bcd0 : OUT  std_logic_vector(3 downto 0);
            bcd1 : OUT  std_logic_vector(3 downto 0);
            bcd2 : OUT  std_logic_vector(3 downto 0);
            bcd3 : OUT  std_logic_vector(3 downto 0);
            bcd4 : OUT  std_logic_vector(3 downto 0)
         );
    END COMPONENT;


   --Inputs
   signal clock : std_logic := '0';
   signal reset_n : std_logic := '0';
   signal binary_in : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal bcd0 : std_logic_vector(3 downto 0);
   signal bcd1 : std_logic_vector(3 downto 0);
   signal bcd2 : std_logic_vector(3 downto 0);
   signal bcd3 : std_logic_vector(3 downto 0);
   signal bcd4 : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: hex2bcd PORT MAP (
          clock => clock,
          reset_n => reset_n,
          binary_in => binary_in,
          bcd0 => bcd0,
          bcd1 => bcd1,
          bcd2 => bcd2,
          bcd3 => bcd3,
          bcd4 => bcd4
        );

   -- Clock process definitions
   clk_process :process
   begin
		clock <= '0';
		wait for clk_period/2;
		clock <= '1';
		wait for clk_period/2;
   end process;


   -- Stimulus process
   stim_proc: process
   begin
      -- hold reset_n state for 100 ns.
      wait for 100 ns;

      wait for clk_period*10;

      -- insert stimulus here
		reset_n <= '1';
      wait for 100 ns;

	   binary_in <= "0000000000001111";
      wait for 200 ns;

      binary_in <= "0000000001001111";
      wait for 200 ns;

      binary_in <= "0000000001111111";
      wait for 200 ns;

      binary_in <= "0000111101001111";
      wait for 2000 ns;

      wait;
   end process;

END;
