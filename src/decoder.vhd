----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.07.2022 11:38:07
-- Design Name: 
-- Module Name: decoder - Behavioral
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

entity decoder is
    Port ( I_clk : in STD_LOGIC;
           I_en : in STD_LOGIC;
           I_ins : in STD_LOGIC_VECTOR (31 downto 0);
           O_alu : out STD_LOGIC_VECTOR (16 downto 0);
           O_writen: out STD_LOGIC;
           O_imm : out STD_LOGIC_VECTOR (19 downto 0); --might need to sign extend this in the decoder itself (to 20 bits)
           O_selA : out STD_LOGIC_VECTOR (4 downto 0);
           O_selB : out STD_LOGIC_VECTOR (4 downto 0);
           O_selC : out STD_LOGIC_VECTOR (4 downto 0));
end decoder;

architecture Behavioral of decoder is

begin
    
    process(I_clk)
    begin

        if rising_edge(I_clk) and I_en = '1' then
            
            case I_ins(6 downto 0) is 
            
                when "0010011" or "0000011" => --I-type instruction
                
                    O_selA <= I_ins(19 downto 15);
                    O_selB <= I_ins(19 downto 15);
                    O_imm <= I_ins(31 downto 20);
                    O_alu <= I_ins(14 downto 12) & I_ins(6 downto 0);
                    O_selC <= I_ins(11 downto 7);
                    O_writen <= '1';
                    
                when "0110011" => --R-type instruction
                
                    O_selA <= I_ins(19 downto 15);
                    O_selB <= I_ins(24 downto 20);
                    O_selC <= I_ins(11 downto 7);
                    O_alu <= I_ins(31 downto 25) & I_ins(14 downto 12) & I_ins(6 downto 0);
                    O_writen <= '1';
                
                when "0110111" or "0010111" => --U-type instruction
                    
                    O_imm <= I_ins(31 downto 12);
                    O_selC <= I_ins(11 downto 7);
                    O_alu <= I_ins(6 downto 0);
                    O_writen <= '1';
                
                when "0100011" => --S-type instruction
                    
                    O_selA <= I_ins(19 downto 15);
                    O_selB <= I_ins(24 downto 20);
                    O_imm <= I_ins(31 downto 25) & I_ins(11 downto 7);
                    O_alu <= I_ins(14 downto 12) & I_ins(6 downto 0);
                
                when others => null;

            end case;
        end if;
   end process;
    

end Behavioral;
