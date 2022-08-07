----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.08.2022 10:13:16
-- Design Name: 
-- Module Name: alu_tb - Behavioral
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

entity alu_tb is
--  Port ( );
end alu_tb;

architecture Behavioral of alu_tb is

    component alu
        Port ( I_imm : in STD_LOGIC_VECTOR (11 downto 0);
           I_aluop : in STD_LOGIC_VECTOR (16 downto 0); --MIGHT NOT WORK, TEMPORARY SOLUTION
           I_dataA : in STD_LOGIC_VECTOR (31 downto 0);
           I_dataB : in STD_LOGIC_VECTOR (31 downto 0);
           I_en : in STD_LOGIC;
           I_clk : in STD_LOGIC;
           I_writen : in STD_LOGIC;
           I_pc : in STD_LOGIC_VECTOR (31 downto 0);
           O_dataC : out STD_LOGIC_VECTOR (31 downto 0);
           O_writen : out STD_LOGIC;
           O_branch : out STD_LOGIC;
           O_extension: out std_logic_vector(31 downto 0));
    end component;
   
   --Inputs
   signal I_imm : std_logic_vector(11 downto 0) := (others => '0');
   signal I_aluop : std_logic_vector(16 downto 0) := (others => '0');
   signal I_dataA : std_logic_vector(31 downto 0) := (others => '0');
   signal I_dataB : std_logic_vector(31 downto 0) := (others => '0');
   signal I_pc : std_logic_vector(31 downto 0) := (others => '0');
   signal I_clk : std_logic := '0';
   signal I_en : std_logic := '0';
   signal I_writen : std_logic := '0';
   
   
   --Outputs
   signal O_dataC : std_logic_vector(31 downto 0) := (others => '0');
   signal O_writen : std_logic := '0';
   signal O_branch : std_logic := '0';
   
   signal O_extension : std_logic_vector(31 downto 0) := (others => '0');
   
   constant I_clk_period : time := 10ns;
   

begin

    uut : alu PORT MAP (
        I_clk => I_clk,
        I_en => I_en,
        I_dataA => I_dataA,
        I_dataB => I_dataB, 
        I_imm => I_imm, 
        I_aluop => I_aluop,
        I_pc => I_pc, 
        I_writen => I_writen, 
        O_dataC => O_dataC, 
        O_branch => O_branch,
        O_writen => O_writen,
        O_extension => O_extension
    );
    
    --Clock process defintions
    I_clk_process : process
    begin
        I_clk <= '0';
        wait for I_clk_period/2;
        I_clk <= '1';
        wait for I_clk_period/2;
   end process;
   
   stim_proc : process
   begin
        wait for 100ns;
        wait for I_clk_period *10;
        
        --Stimuli
        I_en <= '1';
        
        
        --Testing the ADDI instruction
        I_aluop <= "00000000000010011";
        I_dataA <= X"1000000B";
        I_imm <= X"3E8";
        wait for I_clk_period;
        wait for I_clk_period;
        
        --Testing the ORI instruction
        I_aluop <= "00000001100010011";
        wait for I_clk_period;
        
        --Testing the ANDI instruction
        I_aluop <= "00000001110010011";
        wait for I_clk_period;
        
        --Testing the XORI instruction
        I_aluop <= "00000001000010011";
        wait for I_clk_period;
        
        --Testing the ADD instruction
        I_dataB <= X"2111ABCD";
        I_aluop <= "00000000000110011";
        wait for I_clk_period;
        
        --Testing the SUB instruction
        I_aluop <= "01000000000110011";
        wait for I_clk_period;
        
        --Testing SUB the other way around (swapping the data in A and B)
        I_dataA <= X"2111ABCD";
        I_dataB <= X"1000000B";
        wait for I_clk_period;
        
        --Testing the OR instruction
        I_dataA <= X"1000000B";
        I_dataB <= X"2111ABCD";
        I_aluop <= "00000000110110011";
        wait for I_clk_period;
        
        --Testing the AND instruction
        I_aluop <= "00000000111110011";
        wait for I_clk_period;
        
        --Testing the XOR instruction
        I_aluop <= "00000000100110011";
        wait for I_clk_period;
        
        --Testing for overflow
        I_dataA <= X"7FFFFFFF";
        I_imm <= X"001";
        I_aluop <= "00000000000010011";
        wait for I_clk_period;
  end process;
  
end Behavioral;
