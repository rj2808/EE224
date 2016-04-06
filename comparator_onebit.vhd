library std;
library ieee;
use ieee.std_logic_1164.all;

entity comparator1 is
	port(a,b,Lin,Ein:in std_logic;
	     Lout,Eout:out std_logic);
end entity;

architecture Behave of comparator1 is
begin

Lout <= Lin or ((not Lin) and Ein and (b and (not a)));
Eout <= (Ein and (((not a) and (not b)) or (a and b)));

end Behave;
