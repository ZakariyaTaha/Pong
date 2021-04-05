architecture rtl of score is
signal condition_user,condition_sys, s_over: std_logic;
signal s_current_user, s_current_sys, s_next_user, s_next_sys : unsigned(3 downto 0);
begin
over <= s_over;
condition_user <= '1' when (x_pos(0) = '1' and enable = '1' and s_over = '0') else '0';
condition_sys <= '1' when (x_pos(11) = '1' and enable = '1' and s_over = '0')  else '0' ;
s_next_user <= s_current_user + 1 when condition_user = '1' else s_current_user;
s_next_sys <= s_current_sys + 1 when condition_sys = '1' else s_current_sys;
s_over <= '1' when s_current_user = to_unsigned(9,4) or s_current_sys = to_unsigned(9,4) else '0';

dff : process(clock,reset) is
begin
if(reset = '1') then
   s_current_user <= to_unsigned(0,4);
   s_current_sys <= to_unsigned(0,4);
    elsif(rising_edge(clock)) then
      s_current_sys <= s_next_sys;
      s_current_user <= s_next_user;	
end if;
end process dff;

with s_current_user select user <=
"11111100" when to_unsigned(0,4) ,
"01100000" when to_unsigned(1,4) ,
"11011010" when to_unsigned(2,4) ,
"11110010" when to_unsigned(3,4) ,
"01100110" when to_unsigned(4,4) ,
"10110110" when to_unsigned(5,4) ,
"10111110" when to_unsigned(6,4) ,
"11100000" when to_unsigned(7,4) ,
"11111110" when to_unsigned(8,4)  ,
"11110110" when to_unsigned(9,4) ,
"11111111" when others ;

with s_current_sys select sys <=
"11111100" when to_unsigned(0,4) ,
"01100000" when to_unsigned(1,4) ,
"11011010" when to_unsigned(2,4) ,
"11110010" when to_unsigned(3,4) ,
"01100110" when to_unsigned(4,4) ,
"10110110" when to_unsigned(5,4) ,
"10111110" when to_unsigned(6,4) ,
"11100000" when to_unsigned(7,4) ,
"11111110" when to_unsigned(8,4)  ,
"11110110" when to_unsigned(9,4) ,
"11111111" when others ;
	
end architecture rtl;
