library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity DemoFinal is
		
		port(	CLOCK_50	: in  std_logic;
				LEDG     : out std_logic_vector(8 downto 0);
				LEDR     : out std_logic_vector(17 downto 0);
				SW       : in std_logic_vector(17 downto 0);
				KEY		: in  std_logic_vector(3 downto 0); 
				HEX0     : out std_logic_vector(6 downto 0);
				HEX1		: out std_logic_vector(6 downto 0);
				HEX2		: out std_logic_vector(6 downto 0);
				HEX3		: out std_logic_vector(6 downto 0);
				HEX4		: out std_logic_vector(6 downto 0)
			  );

end DemoFinal;

architecture shell of DemoFinal is

	signal s_clk,s_led:std_logic;

   --Terminal count flags of each counter
	signal s_sUnitsTerm, s_sTensTerm	: std_logic_vector(3 downto 0);
	signal s_mUnitsTerm, s_mTensTerm, s_day	: std_logic_vector(3 downto 0);
	
	signal s_key0,s_key1,s_key2,s_key3: std_logic;
	
	signal s_enable, s_reset, s_days, s_stop:std_logic;
	-------------------------------------------------------------------------------
	
	signal s_0,s_1,s_2,s_3,s_4,s_00,s_11,s_22,s_33,s_44:std_logic_vector(3 downto 0);
	
	-------------------------------------------------------------------------------
	signal s_sel,s_set,s_enableAlarm:std_logic;
	
   --signal RCO
	signal s_rco0: std_logic;
	signal s_rco1: std_logic;
	signal s_rco2: std_logic;
	signal s_rco3: std_logic;
	signal s_rco4: std_logic;
	
	--signal 
	signal s_s_rco0: std_logic;
	signal s_s_rco1: std_logic;
	signal s_s_rco2: std_logic;
	signal s_s_rco3: std_logic;
	
	---------------------------------------------------------------------------------

	signal s_min0,s_min1,s_hour0, s_hour1, s_day0:std_logic;
	
	signal s_mux0,s_mux1,s_mux2,s_mux3:std_logic;

begin
	clk : entity work.en_gen(beh)
			--generic map(k => 5E6)
			port map(clkIn	=> CLOCK_50,
						en		=> s_clk
						);
			
						
	--LED dos segundos
	clk_seconds : entity work.clk_pulse_seconds(RTL)
							port map(clkIn4Hz		=> CLOCK_50,
										mode			=> '1',
										clkEnable	=> s_led,
										tick1Hz		=> LEDG(8));
	
	
	count0: entity work.Counter4Bits(RTL)
						generic map(MAX =>"1010")
						port map(clk            =>	s_clk,
									reset     	   => s_reset,
									enUp      	   => s_min0 and (not KEY(0)),
									enDown         => s_min0 and (not KEY(1)),
									enClk          => '1',
									acerto	      => s_enable,
									stop           => s_min0,
									valOut		   => s_sUnitsTerm,
									RCO            => s_rco0
									);
									
	
	
	count1: entity work.Counter4Bits(RTL)
						generic map(MAX =>"0110")
						port map(clk            =>	s_clk,
									reset     	   => s_reset,
									enUp      	   => (not KEY(0)),
									enDown         => (not KEY(1)),
									enClk          => s_mux0,
									acerto	      => s_enable,
									stop           => s_min1,
									valOut		   => s_sTensTerm,
									RCO            => s_rco1
									);
	
	s_s_rco0 <= s_rco0 and s_rco1;	
	
	
	count2: entity work.Counter4Bits(RTL)
						generic map(MAX =>"1010")
						port map(clk            =>	s_clk,
									reset     	   => s_reset,
									enUp      	   => (not KEY(0)),
									enDown         => (not KEY(1)),
									enClk          => s_mux1,
									acerto	      => s_enable,
									stop           => s_hour0,
									valOut		   => s_mUnitsTerm,
									RCO            => s_rco2
									);
									
	s_s_rco1 <= s_rco0 and s_rco1 and s_rco2;								
	
	count3: entity work.Counter4Bits(RTL)
						generic map(MAX =>"0011")
						port map(clk            =>	s_clk,
									reset     	   => s_reset,
									enUp      	   => not KEY(0),
									enDown         => not KEY(1),
									enClk          => s_mux2,
									acerto	      => s_enable,
									stop           => s_hour1,
									valOut		   => s_mTensTerm,
									RCO            => s_rco3
									);					
									
									
	count4: entity work.Counter4Bits(RTL)
						generic map(MAX =>"0111")
						port map(clk            =>	s_clk,
									reset     	   => '0' or s_stop,
									enUp      	   => not KEY(0), 
									enDown         => not KEY(1),
									enClk          => s_mux3,
									acerto	      => s_enable,
									stop           => s_day0,
									valOut		   => s_day,
									RCO            => open
									);
	
	deb: entity work.DebounceUnit(Behavioral)
						port map(refClk => CLOCK_50,
									dirtyIn => KEY(2),
									pulsedOut => s_key2
									);
	deb1: entity work.DebounceUnit(Behavioral)
						port map(refClk => CLOCK_50,
									dirtyIn => KEY(3),
									pulsedOut => s_key3
									);
									
	
	ctr_machine : entity work.Ctr_Maquina(Behav)
						port map(clk =>CLOCK_50,
									k => s_key2,
									sw => SW(0),
									key_alarm => s_key3,
									s_led => LEDR(6),
									s_led0=> LEDR(7),
									s_led1=> LEDR(9),
									s_led2 => LEDR(10),
									s_led3 => LEDR(12),
									s_led4 => LEDG(6),
									set => s_set, --alarm
									sel => s_enable,
									min0 => s_min0,
									min1 => s_min1,
									hours0  => s_hour0,
									hours1 => s_hour1,
									day => s_day0
					);
	reg0 : entity work.Register4(behav) --reg do alarm
						port map(clk => s_clk,
									dataIn0 => s_sUnitsTerm,
									dataIn1 => s_sTensTerm,
									dataIn2 => s_mUnitsTerm,
									dataIn3 => s_mTensTerm, 
									dataIn4 => s_day, 
									wrEn => s_set,
									stop => s_stop,
									dataOut0 => s_0,
									dataOut1 => s_1,
									dataOut2 => s_2,
									dataOut3 => s_3,
									dataOut4 => s_4
									);
					
	--conflito com enClk e o ajuste
	Mux0 : entity work.Mux2_1(Behavioural)
						port map(dataIn0 => s_rco0,
									dataIn1 => '1',
									sel => SW(0),
									dataOut => s_mux0
									);
	Mux1 : entity work.Mux2_1(Behavioural)
						port map(dataIn0 => s_s_rco0,
									dataIn1 => '1',
									sel => SW(0),
									dataOut => s_mux1
									);
	Mux2 : entity work.Mux2_1(Behavioural)
						port map(dataIn0 => s_s_rco1,
									dataIn1 => '1',
									sel => SW(0),
									dataOut => s_mux2
									);
	
	Mux3 : entity work.Mux2_1(Behavioural)
						port map(dataIn0 => s_days,
									dataIn1 => '1',
									sel => SW(0),
									dataOut => s_mux3
									);	
									
									
	process(s_sUnitsTerm,s_sTensTerm,s_mUnitsTerm,s_mTensTerm) --para dar reset aos 23:59
	begin
		if(s_mTensTerm = "0010" and s_mUnitsTerm = "0011" and s_sTensTerm = "0101" and s_sUnitsTerm = "1001") then
			s_days <= '1';
		
			s_reset <= '1';
		else
			s_days <= '0';
			s_reset <= '0';
		end if;
	end process;
	
	s_00 <= s_0;
	s_11 <= s_1;
	s_22 <= s_2;
	s_33 <= s_3;
	s_44 <= s_4;
				
	process(s_sUnitsTerm,s_sTensTerm,s_mUnitsTerm,s_mTensTerm, s_day,s_00,s_11,s_22,s_33,s_44) --para o alarme
	begin
		
			if(s_sUnitsTerm = s_00 and s_sTensTerm = s_11 and s_mUnitsTerm = s_22 and s_mTensTerm = s_33) then
				s_enableAlarm <= '0';
--				s_sUnitsTerm <= s_sUnitsTerm;
--				s_sTensTerm <= s_sTensTerm;
--				s_mUnitsTerm <= s_mUnitsTerm;
--				s_mTensTerm <= s_mTensTerm;
			else
				s_enableAlarm <= '1';
			end if;
	
	end process;	
	
	--LED AUXILIAR PARA O ALARM
	LEDR(17) <= not s_enableAlarm;

	--Bloco do display de 7 Segmentos dos MINUTOS (HEX0)
	s_units_decod : entity work.Bin7SegDecoder(Behavioral)
							port map(enable	=> s_enableAlarm,
										binInput	=> s_sUnitsTerm,
										decOut_n	=> HEX0);


	--Bloco do display de 7 Segmentos dos MINUTOS (HEX1)
	s_tens_decod : entity work.Bin7SegDecoder(Behavioral)
							port map(enable	=> s_enableAlarm,
										binInput	=> s_sTensTerm,
										decOut_n	=> HEX1);
							
	--Bloco do display de 7 Segmentos dos HORAS (HEX2)	
	m_units_decod : entity work.Bin7SegDecoder(Behavioral)
							port map(enable	=> s_enableAlarm,
										binInput	=> s_mUnitsTerm,
										decOut_n	=> HEX2);
						
	--Bloco do display de 7 Segmentos dos HORAS (HEX3)
	m_tens_decod : entity work.Bin7SegDecoder(Behavioral)
							port map(enable	=> s_enableAlarm,
										binInput	=> s_mTensTerm,
										decOut_n	=> HEX3);
		--Bloco do display de 7 Segmentos dos DIA (HEX4)
	m_dia_decod : entity work.Bin7SegDecoder(Behavioral)
							port map(enable	=> s_enableAlarm,
										binInput	=> s_day,
										decOut_n	=> HEX4);


end shell;