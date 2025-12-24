library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity ALU is
    port (
        IN1     : in  STD_LOGIC_VECTOR(7 downto 0);
        IN2     : in  STD_LOGIC_VECTOR(7 downto 0);
        SEL     : in  STD_LOGIC_VECTOR(2 downto 0);
        Cin     : in  STD_LOGIC;
        ALU_OUT : out STD_LOGIC_VECTOR(7 downto 0);
        Zero    : out STD_LOGIC;
        OVF     : out STD_LOGIC
    );
end ALU;

architecture Behavioral of ALU is
    constant Dwidth : integer := 8;

    signal temp_result : STD_LOGIC_VECTOR(Dwidth-1 downto 0);
    signal signed_in1  : signed(Dwidth-1 downto 0);
    signal signed_in2  : signed(Dwidth-1 downto 0);
    signal sum         : signed(Dwidth downto 0);
begin

    process(IN1, IN2, SEL, Cin)
    begin
        signed_in1 <= signed(IN1);
        signed_in2 <= signed(IN2);

        Zero <= '0';
        OVF  <= '0';

        case SEL is

            -- Unsigned Addition
            when "000" =>
                temp_result <= IN1 + IN2;

            -- Signed Addition
            when "001" =>
                sum <= ('0' & signed_in1) + ('0' & signed_in2);
                temp_result <= std_logic_vector(sum(Dwidth-1 downto 0));
                OVF <= sum(Dwidth);

            -- Signed Subtraction
            when "010" =>
                sum <= ('0' & signed_in1) - ('0' & signed_in2);
                temp_result <= std_logic_vector(sum(Dwidth-1 downto 0));
                OVF <= sum(Dwidth);

            -- AND
            when "011" =>
                temp_result <= IN1 and IN2;

            -- OR
            when "100" =>
                temp_result <= IN1 or IN2;

            -- XOR
            when "101" =>
                temp_result <= IN1 xor IN2;

            -- Set Less Than (SLT)
            when "110" =>
                if signed_in1 < signed_in2 then
                    temp_result <= (others => '0');
                    temp_result(0) <= '1';
                else
                    temp_result <= (others => '0');
                end if;

            -- Equal (BEQ check)
            when "111" =>
                if IN1 = IN2 then
                    Zero <= '1';
                else
                    Zero <= '0';
                end if;
                temp_result <= (others => '0');

            when others =>
                temp_result <= (others => '0');

        end case;
    end process;

    ALU_OUT <= temp_result;

end Behavioral;
