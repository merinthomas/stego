library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Input is
	port (CLK: in STD_LOGIC;
			RST: in STD_LOGIC;
			in1: out STD_LOGIC_VECTOR (7 downto 0));
end Input;

architecture Behavioral of Input is
component RAM IS
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END component;
signal addr: STD_LOGIC_VECTOR (5 downto 0) := (others => '0');
begin
	process (CLK)
	begin
		if (RST = '1') then addr <= (others => '0');
		else
			if (clk'event and clk = '1') then
				addr <= addr + '1';
			end if;
		end if;
	end process;
	
	g: RAM port map (CLK, "0", addr, "00000000", in1);

end Behavioral;
