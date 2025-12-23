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
-- inputs : CLK, i_D
-- outputs: o_Q
D-FF: process (CLK) is
begin  -- process D-FF
  if (rising_edge(CLK)) then         -- rising clock edge
    o_Q <= i_D;
  end if;
end process D-FF;
