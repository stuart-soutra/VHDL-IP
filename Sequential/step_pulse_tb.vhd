library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity step_pulse_tb is
end step_pulse_tb;

architecture sim of step_pulse_tb is

  component step_pulse
    Port(
      CLK:        in    std_logic;
      i_TRIGGER:  in    std_logic;
      o_STEP_OUT: out   std_logic;
      o_BUSY:     out   std_logic
      );
  end component;

  signal clk_tb : std_logic := '0';
  signal trigger_tb : std_logic := '0';
  signal step_tb : std_logic;
  signal busy_tb : std_logic;

  begin

    uut : step_pulse
      port map(
        CLK -> clk_tb,
        i_TRIGGER -> trigger_tb,
        o_STEP_OUT -> step_tb,
        o_BUSY -> busy_tb
        );

    --100 MHz clock
    clk_process : process
      begin
        clk_tb <= '0';
        wait for 5 ns;
        clk_tb <= '1';
        wait for 5 ns;
      end process;

    --Trigger stimulus
      stim : process
        begin
          wait for 100 ns;
          trigger_tb <= '1';
          wait for 10 ns;
          trigger_tb <= '0';

          wait for 1 us;

          trigger_tb <= '1';
          wait for 10 ns;
          trigger_tb <= '0';

          wait;
        end process;
    
end sim;
