library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity clk_pulse_seconds is
	port(clkIn4Hz	: in  std_logic;
		  tick1Hz	: out std_logic);
end clk_pulse_seconds;

architecture RTL of clk_pulse_seconds is

	signal s_counter : unsigned(1 downto 0);

begin
	process(clkIn4Hz)
	begin
		if (rising_edge(clkIn4Hz)) then
			s_counter <= s_counter + 1;
		end if;
	end process;

	tick1Hz	<= s_counter(1);
end RTL;