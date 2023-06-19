library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    port( 
        reset       : in std_logic;
        clk         : in std_logic;
        enc         : in std_logic_vector(1 downto 0);
        count       : out std_logic_vector(3 downto 0)      
    );
end top;

architecture structural of top is
----------------------------------------------------------------------------------
-- SIGNAL DECLARATIONS
----------------------------------------------------------------------------------
    signal aiso_reset   : std_logic;

begin
----------------------------------------------------------------------------------
-- SEQUENTIAL LOGIC
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- COMBINATIONAL LOGIC
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- ENTITY INSTANTIATIONS
----------------------------------------------------------------------------------
    -- aiso_reset
    u_aiso_reset: entity work.aiso_reset
    port map( 
        reset       => reset,
        clk         => clk,
        aiso_reset  => aiso_reset
    );

    -- quadrature_encoder
    u_quadrature_encoder: entity work.quadrature_encoder
    port map(
        reset       => aiso_reset,
        clk         => clk,
        enc         => enc,
        count       => count
    );

end structural;
