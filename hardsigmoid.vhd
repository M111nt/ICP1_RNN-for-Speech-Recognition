

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;


entity hardsigmoid is
  Port ( 
        clk,reset   : in std_logic;
        data_in     : in std_logic_vector(15 downto 0);
        add_done    : in std_logic;
        
        data_out    : out std_logic_vector(15 downto 0)
  );
end hardsigmoid;

architecture Behavioral of hardsigmoid is


--state machine----------------------------------------------------

    type state_type is (s_idle, s_sigmoid);
    signal state_reg, state_nxt : state_type;
-------------------------------------------------------------------

signal data_temp : std_logic_vector(15 downto 0);

begin

state_ctrl: process (clk, reset)
begin
    if reset = '1' then 
        state_reg <= s_idle; 
    elsif (clk'event and clk = '1') then 
        state_reg <= state_nxt; 
    end if;         
end process;

state: process(state_reg, data_in)
begin

    case state_reg is 
    
        when s_idle => 
            if add_done = '1' then
                state_nxt <= s_sigmoid;
            else 
                state_nxt <= s_idle;
            end if;
    
        when s_sigmoid => 
            if data_in > "0000000010100000" then -- 0000000010 100000 2.5
                data_out <= "0000000001000000"; -- 0000000001 000000 1
                             
            elsif data_in < "1111111110100000" then --1111111110 100000 -2.5
                data_out <= (others => '0');
            
            else
                data_out <= std_logic_vector(shift_right(signed(data_in),6)*(shift_left(signed(13),6)) + (shift_left(signed(1),5)));
                -- data_in/64 * 13 + 1/2
            end if;
            
            state_nxt <= s_idle;
            
            
    
    end case;

end process;


end Behavioral;
