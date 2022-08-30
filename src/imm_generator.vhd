----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.08.2022 19:49:18
-- Design Name: 
-- Module Name: imm_generator - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity imm_generator is
    Port ( I_ins : in STD_LOGIC_VECTOR (31 downto 0);
           O_imm : out STD_LOGIC_VECTOR (31 downto 0));
end imm_generator;

architecture Behavioral of imm_generator is

    --Defining the opcodes for the different types of immediate representations 

    constant I_TYPE_AL : STD_LOGIC_VECTOR (6 downto 0) := "0010011";
    constant I_TYPE_LOAD : STD_LOGIC_VECTOR (6 downto 0) := "0000011";
    constant I_type_JALR : STD_LOGIC_VECTOR (6 downto 0) := "1100111";
    constant U_TYPE_LUI : STD_LOGIC_VECTOR (6 downto 0) := "0110111";
    constant U_TYPE_AUIPC : STD_LOGIC_VECTOR (6 downto 0) := "0010111";
    constant S_TYPE : STD_LOGIC_VECTOR (6 downto 0) := "0100011";
    constant B_TYPE : STD_LOGIC_VECTOR (6 downto 0) := "1100011"; 
    constant J_TYPE : STD_LOGIC_VECTOR (6 downto 0) := "1101111";
    
    constant SLLI_FUNCT3 : STD_LOGIC_VECTOR(2 downto 0)  := "001";
    constant SRLI_FUNCT3 : STD_LOGIC_VECTOR(2 downto 0)  := "101";
    constant SRAI_FUNCT3 : STD_LOGIC_VECTOR(2 downto 0)  := "101";

begin

process(I_ins)

begin
    
    --Picking the correct immediate format based on instruction opcode
    
    case I_ins(6 downto 0) is
        
        when I_TYPE_AL | I_TYPE_LOAD | I_TYPE_JALR =>
            
            O_imm <= (31 downto 12 => I_ins(31)) & I_ins(31 downto 20);
        
        when U_TYPE_LUI | U_TYPE_AUIPC =>
            
            O_imm <= I_ins(31 downto 12) & (11 downto 0 => '0');
        
        when S_TYPE =>
            
            O_imm <= (31 downto 12 => I_ins(31)) & I_ins(31 downto 25) & I_ins(11 downto 7);
        
        when B_TYPE =>
            
            O_imm <= (31 downto 12 => I_ins(31)) & I_ins(7) & I_ins(30 downto 25) & I_ins(11 downto 8) & '0';
            
        when J_TYPE =>
            
            O_imm <= (31 downto 20 => I_ins(31)) & I_ins(19 downto 12) & I_ins(20) & I_ins(30 downto 21) & '0'; --B and J-type immediates are left shifted 1 bit by concatenating a 0 at the end
            
        when others => null;
            
     end case;
    
end process;



end Behavioral;
