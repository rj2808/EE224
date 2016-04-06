library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_mod is
   generic(data_width : integer);
   port(s1,s2,s3,s4:in std_logic;
	u1,u2,u3,u4: in std_logic_vector(data_width-1 downto 0);
        output:out std_logic_vector(data_width-1 downto 0));
end entity;

architecture multiplexer of mux_mod is
signal s11: std_logic_vector(data_width-1 downto 0);
signal s22: std_logic_vector(data_width-1 downto 0);
signal s33: std_logic_vector(data_width-1 downto 0);
signal s44: std_logic_vector(data_width-1 downto 0);

 begin
process(s11,s22,s33,s44,s1,s2,s3,s4)
begin
for i in 0 to data_width-1 loop
	s11(i) <= s1;
	s22(i) <= s2;
	s33(i) <= s3;
	s44(i) <= s4;
end loop;
end process;

output <= (s11 and u1) or (s22 and u2) or (s33 and u3) or (s44 and u4);

end multiplexer;
