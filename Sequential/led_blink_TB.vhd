library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity led_blink_TB is
end led_blink_TB;

architecture sim of led_blink_TB is

  component led_blink
    Port(
      CLK:        in          std_logic;
      o_LED:      out         std_logic
      );
    end component;

  signal clk_tb : std_logic := '0';
  signal led_tb : std_logic;

begin

  -- Instantiate the DUT
  dut : led_blink
    port map (
      CLK => clk_tb,
      o_LED => led_tb
      );

  -- Clock gen process
  clk_process : process
    begin
      clk_tb <= '0';
      wait for 5 ns;
      clk_tb <= '1';
      wait for 5 ns;
    end process;
  
end architecture sim;
