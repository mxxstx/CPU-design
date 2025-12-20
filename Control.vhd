library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Control Unit with BNE and JMP support
entity Control is
    port(
        op        : in  std_logic_vector(3 downto 0);
        alu_op    : out std_logic_vector(1 downto 0);
        alu_src   : out std_logic;
        reg_dest  : out std_logic;
        reg_load  : out std_logic;
        reg_src   : out std_logic_vector(1 downto 0);
        mem_read  : out std_logic;
        mem_write : out std_logic;
        jmp_bne   : out std_logic_vector(1 downto 0)  -- 00: normal, 01: JMP, 10: BNE
    );
end Control;

architecture syn of Control is
begin
    process(op)
    begin
        case op is

            -- Arithmetic Instructions
            -- ADD
            when x"0" =>
                alu_op    <= "00";
                alu_src   <= '0';
                reg_dest  <= '0';
                reg_load  <= '1';
                reg_src   <= "01";
                mem_read  <= '0';
                mem_write <= '0';
                jmp_bne   <= "00";

            -- SUB
            when x"1" =>
                alu_op    <= "01";
                alu_src   <= '0';
                reg_dest  <= '0';
                reg_load  <= '1';
                reg_src   <= "01";
                mem_read  <= '0';
                mem_write <= '0';
                jmp_bne   <= "00";

            -- AND
            when x"2" =>
                alu_op    <= "10";
                alu_src   <= '0';
                reg_dest  <= '0';
                reg_load  <= '1';
                reg_src   <= "01";
                mem_read  <= '0';
                mem_write <= '0';
                jmp_bne   <= "00";

            -- OR
            when x"3" =>
                alu_op    <= "11";
                alu_src   <= '0';
                reg_dest  <= '0';
                reg_load  <= '1';
                reg_src   <= "01";
                mem_read  <= '0';
                mem_write <= '0';
                jmp_bne   <= "00";

            -- ADD Immediate (ADDi)
            when x"4" =>
                alu_op    <= "00";
                alu_src   <= '1';
                reg_dest  <= '0';
                reg_load  <= '1';
                reg_src   <= "01";
                mem_read  <= '0';
                mem_write <= '0';
                jmp_bne   <= "00";

            -- SUB Immediate (SUBi)
            when x"5" =>
                alu_op    <= "01";
                alu_src   <= '1';
                reg_dest  <= '0';
                reg_load  <= '1';
                reg_src   <= "01";
                mem_read  <= '0';
                mem_write <= '0';
                jmp_bne   <= "00";

            -- Set on Less Than (SLT)
            when x"7" =>
                alu_op    <= "01";
                alu_src   <= '0';
                reg_dest  <= '0';
                reg_load  <= '1';
                reg_src   <= "10";
                mem_read  <= '0';
                mem_write <= '0';
                jmp_bne   <= "00";

            -- Load Word (LW)
            when x"8" =>
                alu_op    <= "00";
                alu_src   <= '1';
                reg_dest  <= '0';
                reg_load  <= '1';
                reg_src   <= "00";
                mem_read  <= '1';
                mem_write <= '0';
                jmp_bne   <= "00";

            -- Branch Not Equal (BNE)
            when x"9" =>
                alu_op    <= "01";   -- ALU performs subtraction to compare rs - rt
                alu_src   <= '0';
                reg_dest  <= '1';    -- destination not used, but required for mux
                reg_load  <= '0';    -- do not write to registers
                reg_src   <= "01";
                mem_read  <= '0';
                mem_write <= '0';
                jmp_bne   <= "10";   -- select BNE path in PC mux

            -- Jump Immediate (JMP)
            when x"B" =>
                alu_op    <= "00";
                alu_src   <= '0';
                reg_dest  <= '0';
                reg_load  <= '0';
                reg_src   <= "01";
                mem_read  <= '0';
                mem_write <= '0';
                jmp_bne   <= "01";   -- select JMP path in PC mux

            -- Store Word (SW)
            when x"C" =>
                alu_op    <= "00";
                alu_src   <= '1';
                reg_dest  <= '1';
                reg_load  <= '0';
                reg_src   <= "01";
                mem_read  <= '0';
                mem_write <= '1';
                jmp_bne   <= "00";

            -- Default case
            when others =>
                alu_op    <= "00";
                alu_src   <= '0';
                reg_dest  <= '0';
                reg_load  <= '0';
                reg_src   <= "01";
                mem_read  <= '0';
                mem_write <= '0';
                jmp_bne   <= "00";

        end case;
    end process;
end syn;
