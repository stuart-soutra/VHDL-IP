-------------------------------------------------------------------------------
-- Title      : Step Interval Generator
-- Project    : 
-------------------------------------------------------------------------------
-- File       : step_interval_generator.vhd
-- Author     :   <40015802@ME1C017-221771>
-- Company    : 
-- Created    : 2026-02-13
-- Last update: 2026-02-16
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Generates timed TRIGGER pulses for step pulse generator
-------------------------------------------------------------------------------
-- Copyright (c) 2026 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2026-02-13  1.0      40015802	Created
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


-------------------------------------------------------------------------------
entity step_interval_gen is
  Port(
    CLK:                in      std_logic;
    i_RST:              in      std_logic;
    i_STEP_PERIOD:      in      integer;
    o_TRIGGER:          out     std_logic
  );
end step_interval_gen;


-------------------------------------------------------------------------------
architecture Behavioural of step_interval_gen is

  signal r_step_period : integer := 10000;    --100us @ 100MHz
  signal r_counter : integer := 0;

  begin
    process(CLK)
      begin
        if rising_edge(CLK) then
          if i_RST = '1' then
            r_counter <= 0;
            o_TRIGGER <= '0';
          else
            if r_counter >= i_STEP_PERIOD - 1 then
              r_counter <=0;
              o_TRIGGER <= '1';  --one single clk pulse
            else
              r_counter <= r_counter + 1;
              o_TRIGGER <= '0';
            end if;
          end if;
        end if;
      end process;
end Behavioural;
          
