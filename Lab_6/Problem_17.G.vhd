----------------------------------------------------------------------------------
--The following is a 6-bit accumulator. It uses a 6-Bit adder feed into 6 muxes.--
----------------------------------------------------------------------------------

-------------------
--Concurrent Code--
-------------------


-- Full_Adder Declaration
entity Full_Adder is
  port(X, Y, Cin: in bit; -- Inputs
       Cout, Sum: out bit); -- Outputs

end Full_Adder;

architecture Equations of Full_Adder is
begin
  Sum <= X xor Y xor Cin;
  Cout <= (X and Y) or (X and Cin) or (Y and Cin);
end Equations;


-- Adder_6 (6-Bit Parrallel Adder)
entity Adder_6 is
  port(A, B: in bit_vector(5 downto 0); Ci: in bit;
       S: out bit_vector(5 downto 0); Co: out bit);
end Adder_6;

architecture Structure of Adder_6 is
  component Full_Adder
    port(X, Y, Cin: in bit; -- Inputs
         Cout, Sum: out bit); -- Ouputs
  end component;

  signal C: bit_vector(5 downto 1);
begin
  F0: Full_Adder port map (A(0), B(0), Ci, C(1), S(0));
  F1: Full_Adder port map (A(1), B(1), C(1), C(2), S(1));
  F2: Full_Adder port map (A(2), B(2), C(2), C(3), S(2));
  F3: Full_Adder port map (A(3), B(3), C(3), C(4), S(3));
  F4: Full_Adder port map (A(4), B(4), C(4), C(5), S(4));
  F5: Full_Adder port map (A(5), B(5), C(5), Co, S(5));
end Structure;

  
-------------------
--Sequential Code--
-------------------

-- D-CE Flip Flop

entity D_CE is
  port(Clr_N, Clk, Add: in bit; D: in bit_vector(5 downto 0);    -- inputs
       Q, QN: out bit_vector(5 downto 0) );                      -- ouputs
end D_CE;

-- Remark: In the declaration above, Add = Enable.

architecture D_CE_6 of D_CE is
  signal Qint: bit_vector(5 downto 0);          -- internal signals

begin                                           -- uninterupted state
  Q <= Qint;
  QN <= not Qint;

  process(Clk, Clr_N)
  begin
    if Clr_N = '0' then Qint <= '000000';            -- Asynchronis
    elsif Clk'event and Clk = '1' then
      if Add = '1' then Qint <= D;
      end if;
    end if;
  end process;                      

-- Remark: The following process only does two things:
--          * Clears Qint iff ClrN is active.
--          * Sets Qint to D iff AND(Clk_N, Add, Clk'event) = 1;
--
                         
end D_CE_6;
