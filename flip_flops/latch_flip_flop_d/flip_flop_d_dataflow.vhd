-------------------------------------------------------------------------------
--
-- Title       : Flip-flop D_edge-triggered con NOR
-- Design      : D_EDGE
-- Author      : Antonino Mazzeo
-- Company     : DIS
--
-------------------------------------------------------------------------------
--
-- File        : d_edge_nor.vhd
-- Generated   : Friday oct 21, 22:10:44 2011
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
-------------------------------------------------------------------------------
--
-- Description : Il flip flop d implementato � di tipo edge triggered sul fronte
-- 1->0 di discesa (trailing edge) del clock C
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity flip_flop_d_dataflow is
	generic ( td: time := 0.0 ns );
	port( 	D:	in std_logic;
			C:	in std_logic;
			Q:	out std_logic;
			NQ:	out std_logic
);
end flip_flop_d_dataflow;


architecture struct_6nor of flip_flop_d_dataflow is

signal	 G1   : STD_LOGIC;
signal	 G2   : STD_LOGIC;
signal	 G3   : STD_LOGIC;
signal	 G4   : STD_LOGIC;
signal	 G5   : STD_LOGIC;
signal	 G6   : STD_LOGIC;

begin

G1 <= D nor G2 after td;
G2 <= (G1 or G3) nor C after td;
-- G2 <= G3 nor C after td; --without G1, an alea would be generated
G3 <= C nor G4 after td;
G4 <= G3 nor G1 after td;
G5 <= G2 nor G6 after td;
G6 <= G5 nor G3 after td;

Q <= G6;
NQ <= G5;

end struct_6nor;
