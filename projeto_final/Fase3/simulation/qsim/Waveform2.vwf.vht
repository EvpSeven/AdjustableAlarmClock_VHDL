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
-- Generated on "05/16/2019 18:05:12"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          Demo
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY Demo_vhd_vec_tst IS
END Demo_vhd_vec_tst;
ARCHITECTURE Demo_arch OF Demo_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk50 : STD_LOGIC;
SIGNAL stop : STD_LOGIC;
SIGNAL valOut0 : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL valOut1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL valOut2 : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL valOut3 : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL valOut4 : STD_LOGIC_VECTOR(3 DOWNTO 0);
COMPONENT Demo
	PORT (
	clk50 : IN STD_LOGIC;
	stop : IN STD_LOGIC;
	valOut0 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	valOut1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	valOut2 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	valOut3 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	valOut4 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : Demo
	PORT MAP (
-- list connections between master ports and signals
	clk50 => clk50,
	stop => stop,
	valOut0 => valOut0,
	valOut1 => valOut1,
	valOut2 => valOut2,
	valOut3 => valOut3,
	valOut4 => valOut4
	);

-- clk50
t_prcs_clk50: PROCESS
BEGIN
	clk50 <= '0';
	WAIT FOR 11000 ps;
	clk50 <= '1';
	WAIT FOR 1000 ps;
	FOR i IN 1 TO 494
	LOOP
		clk50 <= '0';
		WAIT FOR 1000 ps;
		clk50 <= '1';
		WAIT FOR 1000 ps;
	END LOOP;
WAIT;
END PROCESS t_prcs_clk50;

-- stop
t_prcs_stop: PROCESS
BEGIN
	stop <= '0';
	WAIT FOR 240000 ps;
	stop <= '1';
	WAIT FOR 150000 ps;
	stop <= '0';
WAIT;
END PROCESS t_prcs_stop;
END Demo_arch;
