

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;



entity mem_cell is
  Port ( 
        clk,reset   : in std_logic;
        
        --input-------------------------------------------------------
        start       : in std_logic;
        input_done  : in std_logic;
        h_prev_done : in std_logic;
        op_done     : in std_logic;
        
        --input data--------------------------------------------------
        w1          : in std_logic_vector(7 downto 0);  --weights
        w2          : in std_logic_vector(7 downto 0);
        w3          : in std_logic_vector(7 downto 0);
        w4          : in std_logic_vector(7 downto 0);
        w5          : in std_logic_vector(7 downto 0);
        w6          : in std_logic_vector(7 downto 0);
        w7          : in std_logic_vector(7 downto 0);
        w8          : in std_logic_vector(7 downto 0);
        x1          : in std_logic_vector(15 downto 0); --input
        x2          : in std_logic_vector(15 downto 0);
        x3          : in std_logic_vector(15 downto 0);
        x4          : in std_logic_vector(15 downto 0);
        x5          : in std_logic_vector(15 downto 0);
        x6          : in std_logic_vector(15 downto 0);
        x7          : in std_logic_vector(15 downto 0);
        x8          : in std_logic_vector(15 downto 0);
        bias        : in std_logic_vector(7 downto 0);  --bias  
        
        --output----------------------------------------------------
        ready       : out std_logic;
        valid       : out std_logic;
        --output data-----------------------------------------------
        out_data    : out std_logic_vector(15 downto 0)
        
  );
end mem_cell;

architecture Behavioral of mem_cell is

--state machine----------------------------------------------------

    type state_type is (s_idle, s_first_op, s_op, s_h_prev);
    signal state_reg, state_nxt : state_type;
-------------------------------------------------------------------


begin

state_ctrl: process (clk, reset)
begin
    if reset = '1' then 
        state_reg <= s_idle; 
    elsif (clk'event and clk = '1') then 
        state_reg <= state_nxt; 
    end if;         
end process;

state: process (state_reg, start, input_done, h_prev_done, op_done)
begin 

    case state_reg is 
    
    when s_idle => 
    
    when s_first_op => 
    
    when s_op => 
    
    when s_h_prev => 

    end case;

end process;








end Behavioral;
