
-- These are your libraries

library IEEE; -- defines the standard datatypes
use IEEE.STD_LOGIC_1164.ALL;            -- }
use IEEE.STD_LOGIC_ARITH.ALL;           -- }
use IEEE.STD_LOGIC_UNSIGNED.ALL;        -- } Packages

library BITLIB;
use BITLIB.bit_pack.all;


-- Entity Declaration
-- Inputs: Weighted by Indexed 
-- Outputs: a1 > b1, c1 is null checker
entity four_to_two_pe is
  port(y: in std_logic_vector(0 to 3);
       a1,b1,c1: out std_logic);
  end four_to_two_pe;
  
-- Architecture Body

architectuer equation of four_to_two_pe is
  begin
    a1 <= y(3) or y(2);
    b1 <= y(2) or y(1);
    c1 <= y(3) or y(2) or y(1) or y(0); -- ** Ask if there is a shorthand for these!
    end equation;
    
  
