library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux is
   generic(data_width : integer);
   port(s0,s1:in std_logic;
	u1,u0: in std_logic_vector(data_width-1 downto 0);
        output:out std_logic_vector(data_width-1 downto 0));
end entity;

architecture multiplexer of mux is
signal sel1: std_logic_vector(data_width-1 downto 0);
signal sel0: std_logic_vector(data_width-1 downto 0);

 begin
process(s1,s0,u1,u0)
begin
for i in 0 to data_width-1 loop
	sel1(i) <= s1;
	sel0(i) <= s0;
end loop;
end process;
output <= (sel1 and u1) or (sel0 and u0);

end multiplexer;
