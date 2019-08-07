----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    19:11:51 12/16/2015
-- Design Name:
-- Module Name:    orologio - Structural
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.math_real.ceil;
use IEEE.math_real.log2;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity orologio is
	Port ( 	enable : in STD_LOGIC;
			clock : in STD_LOGIC;
			reset_n : in STD_LOGIC;
			load_m : in STD_LOGIC;
			load_h : in STD_LOGIC;
			minuti_in : in  STD_LOGIC_VECTOR(5 downto 0);
			ore_in : in STD_LOGIC_VECTOR(4 downto 0);
			secondi : out  STD_LOGIC_VECTOR(5 downto 0);
          	minuti_out : out  STD_LOGIC_VECTOR(5 downto 0);
          	ore_out : out  STD_LOGIC_VECTOR(4 downto 0));
end orologio;

architecture Structural of orologio is

COMPONENT due_contatori
	generic ( max_conteggio1 : integer := 4;
			  max_conteggio2 : natural := 60);
	PORT(
		clock : IN std_logic;
		count_in : IN std_logic;
		reset_n : IN std_logic;
		load_conteggio1 : IN std_logic;
		load_conteggio2 : IN std_logic;
	   	conteggio1_in : in std_logic_vector (natural(ceil(log2(real(max_conteggio1))))-1 downto 0) := (others =>'0');
	   	conteggio2_in : in std_logic_vector (natural(ceil(log2(real(max_conteggio2))))-1 downto 0) := (others =>'0');
	   	conteggio2_out : out  std_logic_vector (natural(ceil(log2(real(max_conteggio2))))-1 downto 0) := (others =>'0');
		count_hit : OUT std_logic
		);
END COMPONENT;

COMPONENT contatore_modulo_n
	generic ( n : natural := 4 );
	PORT(
		clock : IN std_logic;
		reset_n : IN std_logic;
		count_en : IN std_logic;
		up_down : IN std_logic;
		mod_n : OUT std_logic
		);
END COMPONENT;

constant max3_c : natural := 3599999;

signal temp_ore_x60000 : std_logic_vector (natural(ceil(log2(real(max3_c))))-1 downto 0) := (others =>'0');
signal out_ms_sig : std_logic := '0';

begin

-- In case the user assings to the minutes an initial value of 59, then the hours contator must increment
-- at the next minute. To do so, the contator conteggio1 of gen_ore must start to count from the equivalent
-- in ms of 59 minutes. To this end, the signal temp_ore_x60000 is defined.
temp_ore_x60000 <= minuti_in * conv_STD_LOGIC_VECTOR(60000, 16);

count50MHzto1000Hz: contatore_modulo_n
	generic map(50000)
	PORT MAP(
	clock => clock,
	reset_n => reset_n,
	count_en => enable,
	up_down => '0',
	mod_n => out_ms_sig
);

gen_secondi: due_contatori
	generic map(999, 59)
	PORT MAP(
		clock => clock,
		count_in => out_ms_sig,
		reset_n => reset_n,
		load_conteggio1 => '0',
		load_conteggio2 => '0',
		conteggio1_in => open,
		conteggio2_in => open,
		conteggio2_out => secondi,
		count_hit => open
);

gen_minuti: due_contatori
	generic map(59999, 59)
	PORT MAP(
		clock => clock,
		count_in =>  out_ms_sig,
		reset_n => reset_n,
		load_conteggio1 => '0',
		load_conteggio2 => load_m,
		conteggio1_in => open,
		conteggio2_in => minuti_in,
		conteggio2_out => minuti_out,
		count_hit=> open
);

gen_ore: due_contatori
	generic map(max3_c, 23)
	PORT MAP(
		clock => clock,
		count_in => out_ms_sig,
		reset_n => reset_n,
		load_conteggio1 => load_m,
		load_conteggio2 => load_h,
		conteggio1_in => temp_ore_x60000,
		conteggio2_in => ore_in,
		conteggio2_out => ore_out,
		count_hit => open
);

end Structural;

architecture versioneAlternativa of orologio is

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

COMPONENT contatore_modulo_n
	generic ( n : natural := 4 );
	PORT(
		clock : IN std_logic;
		reset_n : IN std_logic;
		count_en : IN std_logic;
		up_down : IN std_logic;
		mod_n : OUT std_logic
		);
END COMPONENT;

COMPONENT livelli2impulsi
	PORT(
		input : IN std_logic;
		clock : IN std_logic;
		output : OUT std_logic
		);
END COMPONENT;

constant max3_c : natural := 3600000;
signal temp_ore_x60000 : std_logic_vector (natural(ceil(log2(real(max3_c))))-1 downto 0) := (others =>'0');
signal out_ms_sig, out_s_livelli, out_s_impulsivo, out_m_livelli, out_m_impulsivo, out_h_livelli, out_h_impulsivo : std_logic := '0';

begin

temp_ore_x60000 <= minuti_in * conv_STD_LOGIC_VECTOR(60000, 16);

gen_ms: contatore_modulo_n
	generic map(50000)
	PORT MAP(
	clock => clock,
	reset_n => reset_n,
	count_en => enable,
	up_down => '0',
	mod_n => out_ms_sig
);

gen_sec: contatore_modulo_n
	generic map(1000)
	PORT MAP(
		clock => clock,
		reset_n => reset_n,
		count_en => out_ms_sig,
		up_down => '0',
		mod_n => out_s_livelli
);

gen_min: contatore_modulo_n
	generic map(60000)
	PORT MAP(
		clock => clock,
		reset_n => reset_n,
		count_en => out_s_impulsivo,
		up_down => '0',
		mod_n => out_m_livelli
);

gen_ore: counter_modulo_n
	generic map(max3_c)
	PORT MAP(
		clock => clock,
		count_en => out_s_impulsivo,
		reset_n => reset_n,
		up_down => '0',
		load_conteggio => load_m,
		conteggio_in => temp_ore_x60000,
		conteggio_out => open,
		count_hit => out_h_livelli
);

gen_sec_impulsivo: livelli2impulsi
	PORT MAP(
		input => out_s_livelli,
		clock => clock,
		output => out_s_impulsivo
);

gen_min_impulsivo: livelli2impulsi
	PORT MAP(
		input => out_m_livelli,
		clock => clock,
		output => out_m_impulsivo
);

gen_ore_impulsivo: livelli2impulsi
	PORT MAP(
		input => out_h_livelli,
		clock => clock,
		output => out_h_impulsivo
);

out_sec: counter_modulo_n
	generic map(59)
	PORT MAP(
		clock => clock,
		count_en => out_s_impulsivo,
		reset_n => reset_n,
		up_down => '0',
		load_conteggio => '0',
		conteggio_in => open,
		conteggio_out => secondi,
		count_hit => open
);

out_min: counter_modulo_n
	generic map(59)
	PORT MAP(
		clock => clock,
		count_en => out_m_impulsivo,
		reset_n => reset_n,
		up_down => '0',
		load_conteggio => load_m,
		conteggio_in => minuti_in,
		conteggio_out => minuti_out,
		count_hit => open
);

out_ore: counter_modulo_n
	generic map(23)
	PORT MAP(
		clock => clock,
		count_en => out_h_impulsivo,
		reset_n => reset_n,
		up_down => '0',
		load_conteggio => load_h,
		conteggio_in => ore_in,
		conteggio_out => ore_out,
		count_hit => open
);

end versioneAlternativa;
