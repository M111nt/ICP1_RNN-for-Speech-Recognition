

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;


entity ut_gate is
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
end ut_gate;

architecture Behavioral of ut_gate is

    signal bias_in      : std_logic_vector(27 downto 0);
    
    signal result       : std_logic_vector(27 downto 0);    
    signal result_nxt   : std_logic_vector(27 downto 0);
    
    signal valid_in     : std_logic;

--ff---------------------------------------------------------------
component ff is
  generic(N:integer:=1);
  port(   D  :  in std_logic_vector(N-1 downto 0);
          Q  : out std_logic_vector(N-1 downto 0);
        clk  :  in std_logic;
        reset:  in std_logic
      );
end component;
-------------------------------------------------------------------
--state machine----------------------------------------------------

    type state_type is (s_idle, s_first_op, s_op);
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

state: process (state_reg, start, input_done, bias, h_prev_done, op_done, result)

begin
    ready <= '0';
    valid <= '0';
    valid_in <= '0';

    case state_reg is
        
        when s_idle => 
            ready <= '1';
            if start = '1' then 
                state_nxt <= s_first_op;
            else
                state_nxt <= s_idle;
            end if;
            
        when s_first_op => 
            if bias(7) = '1' then
                bias_in <= "11111111111111" & bias & "000000";
            else
                bias_in <= "00000000000000" & bias & "000000";
            end if;            
            state_nxt <= s_op;
            
        
        when s_op =>

            bias_in <= result;
            
            if input_done = '1' then 
                if h_prev_done = '1' then 
                    if op_done = '1' then 
                        valid <= '1';
                        valid_in <= '1';
                        state_nxt <= s_idle;
                    else 
                        state_nxt <= s_first_op;
                    end if;
                else
                    state_nxt <= s_op;
                end if;
            else 
                state_nxt <= s_op;
            end if;
        
    
    end case; 
    


end process;

with state_reg select 
result_nxt <= 
    (others => '0') when s_idle, 
    std_logic_vector(shift_right(signed(w1)*signed(x1) + signed(w2)*signed(x2) + signed(w3)*signed(x3) + signed(w4)*signed(x4) + 
    signed(w5)*signed(x5) + signed(w6)*signed(x6) + signed(w7)*signed(x7) + signed(w8)*signed(x8), 7) + signed(bias_in)) when others;
    --shift right 7 bit to keep all integer

with valid_in select 
out_data <= 
    (others => '0') when '0',
    result(22 downto 7) when '1';--the highest bit always be 0, so it should be not considered in 16-bit result 
    

result_reg: FF 
  generic map(N => 28)
  port map(   D     =>result_nxt,
              Q     =>result,
            clk     =>clk,
            reset   =>reset
      );


end Behavioral;
