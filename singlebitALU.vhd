library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity singleBitALU is
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
end singleBitALU;

architecture behavior of singleBitALU is

    component full_adder
        port (
            A    : in  std_logic;
            B    : in  std_logic;
            Cin  : in  std_logic;
            Sout : out std_logic;
            Cout : out std_logic
        );
    end component;

    component and_gate
        port (
            A    : in  std_logic;
            B    : in  std_logic;
            Sout : out std_logic
        );
    end component;

    component or_gate
        port (
            A    : in  std_logic;
            B    : in  std_logic;
            Sout : out std_logic
        );
    end component;

    component xor_gate
        port (
            A    : in  std_logic;
            B    : in  std_logic;
            Sout : out std_logic
        );
    end component;

    signal NB               : std_logic;
    signal Sout_full_adder  : std_logic;
    signal Sout_and_gate   : std_logic;
    signal Sout_or_gate    : std_logic;
    signal Sout_xor_gate   : std_logic;

begin

    NB <= B xor sel(0);

    FA: full_adder
        port map (
            A    => A,
            B    => NB,
            Cin  => Cin,
            Sout => Sout_full_adder,
            Cout => Cout
        );

    AND1: and_gate
        port map (
            A    => A,
            B    => B,
            Sout => Sout_and_gate
        );

    OR1: or_gate
        port map (
            A    => A,
            B    => B,
            Sout => Sout_or_gate
        );

    XOR1: xor_gate
        port map (
            A    => A,
            B    => B,
            Sout => Sout_xor_gate
        );

    process(A, B, sel)
    begin
        if sel = "111" then
            Zero <= '1' when A = B else '0';
        elsif sel = "110" then
            Zero <= '1' when A < B else '0';
        else
            Zero <= '0';
        end if;
    end process;

end behavior;
