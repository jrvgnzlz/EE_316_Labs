-- Poulami Das 
-- Created on 10/11/2015
-- Top level wrapper that comprises of the design and a clock divider. 
-- The slow clock is used to clock the design

library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity Top is
  port(clock_100Mhz, T_Rst, T_Start: in std_logic;
       T_X,T_Y: in std_logic_vector(3 downto 0);
       T_Z: in std_logic_vector(2 downto 0);
       T_Result: out std_logic_vector(7 downto 0);
       T_Done: out std_logic;
       clk_1Hz: out std_logic);  
end Top;

architecture connection of Top is
-- declare State machine design and clock divider as component
component Product_Sum 
  port(Clk, Rst, Start: in std_logic;
       X,Y: in std_logic_vector(3 downto 0);
       Z: in std_logic_vector(2 downto 0);
       Result: out std_logic_vector(7 downto 0);
       Done: out std_logic);
end component;

component clock_divider 
port(clock_100Mhz: in STD_LOGIC;
     clock_1Hz: out STD_LOGIC
     );
end component;

-- internal signals
signal slow_clock : std_logic;

begin
 clk_1Hz <= slow_clock;
 clock_div_inst : clock_divider port map(clock_100Mhz, slow_clock);
 Arbitrary_Name : Product_Sum port map (clk => slow_clock,
                                        rst => T_Rst,
                                        Start => T_Start,
                                        X => T_X,
                                        Y => T_Y,
                                        Z => T_Z,
                                        Result => T_Result,
                                        Done => T_Done); 
end connection;
