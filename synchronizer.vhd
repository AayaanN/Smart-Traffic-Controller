library ieee;
use ieee.std_logic_1164.all;


entity synchronizer is port (

			clk					: in std_logic;
			reset					: in std_logic;
			din					: in std_logic;
			dout					: out std_logic
  );
 end synchronizer;
 
 
architecture circuit of synchronizer is

	Signal sreg				: std_logic_vector(1 downto 0);
	Signal D1_out: std_logic;
	Signal D2_enable: std_logic;
	

BEGIN
process (clk) is
begin
	
	if (reset = '1') then
		sreg <= "00";
		
	
	elsif (rising_edge(clk)) then
		
		
		if (din = '1') then 
			sreg (1 downto 0) <= '1' & sreg(1);
		else
		
			sreg(1 downto 0) <= '0' & sreg(1);
			
		end if;
			
	end if;
	
	dout <= sreg(0);
		
	
			

end process;
end architecture circuit;