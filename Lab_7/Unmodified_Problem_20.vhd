library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---------------------------------------------------------
--REMARK:  Inputs are defined per 20.U on lab document.--
--WARNING: Check naming convention used in this        --
--         declaration to verify that it is the        --
--         same as the *TOP.vhd* for the wrapper.      --
---------------------------------------------------------

entity Product_Sum is
  port(Clk, Rst, Start: in std_logic;
       X,Y: in std_logic_vector(3 downto 0);
       Z: in std_logic_vector(2 downto 0);
       Result: out std_logic_vector(7 downto 0);
       Done: out std_logic);
  end Product_Sum;

architecture Control_Signals of Product_Sum is

  -----------------------
  --Signal Declarations--
  -----------------------

  -- Registers
  signal ACC: std_logic_vector(8 downto 0);
  signal add_4: std_logic_vector(3 downto 0);
  signal add_9: std_logic_vector(8 downto 0);
  
  -- Internal Signals
  alias M: std_logic is ACC(0);
  signal State, Nextstate: integer range 0 to 17;
  signal shift: std_logic;

  -- Controller Output
  
  --signal select_register: integer range 0 to 3;
  signal adder_select: integer range 0 to 2;
  signal load_register: integer range 0 to 5;

-- Arithmetic Outputs
  signal add_4_out: std_logic_vector (4 downto 0);  -- running sum of 4-bit adder
  signal add_9_out: std_logic_vector (8 downto 0);  -- running sum of 9-bit adder
  

  begin

    ----------------------
    --Signal Assignments--
    ----------------------

    add_4_out <= (('0' & ACC(7 downto 4)) + add_4);  -- Needs verification!
    add_9_out <= (("000000" & Z) + ACC);

    Result <= ACC(7 downto 0);
    --+

    -------------------------
    --Combinatorial Circuit--
    -------------------------
    
    process (State, Start, M)
    begin

      case State is

        when 0 =>
          if Start = '1' then
           load_register <= 1;
           Nextstate <= 1;
           shift <= '0';
           adder_select <= 0;
           
          else
            Nextstate <= 0;
            shift <= '0';
            adder_select <= 0;
            load_register <= 0; 
          end if;

        when 1 =>
          load_register <= 2;
          Nextstate <= 2;
          shift <= '0';
          adder_select <= 0;

        when 2 =>
          load_register <= 3;
          Nextstate <= 3;
          shift <= '0';
          adder_select <= 0;


        --------------
        --Symmetries--
        --------------
          
        when 3 | 6 | 9 | 12 =>
          if M = '1' then
            adder_select <= 1;
            Nextstate <= Nextstate + 1;
            shift <= '0';
            load_register <= 0; 
          else
            Nextstate <= Nextstate + 2;
            shift <= '0';
            adder_select <= 0;
            load_register <= 0; 
          end if;  

        when 4 | 7 | 10 | 13 =>
          load_register <= 4;
          Nextstate <= Nextstate + 1;
          shift <= '0';
          adder_select <= 0;

        when 5 | 8 | 11 =>
          shift <= '1';
          Nextstate <= Nextstate + 1;
          adder_select <= 0;
          load_register <= 0;
          
        when 14 =>
          shift <= '1';
          Nextstate <= 15;
          adder_select <= 0;
          load_register <= 0; 

        --------------------
        --9-Bit Arithmetic--
        --------------------

        when 15 =>
          adder_select <= 2;
          Nextstate <= 16;
          shift <= '0';
          load_register <= 0;
          
        when 16 =>
          load_register <= 5;
          Nextstate <= 17;
          shift <= '0';
          adder_select <= 0;

        when 17 =>
          if Rst = '1' then
            Nextstate <= 0;
            shift <= '0';
            adder_select <= 0;
            load_register <= 0; 

          else
            Nextstate <= 17;
            shift <= '0';
            adder_select <= 0;
            load_register <= 0; 

          end if;
               
        end case;
    end process;

    ----------------
    --Control Unit--
    ----------------
      
      --------------------------------------------------------------------
      --REMARKS: Updates all /registers/ on the rising edge of the clock--
      --         and the *State*.                                       --
      --------------------------------------------------------------------
    
    process (Clk, Rst)
      begin
        if Rst = '1' then
          State <= 0;
        end if;
        
        if Clk'event and Clk = '1' and Rst = '0' then

           if load_register = 1 then
             ACC(3 downto 0) <= X;
             ACC(8 downto 4) <= "00000";
             end if;
             
           if load_register = 2 then
             add_4 <= Y;
             end if;

           if load_register = 3 then
             add_9(2 downto 0) <= Z;
             add_9(8 downto 3) <= "000000";
             end if;
             
          --------------
          --Symmetries--
          --------------
           if load_register = 4 then
             ACC(8 downto 4) <= add_4_out;
           end if;

           --------------------
           --9-Bit Arithmetic--
           --------------------
           if load_register = 5 then
             ACC <= add_9_out;
           end if;

           ---------
           --Shift--
           ---------
           if Shift = '1' then
             ACC <= '0' & ACC(8 downto 1);
           end if;

           if Nextstate = 17 then
             Done <= '1';
           else Done <= '1';
           end if;

           State <= Nextstate;
        end if;
       
      end process;
    
end Control_Signals;

