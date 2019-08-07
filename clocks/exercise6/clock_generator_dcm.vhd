----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    11:10:55 12/12/2015
-- Design Name:
-- Module Name:    clock_generator_dcm - Structural
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

entity clock_generator_dcm is
	Port (  clk_base : out STD_LOGIC;
			clk0 : out  STD_LOGIC;
           	clk1 : out  STD_LOGIC;
           	clk2 : out  STD_LOGIC;
           	clk3 : out  STD_LOGIC);
end clock_generator_dcm;

architecture Structural of clock_generator_dcm is

COMPONENT dcm
	PORT(
		CLKIN_IN : IN std_logic;
		CLKFX_OUT : OUT std_logic;
		CLK0_OUT : OUT std_logic);
END COMPONENT;

COMPONENT clock78MHz
	PORT(
		CLKIN_IN : IN std_logic;
		CLKFX_OUT : OUT std_logic;
		CLK0_OUT : OUT std_logic);
END COMPONENT;

COMPONENT freq_multiplier
	generic ( periodo_freq_in : time := 10 ns;
			  mult_factor : natural := 2 );
	PORT( enable : IN std_logic;
		  clock : IN std_logic;
		  clock_out : OUT std_logic);
END COMPONENT;

COMPONENT duty_50_to_70
	PORT( enable : IN std_logic;
		clock_duty_50 : IN std_logic;
		clock_duty_70 : OUT std_logic);
END COMPONENT;

signal base_clk, clk0_sig,  clk1_sig, clk250Mhz, clk780Mhz : std_logic := '0';

begin

-----------------------------------------------------------------------
-- Base dei tempi, 100 MHz con duty cycle del 50 %
process(base_clk)
begin
	base_clk <= not base_clk after 5 ns;
end process;

clk_base <= base_clk;
-----------------------------------------------------------------------

------------------------------------------------------------------------
-- 1) Generazione clock a 25 MHz e duty cycle del 50 %
clock_25MHz: dcm
	PORT MAP(CLKIN_IN => base_clk, CLKFX_OUT => clk0_sig, CLK0_OUT => clk_base);

clk0 <= clk0_sig;
------------------------------------------------------------------------

------------------------------------------------------------------------------
-- 2) Generazione clock a 78,125 MHz e duty cycle del 50 %
clock_78MHz: clock78MHz
	PORT MAP(CLKIN_IN => base_clk, CLKFX_OUT => clk1_sig, CLK0_OUT => clk_base);

clk1 <= clk1_sig;
------------------------------------------------------------------------------

------------------------------------------------------------------------
-- 3) Generazione clock a 25 MHz e duty cycle del 70 %
multiplier25MHzX10: freq_multiplier
	generic map(40 ns, 10)
	PORT MAP(enable => '1', clock => clk0_sig, clock_out =>  clk250Mhz);

duty_25MHz_50_to_70: duty_50_to_70
	PORT MAP(enable => '1', clock_duty_50 => clk250Mhz, clock_duty_70 => clk2);
------------------------------------------------------------------------

------------------------------------------------------------------------------
-- 4) Generazione clock a 78,125 MHz e duty cycle del 70 %
multiplier78MHzX10: freq_multiplier
	generic map(12.8 ns, 10)
	PORT MAP(enable => '1', clock => clk1_sig, clock_out =>  clk780Mhz);

duty_78MHz_50_to_70: duty_50_to_70
	PORT MAP(enable => '1', clock_duty_50 => clk780Mhz, clock_duty_70 => clk3);
------------------------------------------------------------------------------

end Structural;

