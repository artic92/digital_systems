----------------------------------------------------------------------------------
-- Company:
-- Engineer: Antonio Riccio
--
-- Create Date:    19:39:58 11/23/2015
-- Design Name:
-- Module Name:    divisore_complementi_a_1 - Structural
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

-- Division between integers WITH sign in 1s complement
entity divisore_complementi_a_1 is
	generic ( n : natural := 4 );
    Port ( 	D : in  STD_LOGIC_VECTOR ((2*n)-1 downto 0);
           	V : in  STD_LOGIC_VECTOR (n-1 downto 0);
			enable : in STD_LOGIC;
			reset_n : in STD_LOGIC;
			clock : in STD_LOGIC;
			done : out STD_LOGIC;
			div_per_zero : out STD_LOGIC;
           	Q : out STD_LOGIC_VECTOR (n-1 downto 0);
			R : out STD_LOGIC_VECTOR (n-1 downto 0));
end divisore_complementi_a_1;

architecture Structural of divisore_complementi_a_1 is

COMPONENT divisore_non_restoring
	generic ( n : natural := 4 );
	PORT(
		D : in  STD_LOGIC_VECTOR ((2*n)-1 downto 0);
		V : in  STD_LOGIC_VECTOR (n-1 downto 0);
		enable : IN std_logic;
		reset_n : IN std_logic;
		clock : IN std_logic;
		done : OUT std_logic;
		div_per_zero : OUT std_logic;
		Q : out STD_LOGIC_VECTOR (n-1 downto 0);
		R : out STD_LOGIC_VECTOR (n-1 downto 0));
END COMPONENT;

signal done_sig : std_logic := '0';
signal d_sig : std_logic_vector((2*n)-1 downto 0);
signal v_sig, q_sig, r_sig : std_logic_vector(n-1 downto 0);

begin

-- l'elemento 2*n-1 (o n-1) è il bit di segno
d_sig <= '0' &	D((2*n)-2 downto 0);
v_sig <= '0' &	V(n-2 downto 0);

Inst_divisore_non_restoring: divisore_non_restoring
	generic map(n)
	PORT MAP(
		D => d_sig,
		V => v_sig,
		enable => enable,
		reset_n => reset_n,
		clock => clock,
		done => done_sig,
		div_per_zero => div_per_zero,
		Q => q_sig,
		R => r_sig
	);

done <= done_sig;
R <= r_sig;
Q <= (D((2*n)-1) xor V(n-1)) & q_sig(n-2 downto 0) and (q_sig'range =>done_sig);

-- complementi a 2 ( non funziona )
--d_sig <= (D xor (D'range => '1')) when (D((2*n)-2) = '1') else
--					D;
--v_sig <= (V xor (V'range => '1')) when (V(n-1) = '1') else
--					V;
--Q <= q_sig xor (q_sig'range => '1') when (D((2*n)-2) = '1') else
--					q_sig;

end Structural;
