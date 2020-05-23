library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity Register4 is
	
 generic(N : positive:= 4);
 port(clk : in std_logic;
		dataIn0 : in std_logic_vector((N-1) downto 0);
		dataIn1 : in std_logic_vector((N-1) downto 0);
		dataIn2 : in std_logic_vector((N-1) downto 0);
		dataIn3 : in std_logic_vector((N-1) downto 0);
		dataIn4 : in std_logic_vector((N-1) downto 0);
		wrEn : in std_logic;
		stop : out std_logic;
		dataOut0: out std_logic_vector((N-1) downto 0);
		dataOut1: out std_logic_vector((N-1) downto 0);
		dataOut2: out std_logic_vector((N-1) downto 0);
		dataOut3: out std_logic_vector((N-1) downto 0);
		dataOut4: out std_logic_vector((N-1) downto 0)
		);
		
end Register4;

architecture behav of Register4 is

begin
	process(clk)
	begin
		if (rising_edge(clk)) then
		
				if (wrEn = '1') then
					stop <= '1';
					dataOut0 <= dataIn0;
					dataOut1 <= dataIn1;
					dataOut2 <= dataIn2;
					dataOut3 <= dataIn3;
					dataOut4 <= dataIn4;
				else
					stop <= '0';
				end if;
				
		end if;
	end process;
end behav;