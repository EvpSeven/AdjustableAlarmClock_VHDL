library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity DemoFinal is
		
		port(	CLOCK_50	: in  std_logic;	
				KEY		: in  std_logic_vector(3 downto 0); 
				LEDG     : out std_logic_vector(8 downto 0);
				HEX0     : out std_logic_vector(6 downto 0);
				HEX1		: out std_logic_vector(6 downto 0);
				HEX2		: out std_logic_vector(6 downto 0);
				HEX3		: out std_logic_vector(6 downto 0);
				HEX4		: out std_logic_vector(6 downto 0)
			  );

end DemoFinal;

architecture shell of DemoFinal is

signal s_clk:std_logic;

--Terminal count flags of each counter
	signal s_sUnitsTerm, s_sTensTerm	: std_logic_vector(3 downto 0);
	signal s_mUnitsTerm, s_mTensTerm, s_day	: std_logic_vector(3 downto 0);



begin
	clk : entity work.en_gen(beh)
			--generic map(k => 5E6)
			port map(clkIn	=> CLOCK_50,
						en		=> s_clk
						);
						
	pulse_sec: entity work.clk_pulse_seconds(RTL)
		port map(clkIn4Hz	=> s_clk,
					tick1Hz => LEDG(8)
					);

	
	count: entity work.Demo(shell)
			port map(clk50 => s_clk,
						stop => '0',
						valOut0 => s_sUnitsTerm,
						valOut1 =>s_sTensTerm,
						valOut2 =>s_mUnitsTerm,
						valOut3 =>s_mTensTerm,
						valOut4 =>s_day
						);
						
	--Bloco do display de 7 Segmentos dos segundos (HEX0)
	s_units_decod : entity work.Bin7SegDecoder(Behavioral)
							port map(enable	=> '1',
										binInput	=> s_sUnitsTerm,
										decOut_n	=> HEX0);


	--Bloco do display de 7 Segmentos dos segundos (HEX1)
	s_tens_decod : entity work.Bin7SegDecoder(Behavioral)
							port map(enable	=> '1',
										binInput	=> s_sTensTerm,
										decOut_n	=> HEX1);
							
	--Bloco do display de 7 Segmentos dos minutos (HEX2)	
	m_units_decod : entity work.Bin7SegDecoder(Behavioral)
							port map(enable	=> '1',
										binInput	=> s_mUnitsTerm,
										decOut_n	=> HEX2);
						
	--Bloco do display de 7 Segmentos dos minutos (HEX3)
	m_tens_decod : entity work.Bin7SegDecoder(Behavioral)
							port map(enable	=> '1',
										binInput	=> s_mTensTerm,
										decOut_n	=> HEX3);
		--Bloco do display de 7 Segmentos dos minutos (HEX4)
	m_dia_decod : entity work.Bin7SegDecoder(Behavioral)
							port map(enable	=> '1',
										binInput	=> s_day,
										decOut_n	=> HEX4);

	
	
end shell;