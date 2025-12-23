--------------------------------------------------------------------
-- D flip-flop: Rising edge triggered D flip-flop with single output
--
-- Required signals:
--------------------------------------------------------------------
-- CLK,D: in    std_logic;
-- Q:     out   std_logic;
--------------------------------------------------------------------

-- purpose: D flip-flop (RET)
-- type   : sequential
-- inputs : CLK, D
-- outputs: Q
D-FF: process (CLK) is
begin  -- process D-FF
  if (rising_edge(CLK)) then         -- rising clock edge
    Q <= D;
  end if;
end process D-FF;
