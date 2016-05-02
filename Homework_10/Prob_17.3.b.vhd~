--------------------
--Problem 17.3 (a)--
--------------------

entity Counter_4 is
  port(ClrN, LOAD, ENT, ENP, UP: std_logic; -- 1 bit inputs
       D: in std_logic_vector(3 downto 0);
       Q: out std_logic_vector(3 downto 0);
       Co: out std_logic);
  end Counter_4;

architecture State of Counter_4 is

  signal qint: std_logic_vector(3 downto 0);
  signal carry_int: std_logic;
  signal appended_signal_load, appended_signal_decrease, appended_no_signal:
    std_logic_vector(4 downto 0);

  begin
    Q <= qint;
    Co <= carry_int;
    appended_signal_load <= (carry_int & qint) + ('0' & D);
    appended_signal_decrease <= (carry_int & qint) - "00001";
    appended_no_signal <= (carry_int & qint) + '1';

    process(ClrN, Clk)
      begin
        if ClrN = '0' then
          qint <= "0000";
          carry_int <= '0';

        elsif (Clk'event and Clk = 1) then

          if LOAD = '1' then
            qint <= appended_signal_load(3 downto 0);
            carry_int <= appended_signal_load(4);
          
          elsif (LOAD = '1' and ENT = '1' and ENP = '1' and UP = '1') then
            qint <= appended_signal_decrease(3 downto 0);
            carry_int <= appended_signal_decrease(4);

          elsif (ENT = '1' and UP = '1' and  qint = "1111") then -- state 15
            carry_int <= '1'; 

          elsif (ENT = '1' and UP = '0' and qint = "0000") then
            carry_int <= '0';

          else                                                  -- default case
            qint <= appended_no_signal(3 downto 0);
            carry_int <= appended_no_signal(4);
            
          end if;

        end if;
      end process;
    end state;

         
         
