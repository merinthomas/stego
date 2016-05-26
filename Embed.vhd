library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Embed is
	port (CLK: in STD_LOGIC;
			RST: in STD_LOGIC;
			rdy_in: in STD_LOGIC;
			din: in STD_LOGIC_VECTOR (11 downto 0);
			dout: out STD_LOGIC_VECTOR (11 downto 0);
			rdy_out: out STD_LOGIC);
end Embed;

architecture Behavioral of Embed is
	type vect is array (0 to 63) of STD_LOGIC; 
	signal data : vect := ('1','0','0','1','1','1','0','1','0','0','1','0','1','0','1','0','1','0','0','0','1','0','1','1','1','1','1','0','1','0','1','0','1','0','0','0','1','0','1','0','1','0','1','0','0','0','1','0','1','0','1','0','0','1','0','0','0','1','1','0','1','0','0','1');
	signal count: integer range data'range := 0;
begin
	process (CLK)
		variable temp: STD_LOGIC_VECTOR (11 downto 0);
	begin
		if (RST = '1') then
			dout <= (others => '0');
			count <= 0;
			rdy_out <= '0';
		else
			if (CLK'event and CLK = '1') then
				if (rdy_in = '1') then
					rdy_out <= '1';
					if (count <= data'high) then
						temp := din(11 downto 1) & data(count);
					else
						temp := din;
					end if;
				end if;
			end if;
		end if;
		dout <= temp;
	end process;

end Behavioral;
