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
    CLK:          in      std_logic;      --100 MHz
    i_TRIGGER:    in      std_logic;      --Activate pulse
    o_STEP_OUT:   out     std_logic;      --STEP signal output
    o_BUSY:       out     std_logic       --Pulse is active flag
    );
  end step_pulse;


-------------------------------------------------------------------------------
architecture rtl of step_pulse is

  type state_type is (IDLE, PULSE_HIGH);
  signal state : state_type := IDLE;
  signal pulse_cnt : unsigned(7 downto 0) := (others => '0');
  constant PULSE_WIDTH : unsigned(7 downto 0) :=
    to_unsigned(100, 8);        --1 us @ 100MHz
  signal step_reg : std_logic := '0';

  begin
    process(CLK)
      begin
        if rising_edge(CLK) then
          case state is
            
            when IDLE =>
              step_reg <= '0';
              pulse_cnt <= (others => '0');

              if i_TRIGGER = '1' then
                state <= PULSE_HIGH;
              end if;
              
            when PULSE_HIGH =>
              step_reg <= '1';
              pulse_cnt <= pulse_cnt + 1;

              if pulse_cnt = PULSE_WIDTH then
                state <= IDLE;
                step_reg <= '0';
              end if;
              
          end case;

        end if;

      end process;

      o_STEP_OUT <= step_reg;
      o_BUSY <= '1' when state /= IDLE else '0';

end rtl;
