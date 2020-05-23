library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Demo is
	port(clk50: in std_logic;
		  stop: in std_logic;
		  valOut0: out std_logic_vector(3 downto 0);
		  valOut1: out std_logic_vector(3 downto 0);
		  valOut2: out std_logic_vector(3 downto 0);
		  valOut3: out std_logic_vector(3 downto 0);
		  valOut4: out std_logic_vector(3 downto 0));
end Demo;

architecture shell of Demo is

	--signal RCO
	signal s_rco0: std_logic;
	signal s_rco1: std_logic;
	signal s_rco2: std_logic;
	signal s_rco3: std_logic;
	signal s_rco4: std_logic;
	signal s_sec0:std_logic;
	signal s_sec1:std_logic;
	
	--signal 
	signal s_s_rco0: std_logic;
	signal s_s_rco1: std_logic;
	signal s_s_rco2: std_logic;
	signal s_s_rco3: std_logic;
	signal s_s_sec1: std_logic;
	signal s_s_sec2: std_logic;

	--signal VALOUT
	signal s_valOut0: std_logic_vector(3 downto 0);
	signal s_valOut1: std_logic_vector(3 downto 0);
	signal s_valOut2: std_logic_vector(3 downto 0);
	signal s_valOut3: std_logic_vector(3 downto 0);
	signal s_valOut4: std_logic_vector(3 downto 0);
	
	--signal stop
	signal s_stop:std_logic;
	signal s_days:std_logic;
	
	--signal para dar reset a 23:59
	signal s_reset:std_logic;
	


begin

	valOut0 <= s_valOut0;
	valOut1 <= s_valOut1;
	valOut2 <= s_valOut2;
	valOut3 <= s_valOut3;
	valOut4 <= s_valOut4;
	
	s_stop <= stop; 
	process(s_valOut0,s_valOut1,s_valOut2,s_valOut3) --para dar reset aos 23:59
	begin
		if(s_valOut3 = "0010" and s_valOut2 = "0011" and s_valOut1 = "0101" and s_valOut0 = "1001") then
			s_days <= '1';
			s_reset <= '1';
		else
			s_days <= '0';
			s_reset <= '0';
		end if;
	end process;
	ds0: entity work.Counter4Bits(RTL)
				generic map(MAX =>"0111")
				port map(clk	=> clk50,		
							STOP	=> s_stop,
							enClk => '1',
							reset => s_reset,
							valOut	=>	open,
							RCO => s_sec0);
							
	ds1: entity work.Counter4Bits(RTL)
				generic map(MAX =>"1010")
				port map(clk	=> clk50,		
							STOP	=> s_stop,
							enClk => s_sec0,
							reset => s_reset,
							valOut	=>	open,
							RCO => s_sec1);
	s_s_sec1 <= s_sec1 and s_sec0;
	d0 : entity work.Counter4Bits(RTL)
				generic map(MAX =>"1010")
				port map(clk	=> clk50,		
							STOP	=> s_stop,
							enClk => s_s_sec1,
							reset => s_reset,
							valOut	=>	s_valOut0,
							RCO => s_rco0);
							
	s_s_sec2 <= s_sec1 and s_sec0 and s_rco0;
	d1 : entity work.Counter4Bits(RTL)
				generic map(MAX =>"0110")
				port map(clk	=> clk50,		
							STOP	=> s_stop,
							enClk => s_s_sec2,
							reset => s_reset,
							valOut	=>	s_valOut1,
							RCO => s_rco1);	
							
	s_s_rco0 <= s_rco0 and s_rco1 and s_sec0 and s_sec1;
							
	d2 : entity work.Counter4Bits(RTL)
				generic map(MAX =>"1010")
				port map(clk	=> clk50,		
							STOP	=> s_stop,
							enClk => s_s_rco0,
							reset => s_reset,
							valOut	=>	s_valOut2,
							RCO => s_rco2);	
							
	s_s_rco1 <= s_rco0 and s_rco1 and s_rco2 and s_sec0 and s_sec1;
							
	d3 : entity work.Counter4Bits(RTL)
				generic map(MAX =>"0011")
				port map(clk	=> clk50,		
							STOP	=> s_stop,
							enClk => s_s_rco1,
							reset => s_reset,
							valOut	=>	s_valOut3,
							RCO => s_rco3);		
	s_s_rco2 <= s_rco0 and s_rco1 and s_rco2 and s_rco3 and s_sec0 and s_sec1;
							
	d4 : entity work.Counter4Bits(RTL)
				generic map(MAX =>"1000")
				port map(clk	=> clk50,		
							STOP	=> s_stop,
							enClk => s_days,
							reset => '0',
							valOut	=>	s_valOut4,
							RCO => open);	
							
	


end shell;