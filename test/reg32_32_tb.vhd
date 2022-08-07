----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.07.2022 22:45:27
-- Design Name: 
-- Module Name: reg32_32_tb - Behavioral
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

entity reg32_32_tb is
--  Port ( );
end reg32_32_tb;

architecture Behavioral of reg32_32_tb is

    --Component declaration for UUT (unit under test)
    component reg32_32
       Port ( I_clk : in STD_LOGIC;
              I_en : in STD_LOGIC;
              I_dataC : in STD_LOGIC_VECTOR (31 downto 0);
              O_dataA : out STD_LOGIC_VECTOR (31 downto 0);
              O_dataB: out STD_LOGIC_VECTOR (31 downto 0);
              I_selA : in STD_LOGIC_VECTOR (4 downto 0);
              I_selB : in STD_LOGIC_VECTOR (4 downto 0);
              I_selC : in STD_LOGIC_VECTOR (4 downto 0);
              I_writen : in STD_LOGIC);
   end component;
   
   --Inputs
   signal I_clk : std_logic := '0';
   signal I_en : std_logic  := '0';
   signal I_writen: std_logic := '0';
   signal I_dataC: std_logic_vector (31 downto 0) := (others => '0');
   signal I_selA: std_logic_vector (4 downto 0) := (others => '0');
   signal I_selB: std_logic_vector (4 downto 0) := (others => '0');
   signal I_selC: std_logic_vector (4 downto 0) := (others => '0');
   
   --Outputs
   signal O_dataA: std_logic_vector (31 downto 0);
   signal O_dataB: std_logic_vector (31 downto 0);
   
   --Clock period definition
   constant I_clk_period : time := 10 ns;
  
begin

    uut : reg32_32 PORT MAP (
        I_clk => I_clk,
        I_en => I_en,
        I_dataC => I_dataC,
        O_dataA => O_dataA,
        O_dataB => O_dataB,
        I_selA => I_selA,
        I_selB => I_selB,
        I_selC => I_selC,
        I_writen => I_writen
    );
    
    --Clock process defintions
    I_clk_process : process
    begin
        I_clk <= '0';
        wait for I_clk_period/2;
        I_clk <= '1';
        wait for I_clk_period/2;
   end process;
   
   --Stimulus process
   stim_proc : process
   begin
       wait for 100ns;
       wait for I_clk_period*10;
       
       --Stimuli
        
        I_en <= '1';
        
        --Testing that the registers can be written to, and output can be read on the same register
        I_selA <= "00000";
        I_selB <= "00001";
        I_selC <= "00000";
        I_dataC <= X"FFFFFFFF"; --Register 0 contains FFFFFFFF
        I_writen <= '1';
        wait for I_clk_period;
        
        --Testing that the same register can be written to again, and the value is updated
        I_selA <= "00000";
        I_selB <= "00001";
        I_selC <= "00000";
        I_dataC <= X"FAB567BB"; --Register 0 now contains FAB567BB
        I_writen <= '1';
        wait for I_clk_period;
        
        --Writing to another register to check later on
        I_selC <= "10010";
        I_writen <= '1';
        I_dataC <= X"AAAAAAAA"; --Register 18 should read AAAAAAAA
        wait for I_clk_period;
        
        --Testing that other registers can be written to, and the data read can be read from it, and the previous value on A is unaffected
        I_selA <= "00000";
        I_selB <= "00010";
        I_selC <= "00010";
        I_dataC <= X"11111111"; --Register 2 contains 11111111
        I_writen <= '1';
        wait for I_clk_period;
        
        --Testing write enable
        I_selA <= "00000";
        I_selB <= "00010";
        I_selC <= "00010";
        I_dataC <= X"FFFFEEEE"; --Register 2 should still contain 11111111
        I_writen <= '0';
        wait for I_clk_period;
        
        --Testing register 18 to see that it reads AAAAAAAA
        I_selA <= "10010";
        wait for I_clk_period;
        
        
        
   end process;        
    
end Behavioral;
