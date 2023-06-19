library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity aiso_reset is
    port( 
        reset       : in std_logic;
        clk         : in std_logic;
        aiso_reset  : out std_logic
    );
end aiso_reset;

architecture rtl of aiso_reset is
----------------------------------------------------------------------------------
-- SIGNAL DECLARATIONS
----------------------------------------------------------------------------------
    signal Q1 : std_logic;
    signal Q2 : std_logic;
    
begin
----------------------------------------------------------------------------------
-- SEQUENTIAL LOGIC
----------------------------------------------------------------------------------
    -- active low reset
    process(clk, reset) begin
        if(clk'event and clk = '1') then
            if(reset = '0') then
                Q1 <= '0';
            else
                Q1 <= '1';
            end if;
        end if;
    end process;
    
    process(clk, reset) begin
        if(clk'event and clk = '1') then
            if(reset = '0') then
                Q2 <= '0';
            else
                Q2 <= Q1;
            end if;
        end if;
    end process;

----------------------------------------------------------------------------------
-- COMBINATIONAL LOGIC
----------------------------------------------------------------------------------
    aiso_reset <= Q2;

----------------------------------------------------------------------------------
-- ENTITY INSTANTIATIONS
----------------------------------------------------------------------------------

end rtl;
