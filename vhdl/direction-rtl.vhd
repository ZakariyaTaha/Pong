architecture rtl of direction is
signal s_current_dir,s_next_dir : std_logic;
   Begin
   dir <= s_current_dir;

dir_changer : process(change,enable,s_current_dir) is
begin
if(change = '1' and enable = '1') then s_next_dir <= not s_current_dir;
elsif(change = '0' or enable = '0') then s_next_dir <= s_current_dir;
end if;
	
end process dir_changer;

dff : process(clock,reset) is
begin
if(reset = '1') then s_current_dir <= '1';
   elsif(rising_edge(clock)) then s_current_dir <= s_next_dir;
end if;
end process dff;




end architecture rtl;      
