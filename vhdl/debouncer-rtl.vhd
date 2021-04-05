architecture rtl of debouncer is
signal flipflop1,flipflop2,flipflop3,flipflop4,and1,and2,or1,or2,s_button_o : std_logic;
begin
button_o <= s_button_o;
s_button_o <= flipflop4;
and1 <= flipflop2 and not flipflop3;
and2 <= not or2 and or1;
or1 <= s_button_o or and1;
or2 <= enable or reset;
 dff : process(clock) is
 begin
 if(rising_edge(clock)) then 
 flipflop1 <= button;
 flipflop2 <= flipflop1;
 flipflop3 <= flipflop2;
 flipflop4 <= and2;
 	end if;
 end process dff; 

end architecture rtl; 
   
