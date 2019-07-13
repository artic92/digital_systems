----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    22:47:11 12/02/2015
-- Design Name:
-- Module Name:    carry_ripple_on_board - Structural
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

entity carry_ripple_on_board is
    Port (	in_byte : in STD_LOGIC_VECTOR(7 downto 0);
			clock : in  STD_LOGIC;
           	reset : in  STD_LOGIC;
			load_a : in  STD_LOGIC;
			load_b : in  STD_LOGIC;
			anodes : out  STD_LOGIC_VECTOR (3 downto 0);
			cathodes : out  STD_LOGIC_VECTOR (7 downto 0);
			ovfl : out STD_LOGIC);
end carry_ripple_on_board;

architecture Structural of carry_ripple_on_board is

COMPONENT ripple_carry_adder
	generic (n : natural := 4);
	PORT(
		A : IN std_logic_vector(7 downto 0);
		B : IN std_logic_vector(7 downto 0);
		c_in : IN std_logic;
		ovfl : OUT std_logic;
		S : OUT std_logic_vector(7 downto 0)
		);
END COMPONENT;

COMPONENT display_seven_segments
	generic(clock_frequency_in : integer := 50000000;
			clock_frequency_out : integer := 5000000);
	PORT(
		clock : IN std_logic;
		reset_n : IN std_logic;
		value : IN std_logic_vector(15 downto 0);
		enable : IN std_logic_vector(3 downto 0);
		dots : IN std_logic_vector(3 downto 0);
		anodes : OUT std_logic_vector(3 downto 0);
		cathodes : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

COMPONENT control_unit
	PORT(
		in_byte : IN std_logic_vector(7 downto 0);
		S : IN std_logic_vector(7 downto 0);
		clock : IN std_logic;
		reset_n : IN std_logic;
		load_a : IN std_logic;
		load_b : IN std_logic;
		A : OUT std_logic_vector(7 downto 0);
		B : OUT std_logic_vector(7 downto 0);
		value : OUT std_logic_vector(15 downto 0)
		);
END COMPONENT;

signal reset_n : std_logic;
signal cu_value : std_logic_vector(15 downto 0);
constant cu_enable : std_logic_vector(3 downto 0) := "1011";
constant cu_dots : std_logic_vector(3 downto 0) := "0000";
signal a_sig, b_sig, s_sig: std_logic_vector(7 downto 0);

begin

reset_n <= not reset;

ripple_carry: ripple_carry_adder
	generic map(n => 8)
	PORT MAP(A => a_sig, B => b_sig, c_in => '0', ovfl => ovfl, S => s_sig);

display: display_seven_segments
	generic map(clock_frequency_out => 400)
	PORT MAP(
		clock => clock,
		reset_n => reset_n,
		value => cu_value,
		enable => cu_enable,
		dots => cu_dots,
		anodes => anodes,
		cathodes => cathodes
	);

cu: control_unit PORT MAP(
		in_byte => in_byte,
		S => s_sig,
		clock => clock,
		reset_n => reset_n,
		load_a => load_a,
		load_b => load_b,
		A => a_sig,
		B => b_sig,
		value => cu_value
	);

end Structural;

