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
           O_ins : out STD_LOGIC_VECTOR (31 downto 0);
           O_PC : out std_logic_vector(31 downto 0);
           O_nextPC: out std_logic_vector(31 downto 0));
end fetch;

architecture Behavioral of fetch is

signal PC_buffer : std_logic_vector(31 downto 0):= x"00000000";
signal nextPC_buffer : std_logic_vector(31 downto 0);

begin
    
    nextPC_buffer <= std_logic_vector(unsigned(PC_buffer) + 1); -- Not adding byte addressing yet

    update_pc : process(I_clk, PC_buffer)
    begin
        
        if rising_edge(I_clk) then
        
            case I_PCSel is
            
                when "00" => PC_buffer <= nextPC_buffer;
            
                when "01" => PC_buffer <= I_Br;
                
                when "10" => PC_buffer <= I_JAL;
               
                when "11" => PC_buffer <= I_JALR;
                
                when others => null;
            
            end case;
            
        end if;
           
    end process;
    
    O_nextPC <= nextPC_buffer;
    O_PC <= PC_buffer;
    
    
    Instruction_Memory : entity work.instruction_memory 
    port map (I_clk => I_clk,
              I_address => PC_buffer,
              O_ins => O_ins);


end Behavioral;
