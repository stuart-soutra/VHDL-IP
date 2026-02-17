-------------------------------------------------------------------------------
-- Title      : Stepper Core
-- Project    : 
-------------------------------------------------------------------------------
-- File       : stepper_core.vhd
-- Author     :   <40015802@ME1C017-221771>
-- Company    : 
-- Created    : 2026-02-17
-- Last update: 2026-02-17
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Logical core for stepper motor driver IP block
-------------------------------------------------------------------------------
-- Copyright (c) 2026 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2026-02-17  1.0      40015802	Created
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;


-------------------------------------------------------------------------------
entity stepper_core is
  generic(
    g_default_period : integer := 10000 --default 10kHz @ 100 MHz
  );

  port(
    CLK:                in      std_logic;
    i_RST:              in      std_logic;
    i_EN:               in      std_logic;
    i_DIR:              in      std_logic;
    i_STEP_PERIOD:      in      integer;
    o_STEP:             out     std_logic;
    o_DIR:              out     std_logic
  );
end stepper_core;


-------------------------------------------------------------------------------
architecture Behavioural of stepper_core is

  signal w_trigger : std_logic;
  signal w_period : integer;

begin

  --Period selection
  w_period <= i_STEP_PERIOD when i_EN = '1'
              else g_default_period;

  --Direction output
  o_DIR <= i_DIR;

  --Step interval generator
  interval_inst : entity work.step_interval_gen
    port map(
      CLK => CLK,
      i_RST => i_RST,
      i_STEP_PERIOD => w_period,
      o_TRIGGER => w_trigger
    );

  --Step pulse generator
  pulse_inst : entity work.step_pulse_gen
    port map(
      CLK => CLK,
      i_RST => i_RST,
      i_TRIGGER => w_trigger,
      o_STEP => o_STEP
  );
end Behavioural;
