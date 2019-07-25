----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    19:39:58 11/23/2015
-- Design Name:
-- Module Name:    moltiplicatore_Robertson - Structural
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

-- Moltilplicando A, moltplicatore B
entity moltiplicatore_Robertson is
	generic (	n : natural := 4;
				m : natural := 4);
    Port ( 	A : in  STD_LOGIC_VECTOR (n-1 downto 0);
           	B : in  STD_LOGIC_VECTOR (m-1 downto 0);
			reset_n : in STD_LOGIC;
			enable : in STD_LOGIC;
			clock : in STD_LOGIC;
			done : out STD_LOGIC;
           	P : out  STD_LOGIC_VECTOR (n+m-1 downto 0));
end moltiplicatore_Robertson;

architecture Structural of moltiplicatore_Robertson is

COMPONENT parte_controllo
	generic ( 	n : natural := 4;
				m : natural := 4);
	PORT(
		clock : IN std_logic;
		reset_n_all : IN std_logic;
		enable : IN std_logic;
		q0 : IN std_logic;
		conteggio : IN std_logic;
		load_a : OUT std_logic;
		load_m : OUT std_logic;
		load_q : OUT std_logic;
		reset_n : OUT std_logic;
		shift : OUT std_logic;
		sel : OUT std_logic;
		sub : OUT std_logic;
		count_en : OUT std_logic;
		done : OUT std_logic
	);
END COMPONENT;

COMPONENT parte_operativa
	generic ( 	n : natural := 4;
				m : natural := 4);
	PORT(
		X : IN std_logic_vector(n-1 downto 0);
		Y : IN std_logic_vector(m-1 downto 0);
		subtract : IN std_logic;
		sel : IN std_logic;
		load_a : IN std_logic;
		load_q : IN std_logic;
		load_m : IN std_logic;
		reset_n : IN std_logic;
		shift : IN std_logic;
		clock : IN std_logic;
		q0 : OUT std_logic;
		P : OUT std_logic_vector(n+m-1 downto 0)
		);
END COMPONENT;

COMPONENT contatore_modulo_n
	generic (n : natural := 4);
	PORT ( clock : in  STD_LOGIC;
			reset_n : in  STD_LOGIC;
			count_en : in  STD_LOGIC;
			up_down : in STD_LOGIC;
			mod_n : out  STD_LOGIC);
END COMPONENT;

signal reset_sig, q0_sig, load_a_sig, load_q_sig, load_m_sig,
			shift_sig, sel_sig, sub_sig, cnt_en_sig, mod_n_sig, done_sig : std_logic := '0';
signal p_sig : std_logic_vector(n+m-1 downto 0);

signal sign : std_logic := '0';

begin

-- this conditional assignement solves the problem of zero's sign
sign <= '0' when (A = (A'range => '0')) or (B = (B'range => '0')) else
					(A(n-1) xor B(m-1));

P <= (sign & p_sig(n+m-2 downto 0)) and (p_sig'range => done_sig);

done <= done_sig;

PC: parte_controllo
	generic map(n,m)
	PORT MAP(
		clock => clock,
		reset_n_all => reset_n,
		enable => enable,
		q0 => q0_sig,
		conteggio => mod_n_sig,
		load_a => load_a_sig,
		load_m => load_m_sig,
		load_q => load_q_sig,
		reset_n => reset_sig,
		shift => shift_sig,
		sel => sel_sig,
		sub => sub_sig,
		count_en => cnt_en_sig,
		done => done_sig
);

PO: parte_operativa
	generic map(n,m)
	PORT MAP(
		X => A,
		Y => B,
		subtract => sub_sig,
		sel => sel_sig,
		load_a => load_a_sig,
		load_q => load_q_sig,
		load_m => load_m_sig,
		reset_n => reset_sig,
		shift => shift_sig,
		clock => clock,
		q0 => q0_sig,
		P => p_sig
);

contatore: contatore_modulo_n
	generic map(m-1)
	PORT MAP(
			clock => clock,
			reset_n => reset_sig,
			count_en => cnt_en_sig,
			up_down => '0',
			mod_n => mod_n_sig
);

end Structural;
