-------------------------------------------------------------------------------
-- Title      : Step Top Level
-- Project    : 
-------------------------------------------------------------------------------
-- File       : step_TOP.vhd
-- Author     :   <AMD_2700X@DESKTOP-J833AIB>
-- Company    : Soutra Electronics
-- Created    : 2026-02-14
-- Last update: 2026-02-14
-- Platform   : 
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description: TL integration of step interval and step pulse generators
-------------------------------------------------------------------------------
-- Copyright (c) 2026 Soutra Electronics
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2026-02-14  1.0      AMD_2700X	Created
-------------------------------------------------------------------------------
entity step_tl is
  port(
    CLK_100MHZ:         in      std_logic;
    RST:                in      std_logic;
    STEP:               out     std_logic
    );
end step_tl;


-------------------------------------------------------------------------------
architecture Behavioural of step_tl is

  signal w_trigger : std_logic;

begin

  interval_inst : entity work.step_interval_generator
    port map(
      CLK => CLK_100MHZ,
      i_RST => RST,
      o_TRIGGER => w_trigger
    );

  pulse_inst : entity work.step_pulse_generator
    port map(
      CLK => CLK_100MHZ,
      i_RST => RST,
      i_TRIGGER => w_trigger,
      o_STEP => STEP
    );
end Behavioural;
