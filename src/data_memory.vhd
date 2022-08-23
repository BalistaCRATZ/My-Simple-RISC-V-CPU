----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.08.2022 19:58:54
-- Design Name: 
-- Module Name: data_memory - Behavioral
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

entity data_memory is
    Port ( I_clk : in STD_LOGIC;
           I_MemWrite : in STD_LOGIC;
           I_MemRead : in STD_LOGIC;
           I_Address : in STD_LOGIC_VECTOR (31 downto 0);
           I_WriteData : in STD_LOGIC_VECTOR (31 downto 0);
           O_ReadData : out STD_LOGIC_VECTOR (31 downto 0));
end data_memory;

architecture Behavioral of data_memory is

signal address : std_logic_vector(6 downto 0);
type memory is array(0 to 127) of std_logic_vector(31 downto 0);
signal RAM : memory := (others=> (others=>'0'));

begin

    address <= I_Address(6 downto 0); --We take the first 7 bits of the memory address, since we only have 128 words of memory (for now)
    
    update_memory: process(I_clk)
    begin
        
        if rising_edge(I_clk) then
        
            if I_MemRead = '1' and I_address < x"00000080" then

                O_ReadData <= RAM(to_integer(unsigned(address))); --Currently only loading full words from memory
            
            elsif I_MemWrite = '1' and I_address < x"00000080" then
                
                RAM(to_integer(unsigned(address))) <= I_WriteData;
           
            else RAM(to_integer(unsigned(address))) <= X"00000000";
                
            end if;
            
        end if;
        
    end process;

end Behavioral;
