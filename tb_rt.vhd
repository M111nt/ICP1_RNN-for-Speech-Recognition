

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_rt is
end tb_rt;

architecture Behavioral of tb_rt is

component rt_gate is 
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
end component;

signal clk      : std_logic := '1';      
signal reset    : std_logic; 

signal start       : std_logic;
signal input_done  : std_logic;
signal h_prev_done : std_logic;
signal op_done     : std_logic;

--input data--------------------------------------------------
signal w1          : std_logic_vector(7 downto 0);  --weights
signal w2          : std_logic_vector(7 downto 0);
signal w3          : std_logic_vector(7 downto 0);
signal w4          : std_logic_vector(7 downto 0);
signal w5          : std_logic_vector(7 downto 0);
signal w6          : std_logic_vector(7 downto 0);
signal w7          : std_logic_vector(7 downto 0);
signal w8          : std_logic_vector(7 downto 0);
signal x1          : std_logic_vector(15 downto 0); --input
signal x2          : std_logic_vector(15 downto 0);
signal x3          : std_logic_vector(15 downto 0);
signal x4          : std_logic_vector(15 downto 0);
signal x5          : std_logic_vector(15 downto 0);
signal x6          : std_logic_vector(15 downto 0);
signal x7          : std_logic_vector(15 downto 0);
signal x8          : std_logic_vector(15 downto 0);
signal bias        : std_logic_vector(7 downto 0);  --bias  
        
       
signal ready       : std_logic;
signal valid       : std_logic;
signal out_data    : std_logic_vector(15 downto 0);

constant period1         : time := 5ns;


begin

dut: rt_gate 

port map(
clk     =>clk,
reset   =>reset,

start       => start      ,
input_done  => input_done ,
h_prev_done => h_prev_done,
op_done     => op_done    ,

w1      => w1  ,
w2      => w2  ,
w3      => w3  ,
w4      => w4  ,
w5      => w5  ,
w6      => w6  ,
w7      => w7  ,
w8      => w8  ,
x1      => x1  ,
x2      => x2  ,
x3      => x3  ,
x4      => x4  ,
x5      => x5  ,
x6      => x6  ,
x7      => x7  ,
x8      => x8  ,
bias    => bias,
ready   => ready   ,
valid   => valid   ,
out_data=> out_data


);

clk <= not (clk) after 1*period1;
reset <= '1' ,
         '0' after    4*period1;

start <= '0',
        '1' after 8*period1;
         
w1 <= "10000000" after 10*period1;
w2 <= "10000000" after 10*period1;
w3 <= "10000000" after 10*period1;
w4 <= "10000000" after 10*period1;        
w5 <= "10000000" after 10*period1;
w6 <= "10000000" after 10*period1;
w7 <= "10000000" after 10*period1;
w8 <= "10000000" after 10*period1;
bias <= "10000000" after 10*period1;


x1 <= "1110000000000000";
x2 <= "1110000000000000";
x3 <= "1110000000000000";
x4 <= "1110000000000000";
x5 <= "1110000000000000";
x6 <= "1110000000000000";
x7 <= "1110000000000000";
x8 <= "1110000000000000";

input_done  <= '0';
h_prev_done <= '0';
op_done     <= '0';

end Behavioral;
