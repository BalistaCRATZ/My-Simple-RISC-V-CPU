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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fetch is
    Port ( I_clk : in STD_LOGIC;
           I_PCSel : in STD_LOGIC_VECTOR (1 downto 0);
           I_BrJAL : in STD_LOGIC_VECTOR (31 downto 0);
           I_JALR : in STD_LOGIC_VECTOR (31 downto 0);
           O_ins : in STD_LOGIC_VECTOR (31 downto 0));
end fetch;

architecture Behavioral of fetch is

signal PC : std_logic_vector(31 downto 0);


begin

    update_pc : process(I_clk)
    begin
        
        if rising_edge(I_clk) then
        
            case I_PCSel is
            
                when "01" => PC <= I_BrJAL;
               
                when "11" => PC <= I_JALR;
                
                when "00" => PC <= std_logic_vector(unsigned(PC) + 4);
                
                when others => null;
            
            end case;
        end if;
           
    end process;



end Behavioral;
