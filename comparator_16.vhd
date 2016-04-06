library std;
library ieee;
use ieee.std_logic_1164.all;
use work.ShiftSubtractDivider.all;

entity comparator16 is
	port(a,b :in std_logic_vector (7 downto 0);
	     L:out std_logic);
end entity;

architecture Behave of comparator16 is
signal Lin: std_logic_vector (8 downto 0);
signal Ein: std_logic_vector (8 downto 0);
begin
Lin(8) <= '0';
Ein(8) <= '1';

L9: comparator1 port map(a => a(7), b => b(7), Lin => Lin(8), Ein => Ein(8), Lout =>Lin(7), Eout =>Ein(7));
L10: comparator1 port map(a => a(6), b => b(6), Lin => Lin(7), Ein => Ein(7), Lout =>Lin(6), Eout =>Ein(6));
L11: comparator1 port map(a => a(5), b => b(5), Lin => Lin(6), Ein => Ein(6), Lout =>Lin(5), Eout =>Ein(5));
L12: comparator1 port map(a => a(4), b => b(4), Lin => Lin(5), Ein => Ein(5), Lout =>Lin(4), Eout =>Ein(4));
L13: comparator1 port map(a => a(3), b => b(3), Lin => Lin(4), Ein => Ein(4), Lout =>Lin(3), Eout =>Ein(3));
L14: comparator1 port map(a => a(2), b => b(2), Lin => Lin(3), Ein => Ein(3), Lout =>Lin(2), Eout =>Ein(2));
L15: comparator1 port map(a => a(1), b => b(1), Lin => Lin(2), Ein => Ein(2), Lout =>Lin(1), Eout =>Ein(1));
L16: comparator1 port map(a => a(0), b => b(0), Lin => Lin(1), Ein => Ein(1), Lout =>Lin(0), Eout =>Ein(0));

L <= Lin(0);

end Behave;
	 
