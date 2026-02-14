-------------------------------------------------------------------------------
-- Title      : Step Pulse Generator
-- Project    : 
-------------------------------------------------------------------------------
-- File       : step_pulse_generator.vhd
-- Author     :   <AMD_2700X@DESKTOP-J833AIB>
-- Company    : Soutra Electronics
-- Created    : 2026-02-14
-- Last update: 2026-02-14
-- Platform   : 
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description: Generates step pulse of specific width given a TRIGGER input
-------------------------------------------------------------------------------
-- Copyright (c) 2026 Soutra Electronics
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2026-02-14  1.0      AMD_2700X	Created
-------------------------------------------------------------------------------
entity step_pulse_gen is
  port(
    CLK:        in      std_logic;
    i_RST:      in      std_logic;
    i_TRIGGER:  in      std_logic;
    o_STEP:     in      std_logic
  );
end step_pulse_gen;


-------------------------------------------------------------------------------
architecture Behavioral of step_pulse_gen is

  constant c_pulse_width : integer := 200;      --2us
  signal r_counter : integer range 0 to c_pulse_width := 0;
  signal r_active : std_logic := '0';

  begin
    process(CLK)
      begin
        if rising_edge(CLK) then
          if i_RST = '1' then
            r_counter <= 0;
            r_active <= '0';
            o_STEP <= '0';
          else
            if r_active = '0' then
              if i_TRIGGER = '1' then
                r_active <= '1';
                r_counter <= 0;
                o_STEP <= '1';
              end if;
            else
              if r_counter = c_pulse_width - 1 then
                r_active <= '0';
                o_STEP <= '0';
              else
                r_counter <= r_counter + 1;
              end if;
            end if;
          end if;
        end if;
      end process;
end Behavioral;      
