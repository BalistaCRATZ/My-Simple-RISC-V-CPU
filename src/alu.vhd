----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.08.2022 18:58:00
-- Design Name: 
-- Module Name: alu - Behavioral
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

entity alu is
    Port ( I_imm : in STD_LOGIC_VECTOR (11 downto 0);
           I_aluop : in STD_LOGIC_VECTOR (16 downto 0); --MIGHT NOT WORK, TEMPORARY SOLUTION
           I_dataA : in STD_LOGIC_VECTOR (31 downto 0);
           I_dataB : in STD_LOGIC_VECTOR (31 downto 0);
           I_en : in STD_LOGIC;
           I_clk : in STD_LOGIC;
           I_writen : in STD_LOGIC;
           I_pc : in STD_LOGIC_VECTOR (31 downto 0);
           O_out : out STD_LOGIC_VECTOR (31 downto 0);
           O_writen : out STD_LOGIC;
           O_branch : out STD_LOGIC);
end alu;

architecture Behavioral of alu is

signal s_result: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal extended_imm: std_logic_vector(31 downto 0);


begin

extended_imm <= std_logic_vector(resize(signed(I_imm), extended_imm'length)); 

process (I_clk)

begin

    if rising_edge(I_clk) and I_en = '1' then
        
        case I_aluop(6 downto 0) is 
            
            when "0010011" => --I-type instruction, arithmetic/logic
            
                case I_aluop(9 downto 7) is
                
                    when "000" => --ADDI operation
                 
                        s_result(31 downto 0) <= std_logic_vector(signed(I_dataA) + signed(extended_imm));
                        
                   when "100" => --XORI operation    
     
                        s_result(31 downto 0) <= std_logic_vector(signed(I_dataA) xor signed(extended_imm));
                        
                   when "110" => --ORI operation    
               
                        s_result(31 downto 0) <= std_logic_vector(signed(I_dataA) or signed(extended_imm));
                        
                  when "111" => --ANDI operation    

                        s_result(31 downto 0) <= std_logic_vector(signed(I_dataA) and signed(extended_imm));
                        
                  when others => null;
 
               end case;  
            
            when "0000011" => --I-type instruction, loads
                  
                
                   s_result (31 downto 0) <= std_logic_vector(signed(I_dataA) + signed(extended_imm)); --Computing the byte address from where to load data in memory
                    --Might need to make this the same output as the O_out, this can then be accounted for later in the pipeline with control units dictating whether or not the registers are being written to. That way, we have only one datapath active at a time (either we are writing to the registers, or we are sending data to memory for addressing)
                        
       
            when "0110011" => --R-type instruction
                
                case I_aluop(9 downto 7) is 
                    
                    when "000" =>
                        
                        if I_aluop(16 downto 10) = "0000000" then --ADD operation
                            
                            s_result(31 downto 0) <= std_logic_vector(signed(I_dataA) + signed(I_dataB)); --Ignoring overflows

                        else --SUB operation
                            
                            s_result(31 downto 0) <= std_logic_vector(signed(I_dataA) - signed(I_dataB)); --Subtraction defined to be rs1 - rs2   
                             
                        end if;   
                        
                    when "100" => --XOR operation
                        
                        s_result(31 downto 0) <= std_logic_vector(signed(I_dataA) xor signed(I_dataB));
    
                    when "110" => --OR operation
                    
                        s_result(31 downto 0) <= std_logic_vector(signed(I_dataA) or signed(I_dataB));
          
                    when "111" => --AND operation
                        
                        s_result(31 downto 0) <= std_logic_vector(signed(I_dataA) and signed(I_dataB));  
                        
                    when others => null;
                    
                    end case;
            
            when others => null;
                        
        end case;
        
        O_out <= s_result;
        
   end if;
                
end process;


end Behavioral;
