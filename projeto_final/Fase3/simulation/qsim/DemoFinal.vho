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

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 17.1.0 Build 590 10/25/2017 SJ Lite Edition"

-- DATE "05/23/2019 10:16:58"

-- 
-- Device: Altera EP4CE115F29C7 Package FBGA780
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	Counter4Bits IS
    PORT (
	clk : IN std_logic;
	enClk : IN std_logic;
	STOP : IN std_logic;
	valOut : OUT std_logic_vector(3 DOWNTO 0);
	RCO : OUT std_logic
	);
END Counter4Bits;

ARCHITECTURE structure OF Counter4Bits IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_enClk : std_logic;
SIGNAL ww_STOP : std_logic;
SIGNAL ww_valOut : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_RCO : std_logic;
SIGNAL \valOut[0]~output_o\ : std_logic;
SIGNAL \valOut[1]~output_o\ : std_logic;
SIGNAL \valOut[2]~output_o\ : std_logic;
SIGNAL \valOut[3]~output_o\ : std_logic;
SIGNAL \RCO~output_o\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \s_count~3_combout\ : std_logic;
SIGNAL \enClk~input_o\ : std_logic;
SIGNAL \STOP~input_o\ : std_logic;
SIGNAL \s_count[0]~1_combout\ : std_logic;
SIGNAL \s_count~2_combout\ : std_logic;
SIGNAL \s_count~0_combout\ : std_logic;
SIGNAL \Equal0~0_combout\ : std_logic;
SIGNAL s_count : std_logic_vector(3 DOWNTO 0);

BEGIN

ww_clk <= clk;
ww_enClk <= enClk;
ww_STOP <= STOP;
valOut <= ww_valOut;
RCO <= ww_RCO;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\valOut[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => s_count(0),
	devoe => ww_devoe,
	o => \valOut[0]~output_o\);

\valOut[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => s_count(1),
	devoe => ww_devoe,
	o => \valOut[1]~output_o\);

\valOut[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => s_count(2),
	devoe => ww_devoe,
	o => \valOut[2]~output_o\);

\valOut[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \valOut[3]~output_o\);

\RCO~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Equal0~0_combout\,
	devoe => ww_devoe,
	o => \RCO~output_o\);

\clk~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

\s_count~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \s_count~3_combout\ = (s_count(0) & (s_count(1) & !s_count(2))) # (!s_count(0) & (!s_count(1) & s_count(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => s_count(0),
	datac => s_count(1),
	datad => s_count(2),
	combout => \s_count~3_combout\);

\enClk~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_enClk,
	o => \enClk~input_o\);

\STOP~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_STOP,
	o => \STOP~input_o\);

\s_count[0]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \s_count[0]~1_combout\ = (\enClk~input_o\ & !\STOP~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \enClk~input_o\,
	datad => \STOP~input_o\,
	combout => \s_count[0]~1_combout\);

\s_count[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \s_count~3_combout\,
	ena => \s_count[0]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => s_count(2));

\s_count~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \s_count~2_combout\ = (!s_count(2) & (s_count(0) $ (s_count(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => s_count(0),
	datac => s_count(1),
	datad => s_count(2),
	combout => \s_count~2_combout\);

\s_count[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \s_count~2_combout\,
	ena => \s_count[0]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => s_count(1));

\s_count~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \s_count~0_combout\ = (!s_count(0) & ((!s_count(2)) # (!s_count(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001010100010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => s_count(0),
	datab => s_count(1),
	datac => s_count(2),
	combout => \s_count~0_combout\);

\s_count[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \s_count~0_combout\,
	ena => \s_count[0]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => s_count(0));

\Equal0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal0~0_combout\ = (s_count(0) & (s_count(2) & !s_count(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => s_count(0),
	datab => s_count(2),
	datad => s_count(1),
	combout => \Equal0~0_combout\);

ww_valOut(0) <= \valOut[0]~output_o\;

ww_valOut(1) <= \valOut[1]~output_o\;

ww_valOut(2) <= \valOut[2]~output_o\;

ww_valOut(3) <= \valOut[3]~output_o\;

ww_RCO <= \RCO~output_o\;
END structure;


