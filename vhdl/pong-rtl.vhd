architecture rtl of pong is

component movement_full is 
generic(WIDTH : natural := 9;
        INIT  : std_logic_vector);
port(ext_change : in std_logic;
     enable     : in std_logic;
     reset      : in std_logic;
     clock      : in std_logic;
     pos        : out std_logic_vector(WIDTH - 1 downto 0);
     dir_o      : out std_logic);
end component;
component direction is 
port(change : in std_logic;
     enable : in std_logic;
     reset  : in std_logic;
     clock  : in std_logic;
     dir    : out std_logic);
end component;
component bat is 
port(button_up   : in std_logic;
     button_down : in std_logic;
     enable      : in std_logic;
     reset       : in std_logic;
     clock       : in std_logic;
     bat_o       : out std_logic_vector(8 downto 0));
end component;
component debouncer is 
port(button   : in std_logic;
     enable   : in std_logic;
     reset    : in std_logic;
     clock    : in std_logic;
     button_o : out std_logic);
end component;
component collision is 
port(x_dir   : in std_logic;
     y_dir   : in std_logic;
     x_pos   : in std_logic_vector(11 downto 0);
     y_pos   : in std_logic_vector(8 downto 0);
     bat_pos : in std_logic_vector(8 downto 0);
     change  : out std_logic);
end component;
component score is 
port(x_pos  : in std_logic_vector(11 downto 0);
     enable : in std_logic;
     reset  : in std_logic;
     clock  : in std_logic;
     user   : out std_logic_vector(7 downto 0);
     sys    : out std_logic_vector(7 downto 0);
     over   : out std_logic);
end component;
component clock_divider is 
   PORT ( clock   : IN  std_logic;
          reset   : IN  std_logic;
          enable  : OUT std_logic );
end component;

signal activeLow_reset, activeLow_up, activeLow_down : std_logic;
signal s_xDir, s_yDir, s_change, s_enable, s_buttonUp , s_buttonDown: std_logic;
signal s_baton : std_logic_vector(8 downto 0);
signal s_x : std_logic_vector(11 downto 0);
signal s_y : std_logic_vector(8 downto 0);

begin

display : FOR y IN 8 DOWNTO 0 GENERATE
oneline : FOR x IN 11 DOWNTO 0 GENERATE
bat_gen : if(x=10) generate  playfield(y*12+x) <= ((s_y(y) and s_x(x)) or s_baton(y));
end generate bat_gen;
normal_gen : if(x /= 10) generate playfield(y*12+x) <= s_y(y) and s_x(x);
end generate normal_gen;
END GENERATE oneline;
END GENERATE display;

activeLow_down <= not n_button_down;
activeLow_up <= not n_button_up;
activeLow_reset <= not n_reset;


movement_y : movement_full
generic map(WIDTH => 9,
	INIT => "000010000")
port map( ext_change => '0',
     enable     => s_enable,
     reset      => activeLow_reset,
     clock      => clock,
     pos       => s_y,
     dir_o      => s_yDir
     );
	
movement_x : movement_full
generic map(WIDTH => 12,
	INIT => "000000100000")
port map( ext_change => s_change,
     enable     => s_enable,
     reset      => activeLow_reset,
     clock      => clock,
     pos       => s_x,
     dir_o      => s_xDir
     );

clock_div : clock_divider
port map(clock   => clock,
          reset   => activeLow_reset,
          enable  => s_enable
          );

debouncer_up : debouncer
port map(button  => activeLow_up,
     enable   => s_enable,
     reset    => activeLow_reset,
     clock    => clock,
     button_o => s_buttonUp
     );


debouncer_down : debouncer
port map(button  => activeLow_down,
     enable   => s_enable,
     reset    => activeLow_reset,
     clock    => clock,
     button_o => s_buttonDown
     );


baton : bat
port map(button_up   => s_buttonUp,
     button_down => s_buttonDown,
     enable     => s_enable,
     reset       => activeLow_reset,
     clock       => clock,
     bat_o       => s_baton
     );

c_collision : collision
port map(x_dir   => s_xDir,
     y_dir   => s_yDir,
     x_pos   => s_x,
     y_pos   => s_y,
     bat_pos => s_baton,
     change  => s_change
     );

c_score : score
port map(x_pos  => s_x,
     enable => s_enable,
     reset  => activeLow_reset,
     clock  => clock,
     user   => user,
     sys    => sys,
     over   => open
	 );


end architecture rtl; 
