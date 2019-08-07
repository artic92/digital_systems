----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    08:42:37 12/12/2015
-- Design Name:
-- Module Name:    clock_generator - Structural
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_generator is
    Port ( 	clk_base : out STD_LOGIC;
			clk0 : out  STD_LOGIC;
           	clk1 : out  STD_LOGIC;
           	clk2 : out  STD_LOGIC;
           	clk3 : out  STD_LOGIC);
end clock_generator;

architecture Structural of clock_generator is

COMPONENT contatore_modulo_n is
	generic (n : natural := 4);
    PORT(	clock : in  STD_LOGIC;
           	reset_n : in  STD_LOGIC;
           	count_en : in  STD_LOGIC;
			up_down : in STD_LOGIC;
           	mod_n : out  STD_LOGIC);
END COMPONENT;

COMPONENT freq_multiplier
	generic ( 	periodo_freq_in : time := 10 ns;
				mult_factor : natural := 2 );
	PORT( enable : IN std_logic;
		  clock : IN std_logic;
		  clock_out : OUT std_logic);
END COMPONENT;

COMPONENT freq_divider_pot2
	generic ( div_factor : natural := 2 );
	PORT( enable : IN std_logic;
		  clock : IN std_logic;
		  reset_n : IN std_logic;
		  clock_out : OUT std_logic);
END COMPONENT;

COMPONENT duty_50_to_70
	PORT( enable : IN std_logic;
		  clock_duty_50 : IN std_logic;
		  clock_duty_70 : OUT std_logic);
END COMPONENT;

signal base_clk, clk0_sig, clk1_sig, clk2500Mhz, clk250Mhz, clk780Mhz : std_logic := '0';

begin

------------------------------------------------------------------------
-- Base dei tempi, 100 MHz con duty cycle del 50 %
process(base_clk)
begin
	base_clk <= not base_clk after 5 ns;
end process;

clk_base <= base_clk;
------------------------------------------------------------------------

------------------------------------------------------------------------
-- Generazione clock a 25 MHz e duty cycle del 50 %
divider4: freq_divider_pot2
	generic map(4)
	PORT MAP(enable => '1', clock => base_clk, reset_n => '1', clock_out => clk0_sig);

clk0 <= clk0_sig;
------------------------------------------------------------------------

------------------------------------------------------------------------
-- Generazione clock a 25 MHz e duty cycle del 70 %
multiplier25MHzX10: freq_multiplier
	generic map(40 ns, 10)
	PORT MAP(enable => '1', clock => clk0_sig, clock_out =>  clk250Mhz);

duty_25MHz_50_to_70: duty_50_to_70
	PORT MAP(enable => '1', clock_duty_50 => clk250Mhz, clock_duty_70 => clk2);
------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Generazione clock a 78,125 MHz e duty cycle del 50 %
multiplier100MHzX25: freq_multiplier
	generic map(10 ns, 25)
	PORT MAP(enable => '1', clock => base_clk, clock_out =>  clk2500Mhz);

divider32: freq_divider_pot2
	generic map(32)
	PORT MAP(enable => '1', clock => clk2500Mhz, reset_n => '1', clock_out => clk1_sig);

clk1 <= clk1_sig;
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Generazione clock a 78,125 MHz e duty cycle del 70 %
multiplier78MHzX10: freq_multiplier
	generic map(12.8 ns, 10)
	PORT MAP(enable => '1', clock => clk1_sig, clock_out =>  clk780Mhz);

duty_78MHz_50_to_70: duty_50_to_70
	PORT MAP(enable => '1', clock_duty_50 => clk780Mhz, clock_duty_70 => clk3);
------------------------------------------------------------------------------

end Structural;

