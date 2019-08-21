-- Vhdl test bench created from schematic JK_Preset_MS.sch - Sun Dec 27 15:12:42 2015
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
ENTITY JK_Preset_MS_JK_Preset_MS_sch_tb IS
END JK_Preset_MS_JK_Preset_MS_sch_tb;
ARCHITECTURE behavioral OF JK_Preset_MS_JK_Preset_MS_sch_tb IS

   COMPONENT JK_Preset_MS
   PORT( J	:	IN	STD_LOGIC;
          Clock	:	IN	STD_LOGIC;
          Clear	:	IN	STD_LOGIC;
          Preset	:	IN	STD_LOGIC;
          Qn	:	OUT	STD_LOGIC;
          Q	:	OUT	STD_LOGIC;
          K	:	IN	STD_LOGIC);
   END COMPONENT;

	constant clock_period : time := 40 ns;

   SIGNAL J	:	STD_LOGIC;
   SIGNAL Clock	:	STD_LOGIC := '0';
   SIGNAL Clear	:	STD_LOGIC;
   SIGNAL Preset	:	STD_LOGIC;
   SIGNAL Qn	:	STD_LOGIC;
   SIGNAL Q	:	STD_LOGIC;
   SIGNAL K	:	STD_LOGIC;

BEGIN

   UUT: JK_Preset_MS PORT MAP(
		J => J,
		K => K,
		Clock => Clock,
		Clear => Clear,
		Preset => Preset,
		Qn => Qn,
		Q => Q
   );

	clock_gen : process(clock)
	begin
		Clock <= not Clock after clock_period/2;
	end process;

-- *** Test Bench - User Defined Section ***
   tb : PROCESS
   BEGIN
	Clear <= '1', '0' after clock_period;
	Preset <= '0';
	J <= '0', '0' after 2*clock_period, '1' after 3*clock_period, '1' after 4*clock_period, '1' after 7*clock_period, '0' after 8*clock_period;
	K <= '0', '1' after 2*clock_period, '0' after 3*clock_period, '1' after 4*clock_period, '0' after 7*clock_period, '0' after 8*clock_period;
      WAIT; -- will wait forever
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;
