-------------------------------------------------------------------------------
-- Title      : Stepper Core
-- Project    : 
-------------------------------------------------------------------------------
-- File       : stepper_core.vhd
-- Author     :   <40015802@ME1C017-221771>
-- Company    : 
-- Created    : 2026-02-17
-- Last update: 2026-02-18
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

  --Interval signals
  signal w_trigger : std_logic;
  signal w_period_done : std_logic;

  --FSM
  type t_state is (IDLE, RUN, STOP_WAIT);
  signal r_state : t_state := IDLE;

  --Internal run disable
  signal r_run : std_logic := '0';
  
begin

  --Direction output
  o_DIR <= i_DIR;

  --FSM for proper enable/disable
  process(CLK)
  begin
    if rising_edge(CLK) then
      
      if i_RST = '1' then
        r_state <= IDLE;
        r_run <= '0';

      else
        case r_state is

          when IDLE =>
            r_run <= '0';
            if i_EN = '1' then
              r_state <= RUN;
            end if;

          when RUN =>
            r_run <= '1';
            if i_EN = '0' then
              r_state <= STOP_WAIT;     --If running then disabled..
            end if;

          when STOP_WAIT =>
            r_run <= '1';       --Continue running until safe boundary
            if w_period_done = '1' then         --If current step period completed, go back to IDLE
              r_state <= IDLE;
            end if;
        end case;
      end if;
    end if;
  end process;

  --Step interval generator
  interval_inst : entity work.step_interval_gen
    port map(
      CLK => CLK,
      i_RST => i_RST,
      i_STEP_PERIOD => w_period,
      o_TRIGGER => w_trigger,
      o_PERIOD_DONE => w_period_done
    );

  --Step pulse generator
  pulse_inst : entity work.step_pulse_gen
    port map(
      CLK => CLK,
      i_RST => i_RST,
      i_TRIGGER => w_trigger when r_run = '1' else '0',
      o_STEP => o_STEP
  );
end Behavioural;
