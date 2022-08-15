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
    Port ( I_clk : in STD_LOGIC;
           I_AluOp : in STD_LOGIC_VECTOR (1 downto 0);
           I_funct : in STD_LOGIC_VECTOR (3 downto 0);
           O_AluFunc : out STD_LOGIC_VECTOR (3 downto 0));
end alu_control;

architecture Behavioral of alu_control is

begin

    process(I_clk)
    
    begin
        
        if rising_edge(I_clk) then
        
            case I_AluOp is
                
                when "00" => O_AluFunc <= "0010"; --For Load/Store instructions
                  
                when "01" => O_AluFunc <= "0110"; --For beq instruction
                
                when "10" => --Decided from fucnt bits
                    
                     
                     
                    
            end case;
        end if;
    


end Behavioral;
