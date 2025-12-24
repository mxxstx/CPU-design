library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity ALU_TB is
end ALU_TB;

architecture Behavioral of ALU_TB is

    component ALU
        port (
            IN1     : in  STD_LOGIC_VECTOR(7 downto 0);
            IN2     : in  STD_LOGIC_VECTOR(7 downto 0);
            SEL     : in  STD_LOGIC_VECTOR(2 downto 0);
            Cin     : in  STD_LOGIC;
            ALU_OUT : out STD_LOGIC_VECTOR(7 downto 0);
            Zero    : out STD_LOGIC;
            OVF     : out STD_LOGIC
        );
    end component;

    signal IN1, IN2 : STD_LOGIC_VECTOR(7 downto 0);
    signal SEL      : STD_LOGIC_VECTOR(2 downto 0);
    signal Cin      : STD_LOGIC;
    signal ALU_OUT  : STD_LOGIC_VECTOR(7 downto 0);
    signal Zero     : STD_LOGIC;
    signal OVF      : STD_LOGIC;

begin

    uut: ALU
        port map (
            IN1     => IN1,
            IN2     => IN2,
            SEL     => SEL,
            Cin     => Cin,
            ALU_OUT => ALU_OUT,
            Zero    => Zero,
            OVF     => OVF
        );

    process
    begin
        -- 5 + 3
        IN1 <= "00000101";
        IN2 <= "00000011";
        SEL <= "000";
        Cin <= '0';
        wait for 10 ns;

        -- -5 + 3
        IN1 <= "11111011";
        SEL <= "001";
        wait for 10 ns;

        -- -5 - 3
        SEL <= "010";
        wait for 10 ns;

        -- 5 AND 3
        IN1 <= "00000101";
        IN2 <= "00000011";
        SEL <= "011";
        wait for 10 ns;

        -- 5 OR 3
        SEL <= "100";
        wait for 10 ns;

        -- 5 XOR 3
        SEL <= "101";
        wait for 10 ns;

        -- -5 < 3
        IN1 <= "11111011";
        IN2 <= "00000011";
        SEL <= "110";
        wait for 10 ns;

        -- 5 == 3
        IN1 <= "00000101";
        IN2 <= "00000011";
        SEL <= "111";
        wait for 10 ns;

        -- 3 == 3
        IN1 <= "00000011";
        wait for 10 ns;

        wait;
    end process;

end Behavioral;
