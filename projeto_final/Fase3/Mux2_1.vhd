library ieee;
use ieee.std_logic_1164.all;

entity Mux2_1 is
	port(dataIn0 : in std_logic;
		  dataIn1 : in std_logic;
		  sel : in std_logic;
		  dataOut : out std_logic
		  );
end Mux2_1;

architecture Behavioural of Mux2_1 is
begin
	
	process(dataIn0,dataIn1,sel)
	
begin
		if(sel = '0') then
			dataOut <= dataIn0;
		else
			dataOut <= dataIn1;
		end if;

	end process;
end Behavioural;