-------------------------------------------------------------------------------
-- Title      : LED-BLINK
-- Project    : 
-------------------------------------------------------------------------------
-- File       : led_blink.vhd
-- Author     :   <40015802@ME1C017-221771>
-- Company    : 
-- Created    : 2026-02-09
-- Last update: 2026-02-09
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Blinks LED using counter to divide clk
-------------------------------------------------------------------------------
-- Copyright (c) 2026 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2026-02-09  1.0      40015802	Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;


-------------------------------------------------------------------------------
entity led_blink is

  port (
    CLK:        in        std_logic;
    o_LED:      out       std_logic;
    );

end entity led_blink;


-------------------------------------------------------------------------------
architecture str of led_blink is

  signal counter: unsigned(25 downto 0) := (others => '0');
  signal led_reg: std_logic := '0';       

begin 

  process(CLK)
    begin
      if rising_edge(clk) then
        counter <= counter +1;
        if counter = 49_999_999 then
          counter <= (others => '0');
          led_reg <= not led_reg;
        end if;
      end if;
  end process;

  led <= led_reg;    
          

end architecture str;

-------------------------------------------------------------------------------
