----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.08.2022 22:11:36
-- Design Name: 
-- Module Name: branch_gen - Behavioral
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

entity branch_gen is
    Port ( I_PC : in STD_LOGIC_VECTOR (31 downto 0);
           I_BComp : in STD_LOGIC_VECTOR (2 downto 0);
           I_BEQ : in STD_LOGIC;
           I_BNE : in STD_LOGIC;
           I_BLT : in STD_LOGIC;
           I_BGE : in STD_LOGIC;
           I_BLTU : in STD_LOGIC;
           I_BGEU : in STD_LOGIC;
           I_imm : in STD_LOGIC_VECTOR (31 downto 0);
           O_BTarg : out STD_LOGIC_VECTOR (31 downto 0));
end branch_gen;

architecture Behavioral of branch_gen is

signal BTarg: std_logic_vector(31 downto 0);

begin

    process(I_BComp, I_BEQ, I_BNE, I_BLT, I_BLTU, I_BGE, I_BGEU, I_PC, I_imm, BTarg)
    begin
    
        BTarg <= std_logic_vector(signed(I_PC)+ signed(I_imm));
    
        if I_BEQ ='1' and I_BComp = "000" then
            
            O_BTarg <= BTarg;
            
        elsif I_BNE = '1' and I_BComp = "001" then
            
            O_BTarg <= BTarg;
        
        elsif I_BLT = '1' and I_BComp = "100" then
            
            O_BTarg <= BTarg;
        
        elsif I_BGE = '1' and I_BComp = "101" then
            
            O_BTarg <= BTarg;
        
        elsif I_BLTU = '1' and I_BComp = "110" then
            
            O_BTarg <= BTarg;
        
        elsif I_BGEU = '1' and I_BComp = "111" then
            
            O_BTarg <= BTarg;
        
        else O_BTarg <= std_logic_vector(unsigned(I_PC) + 1);
            
        end if;
        
    end process;
    
end Behavioral;
