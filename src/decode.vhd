----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.08.2022 11:05:19
-- Design Name: 
-- Module Name: decode - Behavioral
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

entity decode is
    Port ( I_clk : in std_logic;
           I_ins : in STD_LOGIC_VECTOR (31 downto 0);
           I_rddata : in STD_LOGIC_VECTOR(31 downto 0);
           O_imm : out STD_LOGIC_VECTOR (31 downto 0);
           O_rs1 : out STD_LOGIC_VECTOR (31 downto 0);
           O_rs2 : out STD_LOGIC_VECTOR (31 downto 0);
           O_PCSel : out STD_LOGIC_VECTOR (1 downto 0);
           O_ALUFunc : out std_logic_vector(3 downto 0);
           O_ALUSrcImm : out STD_LOGIC;
           O_ALUSrcPC : out STD_LOGIC;
           O_MemWrite : out STD_LOGIC;
           O_MemRead : out STD_LOGIC;
           O_WBSel : out STD_LOGIC_VECTOR (1 downto 0));

end decode;

architecture Behavioral of decode is

signal ALUOp : std_logic_vector(2 downto 0); -- Internal signal generated by control unit (stays within decode unit)
signal funct : std_logic_vector(3 downto 0);

signal RegWrite : std_logic;

signal reg_1_sel : std_logic_vector(4 downto 0);
signal reg_2_sel : std_logic_vector(4 downto 0);
signal reg_d_sel : std_logic_vector(4 downto 0);

begin

   regfile: entity work.reg32_32
   port map(I_clk => I_clk,
            I_writen => RegWrite,
            I_selA => reg_1_sel,
            I_selB => reg_2_sel,
            I_selC => reg_d_sel,
            I_dataC => I_rddata,
            O_dataA => O_rs1,
            O_dataB => O_rs2
            ); 
            
   --Updating regfile selects
   reg_1_sel <= I_ins(19 downto 15);
   reg_2_sel <= I_ins(24 downto 20);
   reg_d_sel <= I_ins(11 downto 7);

   control_unit: entity work.control_unit 
   port map(I_ins => I_ins,
             O_ALUOp => ALUOp,
             O_ALUSrcImm => O_ALUSrcImm,
             O_ALUSrcPC => O_ALUSrcPC,
             O_PCSel => O_PCSel,
             O_MemWrite => O_MemWrite, 
             O_MemRead => O_MemRead,
             O_RegWrite => RegWrite,
             O_WBSel => O_WBSel);
    
    update_funct: process(I_ins)
    begin
        funct <= I_ins(30) & I_ins(14 downto 12);
    end process;

    alu_control: entity work.alu_control
    port map(I_AluOp => ALUOp,
             I_funct => funct,
             O_AluFunc => O_ALUFunc);
             
    imm_generator: entity work.imm_generator 
    port map(I_ins => I_ins,
             O_imm => O_imm);
    

end Behavioral;