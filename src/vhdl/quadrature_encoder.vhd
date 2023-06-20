library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity quadrature_encoder is
    port( 
        reset       : in std_logic;
        clk         : in std_logic;
        enc         : in std_logic_vector(1 downto 0);
        count       : out std_logic_vector(3 downto 0)
    );
end quadrature_encoder;

architecture rtl of quadrature_encoder is
----------------------------------------------------------------------------------
-- SIGNAL DECLARATIONS
----------------------------------------------------------------------------------
    signal encA_q       : std_logic_vector(2 downto 0);
    signal encA_d       : std_logic_vector(2 downto 0);
    signal encB_q       : std_logic_vector(2 downto 0);
    signal encB_d       : std_logic_vector(2 downto 0);
    signal count_en     : std_logic;
    signal direction    : std_logic;
    signal count_q      : std_logic_vector(count'LENGTH-1 downto 0);

begin
----------------------------------------------------------------------------------
-- SEQUENTIAL LOGIC
----------------------------------------------------------------------------------
    seq_block: process(clk, reset)
    begin
        if(clk'EVENT AND clk = '1') then
            if(reset = '0') then
                encA_q      <= (OTHERS=>'0');
                encB_q      <= (OTHERS=>'0');
                count_q     <= (OTHERS=>'0');
            else
                encA_q      <= encA_d;
                encB_q      <= encB_d;

                -- determine whether counter increments or decrements
                if(count_en = '1') then
                    if(direction = '1') then
                        count_q   <= std_logic_vector(to_unsigned(to_integer(unsigned(count_q)) + 1, count'LENGTH));
                    else
                        count_q   <= std_logic_vector(to_unsigned(to_integer(unsigned(count_q)) - 1, count'LENGTH));
                    end if;
                end if;
            end if;
        end if;
    end process;

----------------------------------------------------------------------------------
-- COMBINATIONAL LOGIC
----------------------------------------------------------------------------------
    encA_d      <= encA_q(1 downto 0) & enc(0);
    encB_d      <= encB_q(1 downto 0) & enc(1);
    -- if enabled then count may increment or decrement
    count_en    <= encA_q(1) XOR encA_q(2) XOR encB_q(1) XOR encB_q(2);
    -- 1 means forward; 0 means backward
    direction   <= encA_q(1) XOR encB_q(2);
    -- output
    count       <= count_q;

----------------------------------------------------------------------------------
-- ENTITY INSTANTIATIONS
----------------------------------------------------------------------------------

end rtl;
