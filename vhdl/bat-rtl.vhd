architecture rtl of bat is
signal s_current_bat, s_next_bat : std_logic_vector(8 downto 0);
begin
bat_o <= s_current_bat;
s_next_bat <= (s_current_bat(7 downto 0) & '0') when (button_up = '1' and enable = '1' and button_down /= '1' and s_current_bat /= "111000000") 
               else ('0' & s_current_bat(8 downto 1)) when (button_down = '1' and enable = '1' and button_up /= '1' and s_current_bat /= "000000111") else s_current_bat;

dff : process(clock, reset) is
begin
if (rising_edge(clock)) then
    if(reset = '1') then s_current_bat <= "000111000";
    else s_current_bat <= s_next_bat;
    end if;
end if;
end process dff;

end architecture rtl;
