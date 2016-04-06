--Data Path
library ieee;
use ieee.std_logic_1164.all;
use work.ShiftSubtractDivider.all;

entity DataPath is
	port(
			T0,T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11,T12,T13: in std_logic;
			S1, S2: out std_logic;
			dividend,divisor: in std_logic_vector(7 downto 0);
			quotient, remainder: out std_logic_vector(7 downto 0);
			clk, reset: in std_logic 
		);
end entity;

architecture Mega of DataPath is
	signal DIVIDENDREG, DIVISORREG,QUOTIENTREG: std_logic_vector(7 downto 0);
    signal COUNT: std_logic_vector(4 downto 0);
    signal TDIFF: std_logic_vector(7 downto 0);

    signal DIVIDENDREG_in, DIVISORREG_in,QUOTIENTREG_in,RESULT_in,REMAINDER_in: std_logic_vector(7 downto 0);
    signal COUNT_in: std_logic_vector(4 downto 0);
    signal TDIFF_in: std_logic_vector(7 downto 0);
    signal DIVIDEND_INTER :std_logic_vector (7 downto 0);
    signal SUB : std_logic_vector (7 downto 0);
    signal TDIFF_INTER1 : std_logic_vector (7 downto 0);
    signal TDIFF_INTER2 : std_logic_vector (7 downto 0);
    signal QUOTIENT_INTER1 : std_logic_vector (7 downto 0);
    signal QUOTIENT_INTER2 : std_logic_vector (7 downto 0);
   
    signal Eout: std_logic;
    signal L : std_logic;

    signal decout: std_logic_vector(4 downto 0);
    constant C4 : std_logic_vector(4 downto 0) := "01000";
    constant C : std_logic_vector(0 downto 0) := "0";
    constant C6 : std_logic_vector(4 downto 0) := "00000";
    constant C16 : std_logic_vector(7 downto 0) := (others => '0');

signal count_enable, dividendreg_enable, divisorreg_enable, tdiff_enable, quotient_enable, remainder_enable,result_enable: std_logic;
begin
--
Com : comparator5 port map(a => COUNT, b => C6, Eout => Eout);
S2 <= Eout;
c1 : comparator8 port map(a => TDIFF, b => DIVISORREG, L => L);
S1 <= not L;
--------------------
-- count related 
--------------------



----Decrement
decr: decrement5 port map(A => COUNT, B => decout);

--count register
count_enable <= (T0 or T5);
mux1 : mux 
			generic map(data_width=>5)
		  	port map(s0 => T0, s1 => T5, u1 => decout, u0 => C4, output => COUNT_in);
-- If the State is 10 then decrOut is Implemented and If 01 then Count = 8

count_reg:  DataRegister 
                   generic map (data_width => 5)
                   port map (Din => COUNT_in,
                             Dout => COUNT,
                             Enable => count_enable,
                             clk => clk);

--------------------
---- Dividerreg
--------------------

	 dividendreg_enable <= (T1 or T6);
    DIVIDEND_INTER <= (DIVIDENDREG(6 downto 0) & C); -- Left shift by 1
    mux2 : mux 
             generic map (data_width => 8)
	     port map(s0 => T6, s1 => T1, u1 => dividend, u0 => DIVIDEND_INTER, output => DIVIDENDREG_in);

	  Kar: DataRegister 
             generic map (data_width => 8)
             port map (
			 Din => DIVIDENDREG_in, Dout => DIVIDENDREG,
				Enable => dividendreg_enable, clk => clk);

-------------------
----Divisor Related Logic
------------------
    DIVISORREG_in <= divisor;  -- not really needed, just being consistent.
    divisorreg_enable <= T2;
    br: DataRegister generic map(data_width => 8)
			port map (Din => DIVISORREG_in, Dout => DIVISORREG, Enable => divisorreg_enable, clk => clk);

-------------------------
---Quotient Related Logic

-------------------------


    QUOTIENT_INTER1 <= (QUOTIENTREG(6 downto 0) & '1'); -- left shift by 1 and adding last element
    QUOTIENT_INTER2 <= (QUOTIENTREG(6 downto 0) & '0');
    mux3 : mux_mod 	generic map(data_width=>8)
			port map(s1=>T3, s2=>T8, s3=>T10, s4=>'0', u1 => C16, u2=>QUOTIENT_INTER1, 
			  u3=>QUOTIENT_INTER2, u4=>QUOTIENTREG, output=>QUOTIENTREG_in);
    quotient_enable <= (T3 or T8 or T10);

    pr: DataRegister generic map(data_width => 8)
			port map(Din => QUOTIENTREG_in, Dout => QUOTIENTREG, Enable => quotient_enable, clk => clk);

-------------------------------------------------
-- TDIFF related logic
-------------------------------------------------
 
   TDIFF_INTER1 <= ("0000000" & dividend(7));
    TDIFF_INTER2 <= (TDIFF(6 downto 0) & DIVIDENDREG(7)); -- Taking care of the 1 unit delay
    sub1 : subtractor16 port map(A =>TDIFF, B=>DIVISORREG, RESULT => SUB);
    m3 : mux_mod 	generic map(data_width=>8)
			port map(s1=>T7, s2=>T9, s3=>T4, s4=>T11, u1=>SUB, u2=>TDIFF, u3=>TDIFF_INTER1, u4=>TDIFF_INTER2, output=>TDIFF_in);
    tdiff_enable <= T7 or T9 or T4 or T11 ;
    tr: DataRegister generic map(data_width => 8)
				port map(Din => TDIFF_in, Dout => TDIFF, Enable => tdiff_enable, clk => clk);




-------------------------
--Remainder Related Login
-------------------------

REMAINDER_in <= TDIFF(7 downto 0);
    remainder_enable <= T12;
    r1: DataRegister generic map(data_width => 8)
			port map(Din => REMAINDER_in, Dout =>remainder , Enable => remainder_enable, clk => clk);
-------------------------------------------------
-- RESULT related logic
-------------------------------------------------
    RESULT_in <= QUOTIENTREG;
    result_enable <= T13;
    r2: DataRegister generic map(data_width => 8)
			port map(Din => RESULT_in, Dout =>quotient , Enable => result_enable, clk => clk);




end Mega;

    



















	
