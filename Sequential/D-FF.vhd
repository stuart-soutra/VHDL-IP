-------------------------------------------------------------------------------
-- Title      : D Flip-Flop - RET
-- Project    : 
-------------------------------------------------------------------------------
-- File       : D-FF.vhd
-- Author     :   <AMD_2700X@DESKTOP-J833AIB>
-- Company    : Soutra Electronics
-- Created    : 2025-12-23
-- Last update: 2025-12-23
-- Platform   : 
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description: D Flip-Flop - Rising Edge Triggered
-------------------------------------------------------------------------------
-- Copyright (c) 2025 
-------------------------------------------------------------------------------
-- Revisions  : 1.0
-- Date        Version  Author  Description
-- 2025-12-23  1.0      AMD_2700X	Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;


-------------------------------------------------------------------------------
entity D-FF is

  port (
    CLK:        in      std_logic;
    RST:        in      std_logic;
    i_D:        in      std_logic;
    o_Q:        out     std_logic;
    );

end entity D-FF;


-------------------------------------------------------------------------------
architecture str of D-FF is

begin  -- architecture str

 D_FF: process (CLK) is
 begin  -- process D_FF
   if (RST = '0') then                  -- asynchronous reset (active low)
     o_Q <= '0';
   elsif (rising_edge(CLK)) then        -- rising clock edge
     o_Q <= i_D;
   end if;
 end process D_FF;

end architecture str;


-------------------------------------------------------------------------------

