-------------------------------------------------------------------------------
-- Title      : Reg 8-Bit
-- Project    : 
-------------------------------------------------------------------------------
-- File       : REG-8BIT.vhd
-- Author     :   <AMD_2700X@DESKTOP-J833AIB>
-- Company    : Soutra Electronics
-- Created    : 2025-12-23
-- Last update: 2025-12-23
-- Platform   : 
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description: 8-Bit Register with Load Enable
-------------------------------------------------------------------------------
-- Copyright (c) 2025 Soutra Electronics
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2025-12-23  1.0      AMD_2700X	Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;


-------------------------------------------------------------------------------
entity REG-8BIT is

  port (
    CLK:        in      std_logic;
    i_LD:       in      std_logic;
    i_D:        in      std_logic_vector(7 downto 0);
    o_Q:        in      std_logic_vector(7 downto 0);
    );

end entity REG-8BIT;


-------------------------------------------------------------------------------
architecture str of REG-8BIT is

begin
  REG: process (CLK) is
  begin  -- process REG
    if (rising_edge(CLK)) then       -- rising clock edge
      if (i_LD = '1') then
        o_Q <= i_D;
      end if;
    end if;
  end process REG;

end architecture str;

-------------------------------------------------------------------------------
