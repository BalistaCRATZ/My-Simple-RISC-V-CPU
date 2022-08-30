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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity comparator is
    Port ( I_rs1 : in STD_LOGIC_VECTOR (31 downto 0);
           I_rs2 : in STD_LOGIC_VECTOR (31 downto 0);
           O_BEQ : in STD_LOGIC;
           O_BNE : in STD_LOGIC;
           O_BLT : in STD_LOGIC;
           O_BLTU : in STD_LOGIC;
           O_BGE : in STD_LOGIC;
           O_BGEU : in STD_LOGIC);
end comparator;

architecture Behavioral of comparator is

begin


end Behavioral;
