----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.08.2022 20:44:00
-- Design Name: 
-- Module Name: instruction_memory - Behavioral
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

entity instruction_memory is
    Port ( I_clk : in STD_LOGIC;
           I_address : in STD_LOGIC_VECTOR (31 downto 0);
           O_ins : out STD_LOGIC_VECTOR (31 downto 0));

end instruction_memory;

architecture Behavioral of instruction_memory is

signal address : std_logic_vector(6 downto 0);
type rom_t is array(0 to 127) of std_logic_vector(31 downto 0);

signal ROM : rom_t := ("00000000000000000010000010000011", 
                       "00000000000100000000000100000011", 
                       "00000000001000001000000110110011", 
                       "00000000001100000010001000100011", 
                        others => x"00000000");

begin
    
    address <= I_address(6 downto 0);
    
    fetch_instruction: process(I_address, address)
    begin
            
            if I_address < x"00000080" then
                
                O_ins <= ROM(to_integer(unsigned(address)));
                
            else O_ins <= X"00000000"; --Eventually we want it to throw an exception
            
            end if;    
    
    end process;

end Behavioral;
