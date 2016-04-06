library std;
library ieee;
use ieee.std_logic_1164.all;
library work;
use work.ShiftSubtractDivider.all;


entity comparator5 is
	port (a,b: in std_logic_vector(4 downto 0);
		 Eout : out std_logic);
end entity;

architecture Behave of comparator5 is
signal Lin,Ein : std_logic_vector (5 downto 0);
begin
Lin(5) <= '0';
Ein(5) <= '1';
L0: comparator1 port map(a => a(4), b => b(4), Lin => Lin(5), Ein => Ein(5), Lout =>Lin(4), Eout =>Ein(4));
L1: comparator1 port map(a => a(3), b => b(3), Lin => Lin(4), Ein => Ein(4), Lout =>Lin(3), Eout =>Ein(3));
L2: comparator1 port map(a => a(2), b => b(2), Lin => Lin(3), Ein => Ein(3), Lout =>Lin(2), Eout =>Ein(2));
L3: comparator1 port map(a => a(1), b => b(1), Lin => Lin(2), Ein => Ein(2), Lout =>Lin(1), Eout =>Ein(1));
L4: comparator1 port map(a => a(0), b => b(0), Lin => Lin(1), Ein => Ein(1), Lout =>Lin(0), Eout =>Ein(0)); 

Eout <= Ein(0);

end Behave;

