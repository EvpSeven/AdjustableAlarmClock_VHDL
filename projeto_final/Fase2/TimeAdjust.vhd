--Timer Ajust-> Maquina de Estados
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity TimeAdjust is 
	port( clk, timeup, timedown : in std_logic;
			mods: in std_logic_vector(1 downto 0);
			valOut0: out std_logic_vector(3 downto 0);
			valOut1: out std_logic_vector(3 downto 0);
			valOut2: out std_logic_vector(3 downto 0);
			valOut3: out std_logic_vector(3 downto 0);
			valOut4: out std_logic_vector(3 downto 0)
			);
end TimeAdjust;

architecture shell of TimeAdjust is
	signal s_valOut0,s_valOut1,s_valOut2,s_valOut3,s_valOut4:unsigned(3 downto 0);

begin

process(clk)
begin
	if(rising_edge(clk)) then
		if(mods = "01") then --MINUTOS
		
			if(timeup = '0') then
				s_valOut0 <= s_valOut0 + 1;
					if(s_valOut0 = "1001") then
						s_valOut0 <= "0000";
						s_valOut1<= s_valOut1 + 1;
						if( s_valOut1 = "0101") then
							s_valOut1 <= "0000";
						end if;
					end if;
			elsif(timedown = '0') then
				s_valOut0 <= s_valOut0 - 1;
					if(s_valOut0 = "0000") then
						s_valOut1 <= s_valOut1 -1;
						s_valOut0 <= "1001";
						if( s_valOut1 = "0000") then
							s_valOut1<= "0101";
						end if;
					end if;
			else
				s_valOut0 <= s_valOut0;
				s_valOut1 <= s_valOut1;
			end if;
-----------------------------------------------			
		elsif(mods = "10") then --horas
				
			if(timeup = '0') then
				s_valOut2 <= s_valOut2 + 1;
					if(s_valOut2 = "1001") then
						s_valOut2 <= "0000";
						s_valOut3 <= s_valOut3 + 1;
						if(s_valOut3 = "0010") then
							s_valOut3 <= "0000";
						end if;
							
						if(s_valOut3 = "0010" and s_valOut2 = "0011") then
								s_valOut2 <= "0000";
								s_valOut3 <= "0000";
						end if;
						
					end if;
			elsif(timedown = '0') then
				s_valOut2 <= s_valOut2 - 1;
					if(s_valOut2 = "0000") then
						s_valOut3 <= s_valOut3 -1;
						s_valOut2 <= "1001";
						if( s_valOut3 = "0000") then
							s_valOut3<= "0010";
							s_valOut1<= "0011";
						end if;
					end if;
			else
				s_valOut3 <= s_valOut3;
				s_valOut2 <= s_valOut2;
			end if;
-----------------------------------------------	

		elsif(mods = "11") then --dias
		
			if(timeup = '0') then
				s_valOut4 <= s_valOut4 + 1;
					if(s_valOut4 = "0110") then
						s_valOut4 <= "0000";
						
					end if;
			elsif(timedown = '0') then
				s_valOut4 <= s_valOut4 - 1;
					if(s_valOut4 = "0000") then
						s_valOut4 <= "0110";
					end if;
			else
				s_valOut4 <= s_valOut4;		
			end if;
		end if;
	end if;
	
	

	
end process;

valOut0 <= std_logic_vector(s_valOut0(3 downto 0));
valOut1 <= std_logic_vector(s_valOut1(3 downto 0));
valOut2 <= std_logic_vector(s_valOut2(3 downto 0));
valOut3 <= std_logic_vector(s_valOut3(3 downto 0));
valOut4 <= std_logic_vector(s_valOut4(3 downto 0));

end shell;