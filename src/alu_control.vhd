----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.08.2022 22:06:48
-- Design Name: 
-- Module Name: imm_gen - Behavioral
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

entity alu_control is
    Port (I_AluOp : in STD_LOGIC_VECTOR (2 downto 0);
           I_funct : in STD_LOGIC_VECTOR (3 downto 0);
           O_AluFunc : out STD_LOGIC_VECTOR (3 downto 0));
           
end alu_control;

architecture Behavioral of alu_control is

begin

    process(I_AluOp, I_funct)
    
    begin
       
            case I_AluOp is
                
                when "000" => O_AluFunc <= "0010"; --For Load/Store instructions
                  
                when "001" => O_AluFunc <= "0110"; --For beq instruction
                
                when "011" => --Decided from funct3 bits only (all I-type except shifts)
                
                    case I_funct(2 downto 0) is
                        
                        when "000" => O_AluFunc <= "0010"; --ADDI
                        when "111" => O_AluFunc <= "0000"; --ANDI
                        when "100" => O_AluFunc <= "1100"; --XORI
                        when "110" => O_AluFunc <= "0001"; --ORI
                        when "010" => O_AluFunc <= "0111"; --SLTI
                        when "011" => O_AluFunc <= "1111"; --SLTIU
                        when others => O_AluFunc <= "1111"; -- until exceptions introduced
                        
                   end case;  
               
               when "010" => --Decided from funct7 (bit 30) and funct3 bits (all R-type except shifts)
                    
                    case I_funct is
                        
                        when "0000" => O_AluFunc <= "0010"; --ADD
                        when "1000" => O_AluFunc <= "0110"; --SUB
                        when "0111" => O_AluFunc <= "0000"; --AND
                        when "0100" => O_AluFunc <= "1100"; --XOR
                        when "0110" => O_AluFunc <= "0001"; --OR
                        when "0010" => O_AluFunc <= "0111"; --SLT
                        when "0011" => O_AluFunc <= "1111"; --SLTU
                        when others => O_AluFunc <= "1111";
    
                   end case;  
             
              when "100" => O_AluFunc <= "0001"; --LUI
              
             when others => O_ALUFunc <= "0000";

            end case;
    
    end process;

end Behavioral;
