----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/12/15 22:34:03
-- Design Name: 
-- Module Name: iq_lut - behavioral
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


library ieee;
use ieee.std_logic_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use ieee.numeric_std.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity iq_lut is
generic
(
sample_rate             : integer := 1024;
data_bit_width          : integer := 16
);
port
(
rst_n                   : in    std_logic;
clk                     : in    std_logic;
i_wave_out              : out   std_logic_vector(data_bit_width-1 downto 0);
q_wave_out              : out   std_logic_vector(data_bit_width-1 downto 0)
);
end iq_lut;

architecture behavioral of iq_lut is

--------------------------------------------------------------------------------
-- SINE_LUT module
--------------------------------------------------------------------------------

component sine_lut is
generic
(
idx_offset              : integer := 0;
sample_rate             : integer := 1024;
data_bit_width          : integer := 16
);
port
(
rst_n                   : in    std_logic;
clk                     : in    std_logic;
wave_out                : out   std_logic_Vector(data_bit_width-1 downto 0)
);
end component sine_lut;

constant i_idx_offset   : integer := sample_rate/4;
constant q_idx_offset   : integer := 0;

begin

--------------------------------------------------------------------------------
-- Instance  of the SINE_LUT module
--------------------------------------------------------------------------------

    i_wave : sine_lut
    generic map
    (
    idx_offset              => i_idx_offset,
    sample_rate             => sample_rate,
    data_bit_width          => data_bit_width
    )
    port map
    (
    rst_n                   => rst_n,
    clk                     => clk,
    wave_out                => i_wave_out
    );

    q_wave : sine_lut
    generic map
    (
    idx_offset              => q_idx_offset,
    sample_rate             => sample_rate,
    data_bit_width          => data_bit_width
    )
    port map
    (
    rst_n                   => rst_n,
    clk                     => clk,
    wave_out                => q_wave_out
    );

end behavioral;
