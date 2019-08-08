----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    14:04:35 12/06/2015
-- Design Name:
-- Module Name:    divisore_onBoard - Structural
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

entity divisore_onBoard is
    Port ( in_byte : in  STD_LOGIC_VECTOR (7 downto 0);
           clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           start : in  STD_LOGIC;
           load_d : in  STD_LOGIC;
           load_v : in  STD_LOGIC;
           div_0 : out  STD_LOGIC;
           anodes : out  STD_LOGIC_VECTOR (3 downto 0);
           cathodes : out  STD_LOGIC_VECTOR (7 downto 0));
end divisore_onBoard;

architecture Structural of divisore_onBoard is

COMPONENT control_unit
	PORT(
		D : IN std_logic_vector(6 downto 0);
		V : IN std_logic_vector(3 downto 0);
		Q : IN std_logic_vector(3 downto 0);
		R : IN std_logic_vector(3 downto 0);
		clock : IN std_logic;
		reset_n : IN std_logic;
		load_d : IN std_logic;
		load_v : IN std_logic;
		done : IN std_logic;
		div_0 : IN std_logic;
		value : OUT std_logic_vector(15 downto 0);
		enable : OUT std_logic_vector(3 downto 0));
END COMPONENT;

COMPONENT registry_n_bit
	generic ( n : natural := 8;
			  delay : time := 0 ns);
    Port(  I : IN  STD_LOGIC_VECTOR (n-1 downto 0);
           clock : IN  STD_LOGIC;
           load : IN  STD_LOGIC;
           reset_n : IN  STD_LOGIC;
           O : OUT  STD_LOGIC_VECTOR (n-1 downto 0));
END COMPONENT;

COMPONENT divisore_restoring
	generic ( n : natural := 4 );
	PORT(
		D : IN  STD_LOGIC_VECTOR ((2*n)-2 downto 0);
		V : IN  STD_LOGIC_VECTOR (n-1 downto 0);
		enable : IN std_logic;
		reset_n : IN std_logic;
		clock : IN std_logic;
		done : OUT std_logic;
		div_per_zero : OUT std_logic;
		Q : OUT STD_LOGIC_VECTOR (n-1 downto 0);
		R : OUT STD_LOGIC_VECTOR (n-1 downto 0));
END COMPONENT;

COMPONENT display_seven_segments
	generic( clock_frequency_in : integer := 50000000;
			 clock_frequency_out : integer := 5000000);
	PORT(
		clock : IN std_logic;
		reset_n : IN std_logic;
		value : IN std_logic_vector(15 downto 0);
		enable : IN std_logic_vector(3 downto 0);
		dots : IN std_logic_vector(3 downto 0);
		anodes : OUT std_logic_vector(3 downto 0);
		cathodes : OUT std_logic_vector(7 downto 0));
END COMPONENT;

signal done_sig, div_0_sig, reset_n : std_logic := '0';
signal d_sig : std_logic_vector(6 downto 0)  := (others => '0');
signal v_sig, q_sig_in, q_sig_out, r_sig_in, r_sig_out, enable_sig : std_logic_vector(3 downto 0)  := (others => '0');
signal value_sig : std_logic_vector(15 downto 0)  := (others => '0');

begin

reset_n <= not reset;
div_0 <= div_0_sig;

control : control_unit
	PORT MAP(
		D => d_sig,
		V => v_sig,
		Q => q_sig_out,
		R => r_sig_out,
		clock => clock,
		reset_n => reset_n,
		load_d => load_d,
		load_v => load_v,
		done => done_sig,
		div_0 => div_0_sig,
		value => value_sig,
		enable => enable_sig
	);

registro_dividendo : registry_n_bit
	generic map(n => 7)
	PORT MAP(I => in_byte(6 downto 0), clock => clock, load => load_d, reset_n => reset_n, O => d_sig);

registro_divisore : registry_n_bit
	generic map(n => 4)
	PORT MAP(I => in_byte(3 downto 0), clock => clock, load => load_v, reset_n => reset_n, O => v_sig);

registro_quoziente : registry_n_bit
	generic map(n => 4)
	PORT MAP(I => q_sig_in, clock => clock, load => done_sig, reset_n => reset_n, O => q_sig_out);

registro_resto : registry_n_bit
	generic map(n => 4)
	PORT MAP(I => r_sig_in, clock => clock, load => done_sig, reset_n => reset_n, O => r_sig_out);

divisore: divisore_restoring
	generic map(n => 4)
	PORT MAP(
		D => d_sig,
		V => v_sig,
		enable => start,
		reset_n => reset_n,
		clock => clock,
		done => done_sig,
		div_per_zero => div_0_sig,
		Q => q_sig_in,
		R => r_sig_in
	);

display: display_seven_segments
	generic map(50000000, 500)
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

