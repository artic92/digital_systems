----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    14:04:35 12/06/2015
-- Design Name:
-- Module Name:    moltiplicatore_onBoard - Structural
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

entity moltiplicatore_onBoard is
    Port ( in_byte : in  STD_LOGIC_VECTOR (7 downto 0);
           clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           start : in  STD_LOGIC;
           load_a : in  STD_LOGIC;
           load_b : in  STD_LOGIC;
           anodes : out  STD_LOGIC_VECTOR (3 downto 0);
           cathodes : out  STD_LOGIC_VECTOR (7 downto 0));
end moltiplicatore_onBoard;

architecture Structural of moltiplicatore_onBoard is

COMPONENT control_unit
	PORT(
		A : IN std_logic_vector(7 downto 0);
		B : IN std_logic_vector(7 downto 0);
		P : IN std_logic_vector(15 downto 0);
		clock : IN std_logic;
		reset_n : IN std_logic;
		load_a : IN std_logic;
		load_b : IN std_logic;
		done : IN std_logic;
		value : OUT std_logic_vector(15 downto 0);
		enable : OUT std_logic_vector(3 downto 0)
		);
END COMPONENT;

COMPONENT register_n_bit
	generic ( n : natural := 8;
			  delay : time := 0 ns);
    Port ( I : IN  STD_LOGIC_VECTOR (n-1 downto 0);
           clock : IN  STD_LOGIC;
           load : IN  STD_LOGIC;
           reset_n : IN  STD_LOGIC;
           O : OUT  STD_LOGIC_VECTOR (n-1 downto 0));
END COMPONENT;

COMPONENT moltiplicatore_Robertson
	generic ( n : natural := 4;
			  m : natural := 4);
	PORT(
			A : in  STD_LOGIC_VECTOR (n-1 downto 0);
			B : in  STD_LOGIC_VECTOR (m-1 downto 0);
			enable : in STD_LOGIC;
			reset_n : in STD_LOGIC;
			clock : in STD_LOGIC;
			done : out STD_LOGIC;
			P : out  STD_LOGIC_VECTOR (n+m-1 downto 0));
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

signal done_sig, reset_n : std_logic := '0';
signal a_sig, b_sig : std_logic_vector(7 downto 0)  := (others => '0');
signal p_sig_in, p_sig_out : std_logic_vector(15 downto 0)  := (others => '0');
signal enable_sig : std_logic_vector(3 downto 0)  := (others => '0');
signal value_sig : std_logic_vector(15 downto 0)  := (others => '0');

begin

reset_n <= not reset;

control : control_unit
	PORT MAP(
		A => a_sig,
		B => b_sig,
		P => p_sig_out,
		clock => clock,
		reset_n => reset_n,
		load_a => load_a,
		load_b => load_b,
		done => done_sig,
		value => value_sig,
		enable => enable_sig
	);

registro_moltiplicando : register_n_bit
	generic map(n => 8)
	PORT MAP(I => in_byte, clock => clock, load => load_a, reset_n => reset_n, O => a_sig);

registro_moltiplicatore : register_n_bit
	generic map(n => 8)
	PORT MAP(I => in_byte, clock => clock, load => load_b, reset_n => reset_n, O => b_sig);

registro_prodotto : register_n_bit
	generic map(n => 16)
	PORT MAP(I => p_sig_in, clock => clock, load => done_sig, reset_n => reset_n, O => p_sig_out);

moltiplicatore: moltiplicatore_Robertson
	generic map(n => 8, m => 8)
	PORT MAP(
		A => a_sig,
		B => b_sig,
		enable => start,
		reset_n => reset_n,
		clock => clock,
		done => done_sig,
		P => p_sig_in
);

display: display_seven_segments
	generic map(clock_frequency_out => 400)
	PORT MAP(
		clock => clock,
		reset_n => reset_n,
		value => value_sig,
		enable => enable_sig,
		dots => "0000",
		anodes => anodes,
		cathodes => cathodes
);

end Structural;

