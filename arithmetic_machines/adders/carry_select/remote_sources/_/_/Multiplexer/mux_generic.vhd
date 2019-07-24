library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux_n is
	 generic( n : integer := 3);
    Port ( in_v : in  STD_LOGIC_VECTOR (2**n-1 downto 0);
           addr : in  STD_LOGIC_VECTOR (n-1 downto 0);
           selected : out  STD_LOGIC);
end mux_n;

architecture Dataflow of mux_n is

begin
	selected <= in_v(to_integer(unsigned(addr)));
end Dataflow; 
