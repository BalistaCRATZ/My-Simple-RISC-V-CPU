----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.08.2022 02:01:29
-- Design Name: 
-- Module Name: comparator - Behavioral
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

entity comparator is
    Port ( I_rs1 : in STD_LOGIC_VECTOR (31 downto 0);
           I_rs2 : in STD_LOGIC_VECTOR (31 downto 0);
           O_BEQ : out STD_LOGIC;
           O_BNE : out STD_LOGIC;
           O_BLT : out STD_LOGIC;
           O_BLTU : out STD_LOGIC;
           O_BGE : out STD_LOGIC;
           O_BGEU : out STD_LOGIC);
end comparator;

architecture Behavioral of comparator is

begin
   
    process(I_rs1, I_rs2)
    begin
    
        with I_rs1 = I_rs2 select
            O_BEQ <= '1' when true,
                     '0' when others;
        with I_rs1 /= I_rs2 select
            O_BNE <= '1' when true,
                     '0' when others;
        with signed(I_rs1) < signed(I_rs2) select
            O_BLT <= '1' when true,
                     '0' when others;  
        with signed(I_rs1) >= signed(I_rs2) select
            O_BGE <= '1' when true,
                     '0' when others;
        with unsigned(I_rs1) < unsigned(I_rs2) select
            O_BLTU <= '1' when true,
                     '0' when others;  
        with unsigned(I_rs1) >= unsigned(I_rs2) select
            O_BGEU <= '1' when true,
                     '0' when others;

    end process;

end Behavioral;
