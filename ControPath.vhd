---- Control Path

library ieee;
use ieee.std_logic_1164.all;
use work.ShiftSubtractDivider.all;
entity ControlPath is
	port (
		T0,T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11,T12,T13: out std_logic;
		S1,S2: in std_logic;
		start : in std_logic;
		done : out std_logic;
		clk, reset: in std_logic
	     );
end entity;

architecture Mega2 of ControlPath is

   type FsmState is (rst, diff, update, done1); --- All the States
   signal fsm_state : FsmState; -----FSM State
begin

   process(fsm_state, start,S1,S2, clk, reset)
      variable next_state: FsmState;
      variable var: std_logic_vector(13 downto 0);
      variable output_var: std_logic;
      variable divide_var: std_logic;
   begin
-----------  Initialising 
       var := (others => '0');
       output_var := '0';
       next_state := fsm_state;
       
       case fsm_state is 
         -------- Check Pseudo Code for more
	 when rst =>           
		if(start = '1') then
                  next_state := diff;
                  var(0) := '1'; var(1) := '1'; var(2) := '1'; var(3) := '1';var(4) := '1';
		else
		  next_state := rst;
	        end if;

          when diff =>
               next_state := update;
               var(5) := '1'; var(6) := '1';
	       if(S1 = '1') then
			var(7) := '1'; var(8) :='1';
	       else
			var(9) := '1'; var(10) := '1';
	       end if;		
		
          when update =>
               var(11) := '1'; 
               if(S2 = '1') then
                  var(12) := '1';
		  var(13) := '1';
                  next_state := done1;
               else
                  next_state := diff;
               end if;
          when done1 =>
               output_var := '1';
               next_state := rst;

	       
     end case;

          T0 <= var(0);
 	  T1 <= var(1);
	  T2 <= var(2);
	  T3 <= var(3);
	  T4 <= var(4);
     	  T5 <= var(5);	
	  T6 <= var(6);
	  T7 <= var(7);
	  T8 <= var(8);
	  T9 <= var(9);
	  T10 <= var(10);
	  T11 <= var(11);
	  T12 <= var(12);
	  T13 <= var(13); 
      
     if(clk'event and (clk = '1')) then

	if(reset = '1') then
             fsm_state <= rst;
        else
             fsm_state <= next_state;
	     done <= output_var;
	     	    
        end if;
	
     end if;
   end process;
end Mega2;



