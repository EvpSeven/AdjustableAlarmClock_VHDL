-- Copyright (C) 2017  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "05/23/2019 10:16:57"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          Counter4Bits
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY Counter4Bits_vhd_vec_tst IS
END Counter4Bits_vhd_vec_tst;
ARCHITECTURE Counter4Bits_arch OF Counter4Bits_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk : STD_LOGIC;
SIGNAL enClk : STD_LOGIC;
SIGNAL RCO : STD_LOGIC;
SIGNAL STOP : STD_LOGIC;
SIGNAL valOut : STD_LOGIC_VECTOR(3 DOWNTO 0);
COMPONENT Counter4Bits
	PORT (
	clk : IN STD_LOGIC;
	enClk : IN STD_LOGIC;
	RCO : OUT STD_LOGIC;
	STOP : IN STD_LOGIC;
	valOut : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : Counter4Bits
	PORT MAP (
-- list connections between master ports and signals
	clk => clk,
	enClk => enClk,
	RCO => RCO,
	STOP => STOP,
	valOut => valOut
	);

-- clk
t_prcs_clk: PROCESS
BEGIN
	FOR i IN 1 TO 33
	LOOP
		clk <= '0';
		WAIT FOR 15000 ps;
		clk <= '1';
		WAIT FOR 15000 ps;
	END LOOP;
	clk <= '0';
WAIT;
END PROCESS t_prcs_clk;

-- enClk
t_prcs_enClk: PROCESS
BEGIN
	enClk <= '1';
WAIT;
END PROCESS t_prcs_enClk;

-- STOP
t_prcs_STOP: PROCESS
BEGIN
	STOP <= '0';
WAIT;
END PROCESS t_prcs_STOP;
END Counter4Bits_arch;
