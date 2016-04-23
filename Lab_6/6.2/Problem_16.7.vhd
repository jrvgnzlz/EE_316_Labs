----------------
--Problem 16-7--
----------------

entity SM_16_7 is
  port(X, Clk: in bit;
       Z: out bit);
  end SM_16_7;

architecture Table of SM_16_7 is
  signal State, Nextstate: integer range 0 to 5 := 0;
  
begin
  process(State, X)
  begin
    case State is

      when 0 =>
        if X = '1' then Z = '0'; Nextstate <= 2;
        else Z <= '0'; Nextstate <= 1; end if;

      when 1 =>
        if X = '1' then Z = '0'; Nextstate <= 0;
        else Z <= '0'; Nextstate <= 0; end if;

      when 2 =>
        if X = '1' then Z = '1'; Nextstate <= 4;
        else Z <= '0'; Nextstate <= 1; end if;

      when 3 =>
        if X = '1' then Z = '0'; Nextstate <= 5;
        else Z <= '0'; Nextstate <= 0; end if;

      when 4 =>
        if X = '1' then Z = '1'; Nextstate <= 4;
        else Z <= '0'; Nextstate <= 5; end if;

      when 5 =>
        if X = '1' then Z = '0'; Nextstate <= 5;
        else Z <= '1'; Nextstate <= 4; end if;
    end case;
  end process;

  process (Clk)
  begin
    if Clk'event and Clk = '1' then
      State <= Nextstate;
    end if;
  end process;
end Table;
