library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity singleBitALUTB is
end singleBitALUTB;

architecture Behavioral of singleBitALUTB is

    component singleBitALU
        port (
            A       : in  std_logic;
            B       : in  std_logic;
            Cin     : in  std_logic;
            SB      : in  std_logic;
            sel     : in  std_logic_vector(2 downto 0);
            ALU_OUT : out std_logic;
            Cout    : out std_logic;
            Zero    : out std_logic
        );
    end component;

    signal A        : std_logic;
    signal B        : std_logic;
    signal Cin      : std_logic;
    signal SB       : std_logic;
    signal sel      : std_logic_vector(2 downto 0);
    signal ALU_OUT  : std_logic;
    signal Cout     : std_logic;
    signal Zero     : std_logic;

begin

    UUT: singleBitALU
        port map (
            A       => A,
            B       => B,
            Cin     => Cin,
            SB      => SB,
            sel     => sel,
            ALU_OUT => ALU_OUT,
            Cout    => Cout,
            Zero    => Zero
        );

    process
    begin
        -- AND operation
        A   <= '1';
        B   <= '1';
        Cin <= '0';
        SB  <= '0';
        sel <= "000";
        wait for 100 ns;

        -- OR operation
        A   <= '0';
        B   <= '1';
        Cin <= '0';
        SB  <= '0';
        sel <= "001";
        wait for 100 ns;

        -- Unsigned addition
        A   <= '1';
        B   <= '1';
        Cin <= '0';
        SB  <= '0';
        sel <= "010";
        wait for 100 ns;

        -- XOR operation
        A   <= '1';
        B   <= '0';
        Cin <= '0';
        SB  <= '0';
        sel <= "011";
        wait for 100 ns;

        -- Signed addition
        A   <= '1';
        B   <= '1';
        Cin <= '0';
        SB  <= '0';
        sel <= "100";
        wait for 100 ns;

        -- Signed subtraction
        A   <= '1';
        B   <= '0';
        Cin <= '1';
        SB  <= '1';
        sel <= "101";
        wait for 100 ns;

        -- Set on less than
        A   <= '0';
        B   <= '1';
        Cin <= '0';
        SB  <= '0';
        sel <= "110";
        wait for 100 ns;

        -- Branch if equal
        A   <= '1';
        B   <= '1';
        Cin <= '0';
        SB  <= '0';
        sel <= "111";
        wait for 100 ns;

        wait;
    end process;

end Behavioral;
