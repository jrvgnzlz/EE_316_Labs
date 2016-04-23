----------------
--Problem 16-7--
----------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sm is
port(x, clk, rst: in STD_LOGIC;

	Z, Q3, Q2, Q1: out STD_LOGIC
	);
end entity;

architecture Table of SM is
  signal State, Nextstate: integer range 0 to 5 := 0;
  signal state_output: std_logic_vector(2 downto 0);
  
begin
    
  state_output <= conv_std_logic_vector(state, 3);
  Q3 <= state_output(2);
  Q2 <= state_output(1);
  Q1 <= state_output(0);

  process(State, X)
  begin
    case State is

      when 0 =>
        if X = '1' then Z <= '0'; Nextstate <= 2;
        else Z <= '0'; Nextstate <= 1; end if;

      when 1 =>
        if X = '1' then Z <= '0'; Nextstate <= 0;
        else Z <= '0'; Nextstate <= 0; end if;

      when 2 =>
        if X = '1' then Z <= '1'; Nextstate <= 4;
        else Z <= '0'; Nextstate <= 1; end if;

      when 3 =>
        if X = '1' then Z <= '0'; Nextstate <= 5;
        else Z <= '0'; Nextstate <= 0; end if;

      when 4 =>
        if X = '1' then Z <= '1'; Nextstate <= 4;
        else Z <= '0'; Nextstate <= 5; end if;

      when 5 =>
        if X = '1' then Z <= '0'; Nextstate <= 5;
        else Z <= '1'; Nextstate <= 4; end if;
    end case;
  end process;

  process (clk, rst)
  begin
    if rst = '1' then
        State <= 0;
    
    elsif clk'event and clk = '1' then
      State <= Nextstate;
    end if;
  end process;
end Table;
