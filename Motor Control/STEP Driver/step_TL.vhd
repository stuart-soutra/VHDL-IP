-------------------------------------------------------------------------------
-- Title      : Step Top Level
-- Project    : 
-------------------------------------------------------------------------------
-- File       : step_TOP.vhd
-- Author     :   <AMD_2700X@DESKTOP-J833AIB>
-- Company    : Soutra Electronics
-- Created    : 2026-02-14
-- Last update: 2026-02-17
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-------------------------------------------------------------------------------
entity step_tl is
  port(
    CLK_100MHZ:         in      std_logic;
    RST:                in      std_logic;
    SW:                 in      std_logic_vector(3 downto 0);
    STEP:               out     std_logic;
    DIR:                out     std_logic
    );
end step_tl;


-------------------------------------------------------------------------------
architecture Behavioural of step_tl is

  signal w_en : std_logic;
  signal w_step_period : integer := 10000;

begin

  --Enable (SW3 = enable)
  w_en <= SW(3);
  
  --Speed selection process
  process(SW)
    begin
      case SW(2 downto 0) is
        when "000" => w_step_period <= 20000;   --5 KHz
        when "001" => w_step_period <= 10000;   --10 KHz
        when "010" => w_step_period <= 5000;    --20 KHz
        when "011" => w_step_period <= 2500;    --40 KHz
        when "100" => w_step_period <= 1250;    --80 KHz
        when others => w_step_period <= 10000;
      end case;
    end process;

  
    
  --Instantiate stepper core
  core_inst : entity work.stepper_core
    port map(
      CLK => CLK_100MHZ,
      i_RST => RST,
      i_EN => w_en,
      i_DIR => '0',     --fixed for now
      i_STEP_PERIOD => w_step_period,
      o_STEP => STEP,
      o_DIR => DIR
    );
end Behavioural;
