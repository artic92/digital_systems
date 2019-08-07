----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    13:54:12 12/14/2015
-- Design Name:
-- Module Name:    orologio_onBoard - Structural
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

entity orologio_onBoard is
    Port ( 	clock : in STD_LOGIC;
           	reset : in STD_LOGIC;
           	enable : in STD_LOGIC;
			load_m : in STD_LOGIC;
			load_h : in STD_LOGIC;
			switch : in STD_LOGIC_VECTOR (5 downto 0);
           	cathodes : out STD_LOGIC_VECTOR (7 downto 0);
           	anodes : out STD_LOGIC_VECTOR (3 downto 0);
           	leds : out STD_LOGIC_VECTOR (5 downto 0));
end orologio_onBoard;

architecture Structural of orologio_onBoard is

COMPONENT orologio
	PORT(
			enable : IN std_logic;
			clock : IN std_logic;
			reset_n : IN std_logic;
			load_m : IN std_logic;
			load_h : IN std_logic;
			minuti_in : IN std_logic_vector (5 downto 0);
			ore_in : IN std_logic_vector (4 downto 0);
			secondi : OUT std_logic_vector(5 downto 0);
			minuti_out : OUT std_logic_vector (5 downto 0);
			ore_out : OUT std_logic_vector (4 downto 0)
		);
END COMPONENT;

for all : orologio use entity work.orologio(Structural);
--for all : orologio use entity work.orologio(versioneAlternativa);

COMPONENT display_seven_segments
	generic(clock_frequency_in : integer := 50000000;
			clock_frequency_out : integer := 5000000);
	PORT(
		clock : IN std_logic;
		reset_n : IN std_logic;
		value : IN std_logic_vector (15 downto 0);
		enable : IN std_logic_vector (3 downto 0);
		dots : IN std_logic_vector (3 downto 0);
		anodes : OUT std_logic_vector (3 downto 0);
		cathodes : OUT std_logic_vector (7 downto 0)
		);
END COMPONENT;

COMPONENT hex2bcd
	generic(n: positive := 16);
	PORT(
		clock : IN std_logic;
		reset_n : IN std_logic;
		binary_in : IN std_logic_vector (n-1 downto 0);
		bcd0, bcd1, bcd2, bcd3, bcd4 : OUT std_logic_vector (3 downto 0)
		);
END COMPONENT;

signal minuti_in_sig, minuti_out_sig : std_logic_vector (5 downto 0) := (others =>'0');
signal ore_in_sig, ore_out_sig : std_logic_vector (4 downto 0) := (others =>'0');
signal reset_n, enable_sig : std_logic := '0';
signal value_sig : std_logic_vector (15 downto 0) := (others => '0');
signal minuti_out_sig00, ore_out_sig000 : std_logic_vector (7 downto 0) := (others => '0');

begin

reset_n <= not reset;

minuti_out_sig00 <= "00" & minuti_out_sig;
ore_out_sig000 <= "000" & ore_out_sig;

set_ora_minuti_in : process(clock, reset_n, switch)
begin
	if reset_n = '0' then
		ore_in_sig <= (others => '0');
		minuti_in_sig <= (others => '0');
	elsif rising_edge(clock) then
		if load_m = '1' then
			minuti_in_sig <= switch;
		elsif load_h = '1' then
			ore_in_sig <= switch(4 downto 0);
		end if;
	end if;
end process;

-- Registro di 1 bit per la memorizzazione dell'evento pressione del tasto
enable_reg : process(clock, reset_n, enable)
begin
	if (reset_n = '0') then
		enable_sig <= '0';
	elsif (rising_edge(clock)) then
		if enable = '1' then
			enable_sig <= '1';
		end if;
	end if;
end process;

digital_clock: orologio
	PORT MAP(
		enable => enable_sig,
		clock => clock,
		reset_n => reset_n,
		load_m => load_m,
		load_h => load_h,
		minuti_in => minuti_in_sig,
		ore_in => ore_in_sig,
		secondi => leds,
		minuti_out => minuti_out_sig,
		ore_out => ore_out_sig
);

min2bcd: hex2bcd
	generic map(8)
	PORT MAP(
		clock => clock,
		reset_n => reset_n,
		binary_in => minuti_out_sig00,
		bcd0 => value_sig(3 downto 0),
		bcd1 => value_sig(7 downto 4),
		bcd2 => open,
		bcd3 => open,
		bcd4 => open
);

ore2bcd: hex2bcd
	generic map(8)
	PORT MAP(
		clock => clock,
		reset_n => reset_n,
		binary_in => ore_out_sig000,
		bcd0 => value_sig(11 downto 8),
		bcd1 => value_sig(15 downto 12),
		bcd2 => open,
		bcd3 => open,
		bcd4 => open
);

display: display_seven_segments
	generic map(50000000, 500)
	PORT MAP(
		clock => clock,
		reset_n => reset_n,
		value => value_sig,
		enable => "1111",
		dots => "0100",
		anodes => anodes,
		cathodes => cathodes
);

end Structural;

