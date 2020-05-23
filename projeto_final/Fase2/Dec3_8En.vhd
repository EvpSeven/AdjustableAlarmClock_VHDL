library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Dec3_8En is

 port(enable : in std_logic;
 inputs : in std_logic_vector(2 downto 0);
 outputs : out std_logic_vector(5 downto 0));

 
end Dec3_8En;

architecture BehavEquations of Dec3_8En is

begin
 outputs(0) <= enable and (not inputs(2)) and ( not inputs(1) ) and ( not inputs(0) );
 outputs(1) <= enable and (not inputs(2)) and (not inputs(1)) and (inputs(0));
 outputs(2) <= enable and (not inputs(2)) and (inputs(1))   and (not inputs(0));
 outputs(3) <= enable and (inputs(2)) and (not inputs(1)) and (not inputs(0));
 outputs(4) <= enable and (inputs(2)) and (not inputs(1)) and (inputs(0));
end BehavEquations;