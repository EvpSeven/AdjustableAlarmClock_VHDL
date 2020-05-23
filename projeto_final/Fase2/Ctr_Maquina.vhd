--Timer Ajust-> Maquina de Estados
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Ctr_Maquina is
	
	port(clk, k: in std_logic;
		  sw: in std_logic;
		  min0 : out std_logic;
		  min1 : out std_logic;
		  hours0 : out std_logic;
		  hours1 : out std_logic;
		  day : out std_logic;
		  s_led: out std_logic;
		  s_led0: out std_logic;
		  s_led1: out std_logic;
		  s_led2: out std_logic;
		  s_led3: out std_logic;
		  sel: out std_logic
		  );

end Ctr_Maquina;

architecture Behav of Ctr_Maquina is

type state is (running,smin0,smin1,shours0,shours1, sdays);
	signal PS,NS :state;
begin
	sync_proc: process(clk)
	begin
		if(rising_edge(clk)) then
			
			PS <= NS;
		end if;
	
	end process;
	
	comb_proc: process(k, sw, PS)
	begin
		
		min0 <= '0';
		min1 <= '0';
		hours0 <= '0';
		hours1 <= '0';
		day <= '0';
		s_led <= '0';
		s_led0<= '0';
		s_led1<= '0';
		s_led2<= '0';
		s_led3<= '0';
		sel <= '0';
		
		case PS is
			when running =>
				sel <= '0';
				if(sw = '1') then
					NS <= smin0;
				else
					NS <= running;
				end if;
				
			when smin0 =>
				sel <= '1';
				s_led <= '1';
				min0 <= '1';
				min1 <= '0';
				hours0 <= '0';
				hours1 <= '0';
				day <= '0';			
			
				
				if(k = '1') then
					NS <= smin1;
				elsif(sw = '0') then
					NS <= running;
				else
					NS <= smin0;
				end if;
			
			when smin1 =>
				min1 <= '1';
				sel <= '1';
				s_led0 <= '1';
				min1 <= '1';

				if(k = '1') then
					NS <= shours0;
				elsif(sw = '0') then
					NS <= running;
				else
					NS <= smin1;
				end if;
				
			when shours0 =>
			
				hours0 <= '1';
				sel   <= '1';
				s_led1<= '1';
				
				if(k = '1') then
					hours1 <= '1';
					NS <= shours1;
				elsif(sw = '0') then
					NS <= running;
				else
					NS <= shours0;
				end if;
				
			when shours1 =>
				sel <= '1';
				s_led2<= '1';
				hours1 <= '1';
				if(k = '1') then
					NS <= sdays;
				elsif(sw = '0') then
					NS <= running;
				else
					NS <= shours1;
				end if;
				
				
			when sdays =>
				sel <= '1';
				s_led3<= '1';
				day <= '1';
				if(k = '1') then
					NS <= smin0;
				elsif(sw = '0') then
					NS <= running;
				else
					NS <= sdays;
				end if;
			when others =>
				NS <= running;
				
		end case;
	
	end process;
	

end Behav;