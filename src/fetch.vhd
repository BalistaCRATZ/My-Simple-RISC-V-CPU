----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.08.2022 01:13:12
-- Design Name: 
-- Module Name: fetch - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fetch is
    Port ( I_clk : in STD_LOGIC;
           I_PCSel : in STD_LOGIC_VECTOR (1 downto 0);
           I_Br : in STD_LOGIC_VECTOR (31 downto 0);
           I_JAL : in STD_LOGIC_VECTOR (31 downto 0);
           I_JALR : in STD_LOGIC_VECTOR (31 downto 0);
           O_ins : out STD_LOGIC_VECTOR (31 downto 0));
end fetch;

architecture Behavioral of fetch is

signal PC : std_logic_vector(31 downto 0);

begin

    update_pc : process(I_clk)
    begin
        
        if rising_edge(I_clk) then
        
            case I_PCSel is
            
                when "00" => PC <= std_logic_vector(unsigned(PC) + 4);
            
                when "01" => PC <= I_Br;
                
                when "10" => PC <= I_JAL;
               
                when "11" => PC <= I_JALR;
            
            end case;
        end if;
           
    end process;
    
    Instruction_Memory : entity work.instruction_memory 
    port map (I_clk => I_clk,
              I_address => PC,
              O_ins => O_ins);


end Behavioral;
