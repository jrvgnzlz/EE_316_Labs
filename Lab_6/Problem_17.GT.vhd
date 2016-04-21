----------------------------------------------------------------------------------
--The following is a 6-bit accumulator. It uses a 6-Bit adder feed into 6 muxes.--
----------------------------------------------------------------------------------
entity Accumulator is
  port(D: in bit_vector(5 downto 0); Clr, Clk, Ad: in bit;
       Q: out bit_vector(5 downto 0));

  architecture Structure of Accumulator is
      signal C: bit_vector(4 downto 0);         -- Internal Carry
      signal Z: bit_vector(5 downto 0);
      signal Qint: bit_vector(5 downto 0);
      
      
  begin
    
      Q <= Qint;
      QN <= not Qint;

----------------------
--Combinatorial Code--
----------------------    
     
      process (Q, D, C)                         -- 6-Bit Full Adder
        begin
        Z(0) <= Q(0) xor D(0);
        Z(1) <= Q(1) xor D(1) xor C(0);
        Z(2) <= Q(2) xor D(2) xor C(1);
        Z(3) <= Q(3) xor D(3) xor C(2);
        Z(4) <= Q(4) xor D(4) xor C(3);
        Z(5) <= Q(5) xor D(5) xor C(4);

        C(0) <= (Q(0) and D(0));
        C(1) <= (Q(1) and D(1)) or (Q(1) and C(0)) or (D(1) and C(0));
        C(2) <= (Q(2) and D(2)) or (Q(2) and C(1)) or (D(2) and C(1));
        C(3) <= (Q(3) and D(3)) or (Q(3) and C(2)) or (D(3) and C(2));
        C(4) <= (Q(4) and D(4)) or (Q(4) and C(3)) or (D(4) and C(3));
      end process;

------------
--Proccess--
------------
      --process (Clr, Clk)
      --  begin
      --    if Clr = '0' then Qint <= "000000";   -- Asynchronis
      --    elsif Clk'event and Clk = '1' then
      --      if Ad = '1' then Qint <= D;
      --      end if;
      --    end if;
      --end process;

--Remark: The following process only does two things:
--          * Clears Qint iff ClrN is active.
--          * Sets Qint to D iff AND(Clk_N, Add, Clk'event) = 1;

end Structure;
