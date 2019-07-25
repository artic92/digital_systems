----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    12:58:19 12/20/2015
-- Design Name:
-- Module Name:    display_seven_segments - Structural
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

entity display_seven_segments is
	Generic(
				clock_frequency_in : integer := 50000000;
				clock_frequency_out : integer := 5000000);
    Port ( clock : in  STD_LOGIC;
           reset_n : in  STD_LOGIC;
           value : in  STD_LOGIC_VECTOR (15 downto 0);
           enable : in  STD_LOGIC_VECTOR (3 downto 0);
           dots : in  STD_LOGIC_VECTOR (3 downto 0);
           anodes : out  STD_LOGIC_VECTOR (3 downto 0);
           cathodes : out  STD_LOGIC_VECTOR (7 downto 0));
end display_seven_segments;

architecture Structural of display_seven_segments is

	COMPONENT mux_n
	generic( n : integer := 3 );
	PORT(
		in_v : IN STD_LOGIC_VECTOR (2**n-1 downto 0);
      addr : IN STD_LOGIC_VECTOR (n-1 downto 0);
	   selected : OUT std_logic);
	END COMPONENT;

	COMPONENT mux4n_1
	generic ( n : natural := 4 );
   PORT (
	  A : IN STD_LOGIC_VECTOR (n-1 downto 0);
	  B : IN STD_LOGIC_VECTOR (n-1 downto 0);
	  C : IN STD_LOGIC_VECTOR (n-1 downto 0);
	  D : IN STD_LOGIC_VECTOR (n-1 downto 0);
	  sel : IN STD_LOGIC_VECTOR (1 downto 0);
	  O : OUT STD_LOGIC_VECTOR (n-1 downto 0));
	END COMPONENT;

	COMPONENT clock_filter
	generic(clock_frequency_in : integer := 50000000;
						clock_frequency_out : integer := 5000000);
	PORT(
		clock_in : IN std_logic;
		reset_n : IN std_logic;
		clock_out : OUT std_logic);
	END COMPONENT;

	COMPONENT counter_modulo_n
	generic ( n : natural := 16 );
	PORT(
		clock : IN std_logic;
		count_en : IN std_logic;
		reset_n : IN std_logic;
		up_down : IN std_logic;
		load_conteggio : IN std_logic;
	   conteggio_in : IN STD_LOGIC_VECTOR (natural(ceil(log2(real(n))))-1 downto 0) := (others => '0');
      conteggio_out : OUT  STD_LOGIC_VECTOR ((natural(ceil(log2(real(n)))))-1 downto 0);
		count_hit : OUT std_logic);
	END COMPONENT;

	COMPONENT nibble2cathod
	PORT(
		digit : IN std_logic_vector(3 downto 0);
		cathods : OUT std_logic_vector(6 downto 0));
	END COMPONENT;

	COMPONENT anodes_manager
	PORT(
		counter : IN std_logic_vector(1 downto 0);
		enable_digit : IN std_logic_vector(3 downto 0);
		anodes : OUT std_logic_vector(3 downto 0));
	END COMPONENT;

	signal enable_sig, dots_sig : std_logic := '0';
	signal sel_sig : std_logic_vector (1 downto 0) := (others => '0');
	signal nibble_sig : std_logic_vector (3 downto 0) := (others => '0');

begin

	cathodes(7) <= not dots_sig;

	clk_filter: clock_filter
	generic map(clock_frequency_in, clock_frequency_out)
	PORT MAP(
		clock_in => clock,
		reset_n => reset_n,
		clock_out => enable_sig
	);

	counter_modulo_4: counter_modulo_n
	generic map(4)
	PORT MAP(
		clock => clock,
		count_en => enable_sig,
		reset_n => reset_n,
		up_down => '1',
		load_conteggio => '0',
		conteggio_in => open,
		conteggio_out => sel_sig,
		count_hit => open
	);

	value_to_nibble: mux4n_1
	generic map(4)
	PORT MAP(
		A => value(3 downto 0),
		B => value(7 downto 4),
		C => value(11 downto 8),
		D => value(15 downto 12),
		sel => sel_sig,
		O => nibble_sig
	);

	dots_to_cathodes: mux_n
	generic map(2)
	PORT MAP(
		in_v => dots,
		addr => sel_sig,
		selected => dots_sig
	);

	cathodes_manager: nibble2cathod
	PORT MAP(
		digit => nibble_sig,
		cathods => cathodes(6 downto 0)
	);

	anodes_instance: anodes_manager
	PORT MAP(
		counter => sel_sig,
		enable_digit => enable,
		anodes => anodes
	);

end Structural;

