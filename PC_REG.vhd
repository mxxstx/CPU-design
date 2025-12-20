library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PC_REG is
    port(
        clk    : in  std_logic;
        reset  : in  std_logic;
        pc_in  : in  std_logic_vector(15 downto 0);
        pc_out : out std_logic_vector(15 downto 0)
    );
end PC_REG;

architecture Behavioral of PC_REG is
begin
    process(reset, clk)
    begin
        if reset = '0' then
            pc_out <= (others => '0');
        elsif rising_edge(clk) then
            pc_out <= pc_in;
        end if;
    end process;
end Behavioral;
