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
           I_MemControl : in STD_LOGIC_VECTOR(2 downto 0);
           O_ReadData : out STD_LOGIC_VECTOR (31 downto 0));
end data_memory;

architecture Behavioral of data_memory is

signal address : std_logic_vector(7 downto 0);
type memory is array(0 to 511) of std_logic_vector(7 downto 0); --512 bytes of memory
signal RAM : memory := (x"00", x"08", x"00", x"01", others=> x"00");

constant MEM_ACCESS_WORD : std_logic_vector(1 downto 0) := "00";
constant MEM_ACCESS_HALFWORD : std_logic_vector(1 downto 0) := "01";
constant MEM_ACCESS_BYTE : std_logic_vector(1 downto 0) := "10";

begin

    address <= I_Address(7 downto 0); --We have 512 bytes, so we need 8 bits of the address to index these
    
    update_memory: process(I_clk, address, I_address, I_MemRead, I_MemWrite, I_MemControl)
    begin
            
           if rising_edge(I_clk) then
                       
                if I_MemWrite = '1' and I_address < x"00000200" then
                    
                    --if rising_edge(I_clk) then
                    
                        case I_MemControl is
                        
                            when "010" => 
                                
                                RAM(to_integer(unsigned(address))) <= I_WriteData(31 downto 24);
                                RAM(to_integer(unsigned(address) + 1)) <= I_WriteData(23 downto 16);
                                RAM(to_integer(unsigned(address) + 2)) <= I_WriteData(15 downto 8);
                                RAM(to_integer(unsigned(address) + 3)) <= I_WriteData(7 downto 0);
                                
                                
                            when "001" => 
                            
                                RAM(to_integer(unsigned(address))) <= I_WriteData(15 downto 8);
                                RAM(to_integer(unsigned(address) + 1)) <= I_WriteData(7 downto 0);
                            
                            when "000" => RAM(to_integer(unsigned(address))) <= I_WriteData(7 downto 0);
                            when others => O_ReadData <= x"00000000";
                            
                        end case;
           
                
                end if;
                
            end if;
            
            if I_MemRead = '1' and I_address < x"00000200" then
            
                case I_MemControl is
                
                    when "010" => O_ReadData <= RAM(to_integer(unsigned(address))) & RAM(to_integer(unsigned(address) + 1)) & RAM(to_integer(unsigned(address) + 2)) & RAM(to_integer(unsigned(address) + 3)); -- Reading the full word from memory
                    when "001" => O_ReadData <= (31 downto 16 => RAM(to_integer(unsigned(address)))(7)) & RAM(to_integer(unsigned(address))) & RAM(to_integer(unsigned(address) + 1));
                    when "000" => O_ReadData <= (31 downto 8 => RAM(to_integer(unsigned(address)))(7)) & RAM(to_integer(unsigned(address)));
                    when others => O_ReadData <= x"00000000";
                    
                end case;
                
            end if;
        
    end process;

end Behavioral;
