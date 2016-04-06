library ieee;
library std;
use ieee.std_logic_1164.all;

package ShiftSubtractDivider is
	component ShiftSubtractDivider is
	port(A, B: in std_logic_vector(7 downto 0);
		Remainder, Quotient: out std_logic_vector(7 downto 0);
		start: in std_logic;
		done: out std_logic;
		clk, reset: in std_logic);
	end component;
	-- ControlPath
	component ControlPath is
	port (
		T0,T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11,T12,T13: out std_logic;
		S1, S2: in std_logic;
		start : in std_logic;
		done : out std_logic;
		clk, reset: in std_logic
	);
	end component;
	component Datapath is
	port(
		T0,T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11,T12,T13: in std_logic;
		S1, S2: out std_logic;
		A,B: in std_logic_vector(7 downto 0);
		RESULT: out std_logic_vector(7 downto 0);
		clk, reset: in std_logic
	);
	end component;


	component DataRegister is
	generic (data_width:integer);
	port (Din: in std_logic_vector(data_width-1 downto 0);
	      Dout: out std_logic_vector(data_width-1 downto 0);
	      clk, enable: in std_logic);
  	end component DataRegister;

  	-- 5 bit decrementer----------------------
  	component Decrement5 is 
  		port(A: std_logic_vector(4 downto 0); B: out std_logic_vector(4 downto 0));
  		end component;


  	component mux is
    generic(data_width : integer);
    port(s0,s1:in std_logic;
	 	 u1,u0: in std_logic_vector(data_width-1 downto 0);
         output:out std_logic_vector(data_width-1 downto 0));
	end component;


	component mux_mod
	 	generic(data_width : integer);
   		port(s1,s2,s3,s4:in std_logic;
		u1,u2,u3,u4: in std_logic_vector(data_width-1 downto 0);
        output:out std_logic_vector(data_width-1 downto 0));
	end component; 
	


  	component comparator5 is
  		port(a,b: in std_logic_vector(4 downto 0);
		 Eout : out std_logic);
	end component;


  	component subtractor16 is
  		port (A, B: in std_logic_vector(7 downto 0); RESULT: out std_logic_vector(7 downto 0));
  		end component subtractor16;

  	component comparator8 is
  		port(A, B: in std_logic_vector(7 downto 0); L: out std_logic);
  	end component;

 	component comparator1 is
 		port(a, b: in std_logic; Lout, Eout: out std_logic);
 		end component;
		component unsigned_divider is
  port(dividend,divisor: in std_logic_vector(7 downto 0);
       quotient,remainder: out std_logic_vector(7 downto 0);
       start : in std_logic;
       done : out std_logic;
       clk, reset: in std_logic);
end component unsigned_divider;
 end package;


















