--clock de 50MHz

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity en_gen is
	--generic (k :positive := 10);
	port(clkIn	: in  std_logic;
		  en	: out std_logic
	);

end en_gen;

architecture beh of en_gen is
	signal s_counter: natural :=0;
begin
	process(clkIn)
	begin
		if(rising_edge(clkIn)) then
			if(s_counter = 499999) then
				s_counter <= 0;
				en <= '1';
		else
				en<='0';
				s_counter <= s_counter + 1;
		end if;
		
		end if;
	end process;
end beh;