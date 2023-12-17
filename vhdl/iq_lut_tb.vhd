----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/12/15 23:35:48
-- Design Name: 
-- Module Name: iq_lut_tb - testbench
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity iq_lut_tb is
end iq_lut_tb;

architecture testbench of iq_lut_tb is

component iq_lut is
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
end component iq_lut;

constant sample_rate    : integer := 1024;
constant data_bit_width : integer := 16;

signal rst_n            : std_logic := '0';
signal clk              : std_logic := '0';
signal i_wave_out       : std_logic_vector(data_bit_width-1 downto 0) 
                        := (others => '0');
signal q_wave_out       : std_logic_vector(data_bit_width-1 downto 0) 
                        := (others => '0');

begin

    dut : iq_lut
    generic map
    (
    sample_rate         => sample_rate,
    data_bit_width      => data_bit_width
    )
    port map
    (
    rst_n               => rst_n,
    clk                 => clk,
    i_wave_out          => i_wave_out,
    q_wave_out          => q_wave_out
    );

    rst_n               <= '1' after 100 ns;
    clk                 <= not clk after 50 ns;

end testbench;
