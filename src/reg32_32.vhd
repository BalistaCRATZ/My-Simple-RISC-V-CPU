----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.07.2022 13:21:50
-- Design Name: 
-- Module Name: reg32_32 - Behavioral
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

entity reg32_32 is
    Port ( I_clk : in STD_LOGIC;
           I_dataC : in STD_LOGIC_VECTOR (31 downto 0);
           O_dataA : out STD_LOGIC_VECTOR (31 downto 0);
           O_dataB: out STD_LOGIC_VECTOR (31 downto 0);
           I_selA : in STD_LOGIC_VECTOR (4 downto 0);
           I_selB : in STD_LOGIC_VECTOR (4 downto 0);
           I_selC : in STD_LOGIC_VECTOR (4 downto 0);
           I_writen : in STD_LOGIC);
          
end reg32_32;

architecture Behavioral of reg32_32 is
    --Defining the register as an array of 32 'blocks' that each stores 32-bit data
    type registers is array (0 to 31) of std_logic_vector (31 downto 0);
    signal regs : registers := (x"00000000",
                                others => X"00000000");

begin
    
    process(I_clk)
    begin
            
        if rising_edge(I_clk) then
            --If write enable is high, write data to register C as well 
            if I_writen = '1' then
                regs(to_integer(unsigned(I_selC))) <= I_dataC;
            end if;
                
        end if;
        
   end process;
   
   O_dataA <= regs(to_integer(unsigned(I_selA)));
   O_dataB <= regs(to_integer(unsigned(I_selB)));

end Behavioral;
