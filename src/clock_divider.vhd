----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.09.2022 22:30:24
-- Design Name: 
-- Module Name: clock_divider - Behavioral
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

entity clock_divider is
    Port ( I_clk : in STD_LOGIC;
           O_clk : out STD_LOGIC);
end clock_divider;

architecture Behavioral of clock_divider is

    signal scaler : std_logic_vector(23 downto 0) := (others => '0');

begin

process(I_clk)
  begin
    if rising_edge(I_clk) then   -- rising clock edge
        scaler <= std_logic_vector( unsigned(scaler) + 1);
    end if;
  end process;

O_clk <= scaler(16);

end Behavioral;
