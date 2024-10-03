
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY LogicalStep_Lab4_top IS
   PORT
	(
   clkin_50		: in	std_logic;							-- The 50 MHz FPGA Clockinput
	rst_n			: in	std_logic;							-- The RESET input (ACTIVE LOW)
	pb_n			: in	std_logic_vector(3 downto 0); -- The push-button inputs (ACTIVE LOW)
 	sw   			: in  std_logic_vector(7 downto 0); -- The switch inputs
   leds			: out std_logic_vector(7 downto 0);	-- for displaying the the lab4 project details
	-------------------------------------------------------------
	-- you can add temporary output ports here if you need to debug your design 
	-- or to add internal signals for your simulations
	-------------------------------------------------------------
	
   seg7_data 	: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  : out	std_logic;							-- seg7 digi selectors
	seg7_char2  : out	std_logic							-- seg7 digi selectors
	);
END LogicalStep_Lab4_top;

ARCHITECTURE SimpleCircuit OF LogicalStep_Lab4_top IS

   component segment7_mux port (
          clk        : in  std_logic := '0';
			 DIN2 		: in  std_logic_vector(6 downto 0);	--bits 6 to 0 represent segments G,F,E,D,C,B,A
			 DIN1 		: in  std_logic_vector(6 downto 0); --bits 6 to 0 represent segments G,F,E,D,C,B,A
			 DOUT			: out	std_logic_vector(6 downto 0);
			 DIG2			: out	std_logic;
			 DIG1			: out	std_logic
   );
   end component;

   component clock_generator port (
			sim_mode			: in boolean;
			reset				: in std_logic;
         clkin      		: in  std_logic;
			sm_clken			: out	std_logic;
			blink		  		: out std_logic
  );
   end component;

   component pb_inverters port (
			 pb_n					: in std_logic_vector(3 downto 0);
			 pb			  		: out std_logic_vector(3 downto 0)
  );
   end component;

	
	component synchronizer port(
			clk					: in std_logic;
			reset					: in std_logic;
			din					: in std_logic;
			dout					: out std_logic
  );
   end component;
 
  component holding_register port (
			clk					: in std_logic;
			reset					: in std_logic;
			register_clr			: in std_logic;
			din					: in std_logic;
			dout					: out std_logic;
			ledout:out std_logic
  );
  end component;
  
  component State_Machine_traffic port(
 clk_input, reset, hold1, hold2,blink_sig			: IN std_logic;
 red1, green1, yellow1,red2, green2, yellow2, ns_display, ew_display, reset1, reset2: out std_logic;
 state_num: out std_logic_vector (3 downto 0)
 );
 end component;
	
----------------------------------------------------------------------------------------------------
	CONSTANT	sim_mode						: boolean := FALSE; -- set to FALSE for LogicalStep board downloads
	                                                     -- set to TRUE for SIMULATIONS
	
	
	SIGNAL pb								: std_logic_vector(3 downto 0); -- pb(3) is used as an active-high reset for all registers
	
	
	signal holdingReg_in1, holdingReg_in2: std_logic;
	
	signal sm_clock, blink_sig: std_logic;
	
	--NS traffic light
	signal green_1, red_1, yellow_1: std_logic;
	signal t1: std_logic_vector(6 downto 0);
	signal ns_signal: std_logic;
	
	
	--EW traffic light
	
	signal green_2, red_2, yellow_2: std_logic;
	signal t2: std_logic_vector(6 downto 0);
	signal ew_signal: std_logic;
	
	
	-- holding reg out
	signal hold_1: std_logic;
	signal hold_2: std_logic;
	
	-- reset signals for hold
	
	signal reset_1: std_logic;
	signal reset_2: std_logic;
	
	
BEGIN
----------------------------------------------------------------------------------------------------
INST1: pb_inverters		port map (pb_n, pb);
INST2: clock_generator 	port map (sim_mode, pb(3), clkin_50, sm_clock, blink_sig);
Inst3: synchronizer port map (clkin_50, pb(3), pb(1), holdingReg_in2); --ew
Inst4: synchronizer port map (clkin_50, pb(3), pb(0), holdingReg_in1); --ns
inst5: holding_register port map (clkin_50, pb(3), reset_2, holdingReg_in2, hold_2, leds(3));--ew
inst6: holding_register port map (clkin_50, pb(3), reset_1, holdingReg_in1, hold_1, leds(1));--ns


inst7: State_Machine_traffic port map (sm_clock, pb(3), hold_1, hold_2,blink_sig, red_1, green_1, yellow_1,red_2, green_2, yellow_2, leds(0), leds(2), reset_1, reset_2, leds(7 downto 4));

t1 <= yellow_1 &"00" & green_1 & "00" &red_1;
t2 <= yellow_2 &"00" & green_2 & "00" &red_2;



inst9: segment7_mux port map (clkin_50, t1, t2,seg7_data, seg7_char2, seg7_char1);





END SimpleCircuit;
