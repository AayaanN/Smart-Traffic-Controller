library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity State_Machine_traffic IS Port
(
 clk_input, reset, hold1, hold2,blink_sig			: IN std_logic;
 red1, green1, yellow1, red2, green2, yellow2, ns_display, ew_display, reset1, reset2: OUT std_logic;
 state_num: out std_logic_vector(3 downto 0)
 
 );
END ENTITY;
 

 Architecture SM of State_Machine_traffic is
 

 
 TYPE STATE_NAMES IS (s0, s1, S2, S3, S4, S5, S6, S7,s8,s9,s10,s11,s12,s13,s14,s15);   -- list all the STATE_NAMES values

 
 SIGNAL current_state, next_state	:  STATE_NAMES;     	-- signals of type STATE_NAMES
 BEGIN

  --------------------------------------------------------------------------------
 --State Machine:
 --------------------------------------------------------------------------------

 -- REGISTER_LOGIC PROCESS 
 
Register_Section: PROCESS (clk_input)  -- this process updates with a clock
BEGIN
	IF(rising_edge(clk_input)) THEN
		IF (reset = '1') THEN
			current_state <= S0;
		ELSIF (reset = '0') THEN
			current_state <= next_State;
		END IF;
	END IF;
END PROCESS;	



-- TRANSITION LOGIC PROCESS 

Transition_Section: PROCESS (current_state) 

BEGIN
  CASE current_state IS

	WHEN s0 =>
	if (hold2 ='1' and hold1 ='0') then
		next_state <= s6;
		
	else
		next_state <= s1;
		
	end if;
	
	WHEN s1 =>
	if (hold2 ='1' and hold1 ='0') then
		next_state <= s6;
		
	else
		next_state <= s2;
	end if;

	WHEN s2 =>
		next_state <= s3;
	WHEN s3 =>
		next_state <= s4;
	WHEN s4 =>
		next_state <= s5;
	WHEN s5 =>
		next_state <= s6;
	WHEN s6 =>
		next_state <= s7;
	WHEN s7 =>
		next_state <= s8;
	WHEN s8 =>
	
		if (hold1 = '1' and hold2 = '0') then 
			next_state <= s14;
		else
			next_state <= s9;
			
		end if;
	
	WHEN s9 =>
		if (hold1 = '1' and hold2 = '0') then 
			next_state <= s14;
		else
			next_state <= s10;
			
		end if;
		
	WHEN s10 =>
		next_state <= s11;
	WHEN s11 =>
		next_state <= s12;
	WHEN s12 =>
		next_state <= s13;
	WHEN s13 =>
		next_state <= s14;
	WHEN s14 =>
		next_state <= s15;
	WHEN s15 =>
		next_state <= s0;

	
  
  
	  END CASE;
 END PROCESS;
 

-- DECODER SECTION PROCESS (MOORE FORM SHOWN)

Decoder_Section: PROCESS (current_state,clk_input) 

BEGIN
     CASE current_state IS
	  
         WHEN S0 =>		
			red1 <='0';
			green1<=blink_sig;
			yellow1<='0';
			ns_display<='0';
			
			
			red2 <='1';
			green2<='0';
			yellow2<='0';
			ew_display<='0';
			
			reset1 <='0';
			reset2 <='0';
			
			state_num <= "0000";
			
         WHEN S1 =>		
			red1 <='0';
			green1<=blink_sig;
			yellow1<='0';
			ns_display<='0';
			
			red2 <='1';
			green2<='0';
			yellow2<='0';
			ew_display<='0';
			
			reset1 <='0';
			reset2 <='0';
			
			state_num <= "0001";

         WHEN S2 =>		

			red1 <='0';
			green1<='1';
			yellow1<='0';
			ns_display<='1';
			
			red2 <='1';
			green2<='0';
			yellow2<='0';
			ew_display<='0';
			
			reset1 <='0';
			reset2 <='0';
			
			state_num <= "0010";
			
         WHEN S3 =>		
	
			red1 <='0';
			green1<='1';
			yellow1<='0';
			ns_display<='1';
			
	
			red2 <='1';
			green2<='0';
			yellow2<='0';
			ew_display<='0';
			
			reset1 <='0';
			reset2 <='0';
			
			state_num <= "0011";

         WHEN S4 =>		
	
			red1 <='0';
			green1<='1';
			yellow1<='0';
			ns_display<='1';
			

			red2 <='1';
			green2<='0';
			yellow2<='0';
			ew_display<='0';
			
			reset1 <='0';
			reset2 <='0';
			
			state_num <= "0100";

         WHEN S5 =>		

			red1 <='0';
			green1<='1';
			yellow1<='0';
			ns_display<='1';
			

			red2 <='1';
			green2<='0';
			yellow2<='0';
			ew_display<='0';
			
			reset1 <='0';
			reset2 <='0';
			
			state_num <= "0101";
				
         WHEN S6 =>		

			red1 <='0';
			green1<='0';
			yellow1<='1';
			ns_display<='0';
			

			red2 <='1';
			green2<='0';
			yellow2<='0';
			ew_display<='0';
			
			reset1 <='0';
			reset2 <='1';
			
			state_num <= "0110";
			
			
         WHEN S7 =>		
			red1 <='0';
			green1<='0';
			yellow1<='1';
			ns_display<='0';
			
			red2 <='1';
			green2<='0';
			yellow2<='0';
			ew_display<='0';
			
			reset1 <='0';
			reset2 <='0';
			
			state_num <= "0111";
			
			WHEN S8 =>		
			red1 <='1';
			green1<='0';
			yellow1<='0';
			ns_display<='0';
			

			red2 <='0';
			green2<=blink_sig;
			yellow2<='0';
			ew_display<='0';
			
			reset1 <='0';
			reset2 <='0';
			
			state_num <= "1000";
			
			WHEN S9 =>		

			red1 <='1';
			green1<='0';
			yellow1<='0';
			ns_display<='0';
			
			red2 <='0';
			green2<=blink_sig;
			yellow2<='0';
			ew_display<='0';
			
			reset1 <='0';
			reset2 <='0';
			
			state_num <= "1001";
			
			WHEN S10 =>		

			red1 <='1';
			green1<='0';
			yellow1<='0';
			ns_display<='0';
			

			red2 <='0';
			green2<='1';
			yellow2<='0';
			ew_display<='1';
			
			reset1 <='0';
			reset2 <='0';
			
			state_num <= "1010";
			
			WHEN S11 =>		

			red1 <='1';
			green1<='0';
			yellow1<='0';
			ns_display<='0';
			

			red2 <='0';
			green2<='1';
			yellow2<='0';
			ew_display<='1';
			
			reset1 <='0';
			reset2 <='0';
			
			state_num <= "1011";
			
			WHEN S12 =>		

			red1 <='1';
			green1<='0';
			yellow1<='0';
			ns_display<='0';
			

			red2 <='0';
			green2<='1';
			yellow2<='0';
			ew_display<='1';
			
			reset1 <='0';
			reset2 <='0';
			
			state_num <= "1100";
			
			WHEN S13 =>		

			red1 <='1';
			green1<='0';
			yellow1<='0';
			ns_display<='0';
			

			red2 <='0';
			green2<='1';
			yellow2<='0';
			ew_display<='1';
			
			reset1 <='0';
			reset2 <='0';
			
			state_num <= "1101";
			
			WHEN S14 =>		

			red1 <='1';
			green1<='0';
			yellow1<='0';
			ns_display<='0';
			

			red2 <='0';
			green2<='0';
			yellow2<='1';
			ew_display<='0';
			
			reset1 <='1';
			reset2 <='0';
			
			state_num <= "1110";
			
			WHEN S15 =>		

			red1 <='1';
			green1<='0';
			yellow1<='0';
			ns_display<='0';
			

			red2 <='0';
			green2<='0';
			yellow2<='1';
			ew_display<='0';
			
			reset1 <='0';
			reset2 <='0';
			
			state_num <= "1111";
			
	  END CASE;
 END PROCESS;

 END ARCHITECTURE SM;
