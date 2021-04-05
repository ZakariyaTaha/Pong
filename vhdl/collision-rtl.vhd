architecture rtl of collision is
signal s_xPosofBat, y_case1, y_case2, y_case3, y_case4, y_case5, y_case6, y_case7, y_case8, y_case9 : std_logic;
signal y_next_pos : std_logic_vector(8 downto 0);
begin
s_xPosofBat <= '1' when (x_dir = '1' and x_pos(9) ='1') or (x_dir = '0' and x_pos(11) = '1') else '0';

y_next_pos <= "100000000" when (y_pos = "100000000" and y_dir = '1') else "000000001" when (y_pos = "000000001" and y_dir = '0') else ('0' & y_pos(8 downto 1)) 
when y_dir = '0' else y_pos(7 downto 0) & '0';

y_case1 <= '1' when (y_next_pos = "000000001" and bat_pos(0) = '1') else '0' ;
y_case2 <= '1' when (y_next_pos = "000000010" and bat_pos(1) = '1') else '0' ;
y_case3 <= '1' when (y_next_pos = "000000100" and bat_pos(2) = '1') else '0' ;
y_case4 <= '1' when (y_next_pos = "000001000" and bat_pos(3) = '1') else '0' ;
y_case5 <= '1' when (y_next_pos = "000010000" and bat_pos(4) = '1') else '0' ;
y_case6 <= '1' when (y_next_pos = "000100000" and bat_pos(5) = '1') else '0' ;
y_case7 <= '1' when (y_next_pos = "001000000" and bat_pos(6) = '1') else '0' ;
y_case8 <= '1' when (y_next_pos = "010000000" and bat_pos(7) = '1') else '0' ;
y_case9 <= '1' when (y_next_pos = "100000000" and bat_pos(8) = '1') else '0' ;

change <= s_xPosofBat and (y_case1 or y_case2 or y_case3 or y_case4 or y_case5 or y_case6 or y_case7 or y_case8 or y_case9);

end architecture rtl;

