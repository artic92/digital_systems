----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    22:36:40 12/16/2015
-- Design Name:
-- Module Name:    freq_divider_pot2 - Structural
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
use IEEE.math_real.log2;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity freq_divider_pot2 is
	generic ( div_factor : natural := 2 );
       Port ( enable : in  STD_LOGIC;
              clock : in  STD_LOGIC;
              reset_n : in  STD_LOGIC;
              clock_out : out  STD_LOGIC);
end freq_divider_pot2;

architecture Structural of freq_divider_pot2 is

COMPONENT contatore_modulo_n is
       generic (n : natural := 4);
       PORT(  clock : in  STD_LOGIC;
              reset_n : in  STD_LOGIC;
              count_en : in  STD_LOGIC;
              up_down : in STD_LOGIC;
              mod_n : out  STD_LOGIC);
END COMPONENT;

-- Posso dividere solo per potenze di due con soli contatori modulo 2
constant num_contatori : natural := natural (log2(real(div_factor)));
signal cl_count : std_logic_vector (num_contatori downto 0) := (others => '0');

begin

cl_count(0) <= clock;
clock_out <= cl_count(num_contatori);

count_gen : for i in 0 to num_contatori-1 generate
	counter_mod_2 : contatore_modulo_n
		generic map(2)
              port map(clock => cl_count(i), reset_n  => reset_n, count_en  => enable, up_down  => '0', mod_n => cl_count(i+1));
end generate;

end Structural;

