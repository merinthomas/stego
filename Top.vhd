library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Top is
	port (CLK: in STD_LOGIC;
	      RST: in STD_LOGIC;
			dct_2d_embed: out STD_LOGIC_VECTOR (11 downto 0);
			rdy_out: out STD_LOGIC);
end Top;

architecture Behavioral of Top is
	
	component Input is
		port (CLK: in STD_LOGIC;
				RST: in STD_LOGIC;
				in1: out STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	component dct IS 
		PORT ( 
			CLK                     : IN std_logic;    
			RST                      : IN std_logic; --active in high value  
			xin               	: IN std_logic_vector(7 downto 0); --8 bit input,it'll scan 8 bits of 1st column,then  --8 bits of 2nd column......until finished the --scanning of 8 bits in 8th column, this finished --the scanning of 8X8 image block 
			dct_2d                  : OUT std_logic_vector(11 downto 0); --output of 2D-DCT 
			rdy_out                 : OUT std_logic); --output valid, active in high logic 
	END component;
	
	component Embed is
		port (CLK: in STD_LOGIC;
				RST: in STD_LOGIC;
				rdy_in: in STD_LOGIC;
				din: in STD_LOGIC_VECTOR (11 downto 0);
				dout: out STD_LOGIC_VECTOR (11 downto 0);
				rdy_out: out STD_LOGIC);
	end component;
	
	signal input_inter: STD_LOGIC_VECTOR (7 downto 0);
	signal rdy_inter: STD_LOGIC;
	signal dct2d_inter: STD_LOGIC_VECTOR (11 downto 0);

begin
	
	a: Input port map (CLK, RST, input_inter);
	b: dct port map (CLK, RST, input_inter, dct2d_inter, rdy_inter);
	c: Embed port map (CLK, RST, rdy_inter, dct2d_inter, dct_2d_embed, rdy_out);
	
end Behavioral;
