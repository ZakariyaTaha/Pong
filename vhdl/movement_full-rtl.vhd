architecture rtl of movement_full is
Component movement is 
generic(WIDTH : natural := 9;
        INIT  : std_logic_vector);
port(dir    : in std_logic;
     enable : in std_logic;
     reset  : in std_logic;
     clock  : in std_logic;
     pos    : out std_logic_vector(WIDTH - 1 downto 0));
end component;

Component direction is 
port(change : in std_logic;
     enable : in std_logic;
     reset  : in std_logic;
     clock  : in std_logic;
     dir    : out std_logic);
end component;

signal s_pos : std_logic_vector(WIDTH-1 downto 0);
signal s_dir_o, first_changer, second_changer, change_accept : std_logic;

begin
dir_o <= s_dir_o;
pos <= s_pos;
first_changer <= s_dir_o and s_pos(WIDTH-2);
second_changer <= ( not s_dir_o ) and s_pos(1);
change_accept <= first_changer or second_changer or ext_change;

c_direction : direction
port map ( enable => enable,
	reset => reset,
	clock => clock,
	change => change_accept,
	dir => s_dir_o);

c_movement : movement 
generic map ( WIDTH => WIDTH,
             INIT => INIT )
port map(dir => s_dir_o,
	     enable => enable,
	     clock => clock,
	     reset => reset,
	     pos => s_pos 
	     );

   
end architecture rtl;
