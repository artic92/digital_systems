----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:    09:03:01 11/09/2015
-- Design Name:
-- Module Name:    inverter_chain - Structural
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

entity inverter_chain is
	generic (n : natural := 3;
			delay_inverter : time := 2 ns);
    Port ( i : in  STD_LOGIC;
           o : out  STD_LOGIC);
end inverter_chain;

architecture Structural of inverter_chain is

component inverter
	generic (delay : time := 0 ns);
	port (i : in std_logic;
				inv_o : out std_logic);
end component;

signal inv_sig : std_logic_vector (0 to n);

begin

inv_sig(0) <= i;
o <= inv_sig(n);

chain_for : for k in 0 to n-1 generate
my_inv : inverter
	generic map (delay => delay_inverter)
	port map (i => inv_sig(k), inv_o => inv_sig(k+1));
end generate;

end Structural;

