
-----------------------------------------------------------
--Problem 17.3 (b)                                       --
--  REMARKS: The Counter_4 is carried over from part (a).--
-----------------------------------------------------------

entity Counter_8 is
  port(ClrN, LOAD, ENT, ENP, UP: std_logic; -- 1 bit inputs
     D: in std_logic_vector(7 downto 0);
     Q: out std_logic_vector(7 downto 0);
     Co: out std_logic);
end Counter_8;

architecture State_8 of Counter_8 is

  --- Counter_4 has parameters inside this declaration. Thus, the overloading
  --- of names does not matter (even though it is confusing).
  
  component Counter_4
    port(ClrN, LOAD, ENT, ENP, UP: std_logic; -- 1 bit inputs
         D: in std_logic_vector(3 downto 0);
         Q: out std_logic_vector(3 downto 0);
         Co: out std_logic);
  end component;

  signal ic: std_logic; -- "internal conversion"
  
  begin
    Q_Right: Counter_4 port map (ClrN, LOAD, ENT, ENP, UP,         -- inputs
                                 D(3 downto 0), Q(3 downto 0),ic); -- outputs
    
    Q_Left: Counter_4 port map (ClrN, LOAD, ic, ENP, UP,
                                D(7 downto 4), Q(7 downto 4), Co);

end State_8;
  

         
