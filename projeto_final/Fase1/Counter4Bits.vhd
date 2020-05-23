--Módulo do Contador de 4 bits

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Counter4Bits is
	generic(MAX		: unsigned(3 downto 0) := "0110");
	port(clk			: in  std_logic;
		  reset     : in std_logic;
		  enClk     : in std_logic;
		  STOP	   : in  std_logic;
		  valOut		: out std_logic_vector(3 downto 0); --valor de saida
		  RCO	      : out std_logic --ativa o RCO no fim da contagem
		  );
end Counter4Bits;

architecture RTL of Counter4Bits is

	signal s_count : unsigned(3 downto 0);
	signal s_rco: std_logic;
	
	
begin
	process(clk)
	begin	
		if (rising_edge(clk)) then
			if(reset = '1') then
				s_count <= "0000";
			else
				if (STOP = '0') then
					if(enClk =  '1') then
						if(s_count < (MAX-1)) then
							s_count <= s_count +1;
						else
							s_count <= "0000";
						end if;
					end if;
				end if;
			end if;
		end if;	
	end process;
	RCO <= '1' when s_count = (MAX-1) else '0';
	valOut <= std_logic_vector(s_count);
end RTL;