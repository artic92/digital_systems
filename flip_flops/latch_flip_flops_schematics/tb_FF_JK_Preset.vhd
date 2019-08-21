-- Vhdl test bench created from schematic FF_JK_Preset.sch - Mon Dec 14 19:47:36 2015
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
ENTITY FF_JK_Preset_FF_JK_Preset_sch_tb IS
END FF_JK_Preset_FF_JK_Preset_sch_tb;
ARCHITECTURE behavioral OF FF_JK_Preset_FF_JK_Preset_sch_tb IS

   COMPONENT FF_JK_Preset
   PORT( Clear	:	IN	STD_LOGIC;
          Preset	:	IN	STD_LOGIC;
          J	:	IN	STD_LOGIC;
          K	:	IN	STD_LOGIC;
          Clock	:	IN	STD_LOGIC;
          Qn	:	OUT	STD_LOGIC;
          Q	:	OUT	STD_LOGIC);
   END COMPONENT;

   SIGNAL Clear	:	STD_LOGIC;
   SIGNAL Preset	:	STD_LOGIC;
   SIGNAL J	:	STD_LOGIC;
   SIGNAL K	:	STD_LOGIC;
   SIGNAL Clock	:	STD_LOGIC := '0';
   SIGNAL Qn	:	STD_LOGIC;
   SIGNAL Q	:	STD_LOGIC;

BEGIN

   UUT: FF_JK_Preset PORT MAP(
		Clear => Clear,
		Preset => Preset,
		J => J,
		K => K,
		Clock => Clock,
		Qn => Qn,
		Q => Q
   );

-- *** Test Bench - User Defined Section ***
   tb : PROCESS
   BEGIN
		Clear <= '1','0' after 5 ns;
		Preset <= '0';
		Clock <= '1', '0' after 75 ns;
		-- Sequenza prof (NB: presenza di funzionamento non fondamentale nell'ultima transizione -> prensenza di corse)
--		J <= '0', '1' after 10 ns, '0' after 20 ns, '1' after 35 ns, '0' after 70 ns, '1' after 80 ns,  '0' after 90 ns, '1' after 105 ns,
--					'0' after 140 ns;
--		K <= '0', '1' after 25 ns, '0' after 70 ns, '1' after 95 ns, '0' after 140 ns;
		J <=  '0', '0' after 10 ns, '1' after 20 ns, '1' after 30 ns, '1' after 60 ns, '0' after 70 ns;
		K <= '0', '1' after 10 ns, '0' after 20 ns, '1' after 30 ns, '0' after 60 ns, '0' after 70 ns;
		-- Oscillazione
--		J <= '0', '1' after 20 ns;
--		K <= '0', '1' after 20 ns;
      WAIT; -- will wait forever
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;
