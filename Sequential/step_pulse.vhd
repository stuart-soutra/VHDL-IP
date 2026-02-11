-------------------------------------------------------------------------------
-- Title      : Step Pulse
-- Project    : 
-------------------------------------------------------------------------------
-- File       : step_pulse.vhd
-- Author     :   <40015802@ME1C017-221771>
-- Company    : 
-- Created    : 2026-02-11
-- Last update: 2026-02-11
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Simple state machine that outputs pulse width of defined width
-------------------------------------------------------------------------------
-- Copyright (c) 2026 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2026-02-11  1.0      40015802	Created
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;


-------------------------------------------------------------------------------
entity step_pulse is
  Port(
    CLK:        in      std_logic;      --100 MHz
    TRIGGER:    in      std_logic;      --Activate pulse
    STEP_OUT:   out     std_logic;      --STEP signal output
    busy:       out     std_logic       --Pulse is active flag
    );
  end step_pulse;


-------------------------------------------------------------------------------

