----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.07.2022 18:10:24
-- Design Name: 
-- Module Name: ram32 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ram32 is
    Port ( I_clk : in STD_LOGIC;
           I_writen : in STD_LOGIC;
           I_addr : in STD_LOGIC_VECTOR (4 downto 0);
           I_data : in STD_LOGIC_VECTOR (31 downto 0);
           O_data : out STD_LOGIC_VECTOR (31 downto 0));
end ram32;

architecture Behavioral of ram32 is

    type store_t is array (0 to 31) of std_logic_vector (31 downto 0);
    signal ram: store_t := (others => X"00000000");

begin

    process (I_clk)
    begin
        if rising_edge(I_clk) then
            if (I_writen = '1') then
                ram(to_integer(unsigned(I_addr))) <= I_data;
            else
                O_data <= ram(to_integer(unsigned(I_addr))); 
            end if;
       end if;
   end process;

end Behavioral;
