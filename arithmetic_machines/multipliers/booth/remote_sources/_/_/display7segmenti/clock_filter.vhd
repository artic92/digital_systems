----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    14:38:42 12/20/2015
-- Design Name:
-- Module Name:    clock_filter - Structural
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
use IEEE.math_real.ceil;
use IEEE.math_real.log2;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_filter is
	generic(clock_frequency_in : integer := 50000000;
						clock_frequency_out : integer := 5000000);
    Port ( clock_in : in  STD_LOGIC;
				reset_n : in STD_LOGIC;
            clock_out : out  STD_LOGIC);
end clock_filter;

architecture Structural of clock_filter is

	COMPONENT counter_modulo_n
	generic ( n : natural := 16 );
	PORT(
		clock : IN std_logic;
		count_en : IN std_logic;
		reset_n : IN std_logic;
		up_down : IN std_logic;
		load_conteggio : IN std_logic;
	   conteggio_in : IN STD_LOGIC_VECTOR (natural(ceil(log2(real(n))))-1 downto 0) := (others => '0');
      conteggio_out : OUT STD_LOGIC_VECTOR ((natural(ceil(log2(real(n)))))-1 downto 0);
		count_hit : OUT std_logic);
	END COMPONENT;

	constant modulo_n : natural := (clock_frequency_in/clock_frequency_out);

begin

	Inst_counter_modulo_n: counter_modulo_n
	generic map(modulo_n)
	PORT MAP(
		clock => clock_in,
		count_en => '1',
		reset_n => reset_n,
		up_down => '0',
		load_conteggio => '0',
		conteggio_in => open,
		conteggio_out => open,
		count_hit => clock_out
	);

end Structural;

