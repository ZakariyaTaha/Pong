architecture rtl of movement is
SIGNAL s_next_pos,s_current_pos : std_logic_vector(WIDTH-1 downto 0);
begin
pos <= s_current_pos;

transition : PROCESS(enable,dir,s_current_pos) IS
begin
if (enable = '0') then s_next_pos <= s_current_pos;
   elsif(s_current_pos(0) = '1' and (dir = '0' or enable = '0')) then s_next_pos <= s_current_pos;
   elsif(s_current_pos(WIDTH-1) = '1' and(enable = '0' or dir = '1')) then s_next_pos <= s_current_pos;
   elsif(dir = '1' and enable = '1' ) then s_next_pos <= s_current_pos(WIDTH-2 downto 0) & '0';
   elsif(dir = '0' and enable = '1' ) then s_next_pos <= '0' & s_current_pos(WIDTH-1 downto 1);
end if;
end PROCESS transition;

dff : PROCESS(clock) IS
begin
if(rising_edge(clock)) then
   if (reset = '1') then s_current_pos <= INIT;
   else s_current_pos <= s_next_pos;
   end if;
	
end if;
end  PROCESS dff;


end architecture rtl;
