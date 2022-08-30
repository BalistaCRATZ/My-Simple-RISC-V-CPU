----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.08.2022 22:09:54
-- Design Name: 
-- Module Name: core - Behavioral
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

entity core is
end core;

architecture Behavioral of core is

signal clk : std_logic;

signal instruction : std_logic_vector(31 downto 0);

signal PC : std_logic_vector(31 downto 0);
signal nextPC: std_logic_vector(31 downto 0);

--Branch inputs
signal Br : std_logic_vector(31 downto 0);
signal JAL : std_logic_vector(31 downto 0);
signal JALR : std_logic_vector(31 downto 0);
signal BEQ : std_logic;
signal BNE : std_logic;
signal BLT : std_logic;
signal BGE : std_logic;
signal BLTU : std_logic;
signal BGEU : std_logic;

--Control signals
signal PCSel : std_logic_vector(1 downto 0);
signal ALUFunc : std_logic_vector(3 downto 0);
signal WBSel : std_logic_vector(1 downto 0);
signal ALUSrcImm : std_logic;
signal ALUSrcPC : std_logic;
signal MemWrite : std_logic;
signal MemRead : std_logic;

--ALU Inputs and Outputs
signal generated_immediate : std_logic_vector(31 downto 0);
signal reg_1_val : std_logic_vector(31 downto 0);
signal reg_2_val : std_logic_vector(31 downto 0);
signal AData : std_logic_vector(31 downto 0);
signal BData : std_logic_vector(31 downto 0);
signal ALUout : std_logic_vector(31 downto 0);
signal ALUzero : std_logic;

--Register inputs and outputs
signal reg_write_data : std_logic_vector(31 downto 0);

--Memory inputs and outputs
signal mem_data_out: std_logic_vector(31 downto 0);
signal mem_address : std_logic_vector(31 downto 0);
signal mem_data_in : std_logic_vector(31 downto 0);

constant I_clk_period : time := 10ns;

begin

    fetch: entity work.fetch
    port map(I_clk => clk,
             I_PCSel => PCSel,
             I_Br => Br,
             I_JAL => JAL,
             I_JALR => JALR,
             O_ins => instruction, 
             O_PC => PC,
             O_nextPC => nextPC);
             
             
    decode : entity work.decode
    port map(I_clk => clk,
             I_ins => instruction,
             I_rddata => reg_write_data,
             O_imm => generated_immediate,
             O_rs1 => reg_1_val,
             O_rs2 => reg_2_val,
             O_PCSel => PCSel,
             O_ALUFunc => ALUFunc,
             O_ALUSrcImm => ALUSrcImm,
             O_ALUSrcPC => ALUSrcPC,
             O_MemWrite => MemWrite,
             O_MemRead => MemRead,
             O_WBSel => WBSel
             );
   
   --Jump target address generators
   
   update_jal_address: process
   begin
        JAL <= std_logic_vector(signed(PC) + signed(generated_immediate));
   end process;
   
   update_jalr_address: process
   begin
        JALR <= std_logic_vector(signed(reg_1_val) + signed(generated_immediate));
   end process;
   
   -- Branch target generator
   
   branch_target_gen: entity work.branch_gen
   port map(I_PC => PC,
            I_BComp => instruction(14 downto 12),
            I_BEQ => BEQ,
            I_BNE => BNE,
            I_BLT => BLT,
            I_BGE => BGE,
            I_BLTU => BLTU,
            I_BGEU => BGEU,
            I_imm => generated_immediate,
            O_BTarg => Br);
             
    --ALU source multiplexors
    AData <= reg_2_val when ALUSrcImm = '0' else generated_immediate ;
    BData <= reg_1_val when ALUSrcPC = '0' else PC;


    alu : entity work.alu
    port map(I_dataA => AData,
             I_dataB => BData,
             I_alufunc => ALUFunc,
             O_result => ALUout,
             O_zero => ALUzero);
    
    mem_address <= ALUout;
    mem_data_in <= reg_2_val;
    
    data_memory: entity work.data_memory
    port map(I_clk => clk,
             I_MemWrite => MemWrite,
             I_MemRead => MemRead,
             I_Address => mem_address,
             I_WriteData => mem_data_in,
             O_ReadData => mem_data_out);
                 
    
    --Writeback multiplexor
    with WBSel select
    reg_write_data <= mem_data_out when "00",
                      ALUout when "01",
                      nextPC when "10",
                      x"00000000" when others;
    
    --Clock process defintions
    clk_process : process
    begin
        clk <= '0';
        wait for I_clk_period/2;
        clk <= '1';
        wait for I_clk_period/2;
   end process;


end Behavioral;
