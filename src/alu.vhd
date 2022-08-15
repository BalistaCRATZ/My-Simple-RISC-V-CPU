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
    Port (I_dataA : in std_logic_vector (31 downto 0);
           I_dataB : in std_logic_vector (31 downto 0);
           I_alufunc : in std_logic_vector (3 downto 0);
           O_result : out std_logic_vector (31 downto 0);
           O_zero : out std_logic);
           
           
end alu;

architecture Behavioral of alu is

begin

    process (I_dataA, I_dataB, I_alufunc)
    
    begin
        
            
            case I_alufunc is
                
                when "0000" => O_result <= I_dataA and I_dataB;  --Bitwise and 
                
                when "0001" => O_result <= I_dataA or I_dataB;  --Bitwise or
  
                when "1100" => O_result <= I_dataA xor I_dataB;  --Bitwise xor
         
                when "0010" => O_result <= std_logic_vector(signed(I_dataA) + signed(I_dataB));  --Addition

                when "0110" => O_result <= std_logic_vector(signed(I_dataA) - signed(I_dataB));  --Subtraction

                when "0111" => --SLT
                    
                    if signed(I_dataB) > signed(I_dataA) then
                        
                        O_result <= X"00000001";
                        
                    else
                    
                        O_result <= X"00000000";
                     
                    end if;
            
                when "1111" => --SLTU
                       
                       if unsigned(I_dataB) > unsigned(I_dataA) then
                            
                            O_result <= X"00000001";
                            
                        else
                        
                            O_result <= X"00000000";
                            
                        end if;
                    
                when "1000" => --LUI

                     O_result <= I_dataA;
                

                when others => null;
              
            end case;
    
    end process;
    
end Behavioral;
