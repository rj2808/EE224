library ieee;
use ieee.std_logic_1164.all;
use work.ShiftSubtractDivider.all;
entity subtractor16 is
   port (A, B: in std_logic_vector(7 downto 0); RESULT: out std_logic_vector(7 downto 0));
end entity;
architecture Serial of subtractor16 is
begin
   process(A,B)
     variable carry: std_logic;
   begin
     carry := '1';
     for I in 0 to 7 loop
        RESULT(I) <= (A(I) xor not(B(I))) xor carry;
        carry := (carry and (A(I) or not(B(I)))) or (A(I) and not(B(I)));
     end loop;
     
   end process;
end Serial;
