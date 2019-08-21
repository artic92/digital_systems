-- Vhdl test bench created from schematic FF_T_Preset.sch - Sun Dec 27 12:57:40 2015
--
-- Notes:
-- 1) This testbench template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the unit under test.
-- Xilinx recommends that these types always be used for the top-level
-- I/O of a design in order to guarantee that the testbench will bind
-- correctly to the timing (post-route) simulation model.
-- 2) To use this template as your testbench, change the filename to any
-- name of your choice with the extension .vhd, and use the "Source->Add"
-- menu in Project Navigator to import the testbench. Then
-- edit the user defined section below, adding code to generate the
-- stimulus for your design.
--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY UNISIM;
USE UNISIM.Vcomponents.ALL;
ENTITY FF_T_Preset_FF_T_Preset_sch_tb IS
END FF_T_Preset_FF_T_Preset_sch_tb;
ARCHITECTURE behavioral OF FF_T_Preset_FF_T_Preset_sch_tb IS

   COMPONENT FF_T_Preset
   PORT( T	:	IN	STD_LOGIC;
          Clock	:	IN	STD_LOGIC;
          Preset	:	IN	STD_LOGIC;
          Clear	:	IN	STD_LOGIC;
          Q	:	OUT	STD_LOGIC);
   END COMPONENT;

   SIGNAL T	:	STD_LOGIC;
   SIGNAL Clock	:	STD_LOGIC;
   SIGNAL Preset	:	STD_LOGIC;
   SIGNAL Clear	:	STD_LOGIC;
   SIGNAL Q	:	STD_LOGIC;

BEGIN

   UUT: FF_T_Preset PORT MAP(
		T => T,
		Clock => Clock,
		Preset => Preset,
		Clear => Clear,
		Q => Q
   );

-- *** Test Bench - User Defined Section ***
   tb : PROCESS
   BEGIN
	Clear <= '1', '0' after 10 ns;
	Preset <= '0';
	Clock <= '1', '0' after 60 ns, '1' after 110 ns, '0' after 140 ns;
	T <= '0', '1' after 20 ns, '0' after 80 ns, '1' after 100 ns;
      WAIT; -- will wait forever
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;
