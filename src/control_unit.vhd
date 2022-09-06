----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.08.2022 15:51:37
-- Design Name: 
-- Module Name: control_unit - Behavioral
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

entity control_unit is
    Port ( I_ins : in STD_LOGIC_VECTOR (31 downto 0);
           O_ALUOp : out STD_LOGIC_VECTOR (2 downto 0);
           O_ALUSrcImm : out STD_LOGIC;
           O_ALUSrcPC : out STD_LOGIC;
           O_PCSel : out STD_LOGIC_VECTOR (1 downto 0);
           O_RegWrite : out STD_LOGIC;
           O_MemWrite : out STD_LOGIC;
           O_MemRead : out STD_LOGIC;
           O_WBSel : out STD_LOGIC_VECTOR (1 downto 0));

end control_unit;

architecture Behavioral of control_unit is

    --Defining the opcodes for each instruction group
    constant LUI : std_logic_vector(6 downto 0) := "0110111";
    constant AUIPC : std_logic_vector(6 downto 0) := "0010111";
    constant JAL : std_logic_vector(6 downto 0) := "1101111";
    constant JALR: std_logic_vector(6 downto 0) := "1100111";
    constant BR : std_logic_vector(6 downto 0) := "1100011";
    constant LD : std_logic_vector(6 downto 0) := "0000011";
    constant ST : std_logic_vector(6 downto 0) := "0100011";
    constant AL_I : std_logic_vector(6 downto 0) := "0010011";
    constant AL_R : std_logic_vector(6 downto 0) := "0110011";

begin

    output_signals: process(I_ins)
    begin
    
        case I_ins(6 downto 0) is
            
            when LUI => 
                
                O_PCSel <= "00";
                O_ALUOp <= "100";
                O_ALUSrcImm <= '1';
                O_ALUSrcPC <= '1';
                O_MemWrite <= '0';
                O_MemRead <= '0';
                O_RegWrite <= '1';
                O_WBSel <= "01";
           
           when AUIPC =>
               
                O_PCSel <= "00";
                O_ALUOp <= "000";
                O_ALUSrcImm <= '1';
                O_ALUSrcPC <= '1';
                O_MemWrite <= '0';
                O_MemRead <= '0';
                O_RegWrite <= '1';
                O_WBSel <= "01";
                
           when JAL =>   
                
                O_PCSel <= "10";
                O_ALUOp <= "000";
                O_ALUSrcImm <= '0';
                O_ALUSrcPC <= '1';
                O_MemWrite <= '0';
                O_MemRead <= '0';
                O_RegWrite <= '1';
                O_WBSel <= "10";
          
           when JALR =>   
                
                O_PCSel <= "11";
                O_ALUOp <= "000";
                O_ALUSrcImm <= '0';
                O_ALUSrcPC <= '1';
                O_MemWrite <= '0';
                O_MemRead <= '0';
                O_RegWrite <= '1';
                O_WBSel <= "10";
           
           when BR =>
                
                O_PCSel <= "01";
                O_ALUOp <= "001";
                O_ALUSrcImm <= '0';
                O_ALUSrcPC <= '0';
                O_MemWrite <= '0';
                O_MemRead <= '0';
                O_RegWrite <= '0';
                O_WBSel <= "10";
           
           when LD =>
            
                O_PCSel <= "00";
                O_ALUOp <= "000";
                O_ALUSrcImm <= '1';
                O_ALUSrcPC <= '0';
                O_MemWrite <= '0';
                O_MemRead <= '1';
                O_RegWrite <= '1';
                O_WBSel <= "00";
           
           when ST =>
            
                O_PCSel <= "00";
                O_ALUOp <= "000";
                O_ALUSrcImm <= '1';
                O_ALUSrcPC <= '0';
                O_MemWrite <= '1';
                O_MemRead <= '0';
                O_RegWrite <= '0';
                O_WBSel <= "10";
           
           when AL_I =>
            
                O_PCSel <= "00";
                O_ALUOp <= "011";
                O_ALUSrcImm <= '1';
                O_ALUSrcPC <= '0';
                O_MemWrite <= '0';
                O_MemRead <= '0';
                O_RegWrite <= '1';
                O_WBSel <= "01";
          
          when AL_R =>
            
                O_PCSel <= "00";
                O_ALUOp <= "010";
                O_ALUSrcImm <= '0';
                O_ALUSrcPC <= '0';
                O_MemWrite <= '0';
                O_MemRead <= '0';
                O_RegWrite <= '1';
                O_WBSel <= "01";
               
        when others => 
        --Temporary solution until exceptions introduced
                O_PCSel <= "00";
                O_ALUOp <= "010";
                O_ALUSrcImm <= '0';
                O_ALUSrcPC <= '0';
                O_MemWrite <= '0';
                O_MemRead <= '0';
                O_RegWrite <= '1';
                O_WBSel <= "01";     
                
       end case;
    end process;


end Behavioral;
