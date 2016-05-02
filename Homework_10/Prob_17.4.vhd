----------------
--Problem 17.4--
----------------

entity 4_to_1_Mux is
  port(A, B, C, D: in std_logic;
       Z: out std_logic);

end 4_to_1_Mux;

architecture out_z of 4_to_1_Mux is
  
  signal I: std_logic_vector(1 to 0);

  begin
    I <= A & B;

    process (A,B,C,D)
      case I is
        
        when "00" =>
          Z <= (not C) or D;
          
        when "01" =>
          Z <= C;

        when "10" =>
          Z <= (not C) xor D;

        when "11" =>
          Z <= (not D);

        end case;

      end process;
end out_z;
          
