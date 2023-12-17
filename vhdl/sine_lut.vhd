----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/12/15 22:34:03
-- Design Name: 
-- Module Name: sine_lut - behavioral
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

entity sine_lut is
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
wave_out                : out   std_logic_vector(data_bit_width-1 downto 0)
);
end sine_lut;

architecture behavioral of sine_lut is

-- Defines the data type of sine waveform.
type sine_table_data_t is array (natural range <>) of integer;

-- Defines the data for storing sine waveform data.
constant sine_table_max     : integer := sample_rate/2;
constant sine_table         : sine_table_data_t(0 to sine_table_max-1) :=
(
8192, 8242, 8293, 8343, 8393, 8443, 8494, 8544, 
8594, 8644, 8694, 8745, 8795, 8845, 8895, 8945, 
8995, 9045, 9095, 9145, 9195, 9245, 9294, 9344, 
9394, 9444, 9493, 9543, 9593, 9642, 9691, 9741, 
9790, 9839, 9889, 9938, 9987, 10036, 10085, 10134, 
10182, 10231, 10280, 10328, 10377, 10425, 10474, 10522, 
10570, 10618, 10666, 10714, 10762, 10809, 10857, 10904, 
10952, 10999, 11046, 11093, 11140, 11187, 11234, 11280, 
11327, 11373, 11420, 11466, 11512, 11558, 11603, 11649, 
11695, 11740, 11785, 11830, 11875, 11920, 11965, 12009, 
12054, 12098, 12142, 12186, 12230, 12273, 12317, 12360, 
12404, 12447, 12489, 12532, 12575, 12617, 12659, 12701, 
12743, 12785, 12826, 12868, 12909, 12950, 12991, 13032, 
13072, 13112, 13152, 13192, 13232, 13272, 13311, 13350, 
13389, 13428, 13466, 13505, 13543, 13581, 13619, 13656, 
13693, 13731, 13767, 13804, 13841, 13877, 13913, 13949, 
13985, 14020, 14055, 14090, 14125, 14160, 14194, 14228, 
14262, 14296, 14329, 14362, 14395, 14428, 14460, 14492, 
14525, 14556, 14588, 14619, 14650, 14681, 14711, 14742, 
14772, 14802, 14831, 14861, 14890, 14918, 14947, 14975, 
15003, 15031, 15059, 15086, 15113, 15140, 15166, 15193, 
15219, 15244, 15270, 15295, 15320, 15344, 15369, 15393, 
15417, 15440, 15464, 15487, 15509, 15532, 15554, 15576, 
15597, 15619, 15640, 15661, 15681, 15701, 15721, 15741, 
15760, 15780, 15798, 15817, 15835, 15853, 15871, 15888, 
15905, 15922, 15938, 15955, 15971, 15986, 16001, 16017, 
16031, 16046, 16060, 16074, 16087, 16101, 16113, 16126, 
16138, 16151, 16162, 16174, 16185, 16196, 16206, 16217, 
16227, 16236, 16246, 16255, 16263, 16272, 16280, 16288, 
16295, 16303, 16309, 16316, 16322, 16328, 16334, 16339, 
16345, 16349, 16354, 16358, 16362, 16365, 16369, 16372, 
16374, 16376, 16378, 16380, 16382, 16383, 16383, 16384, 
16384, 16384, 16383, 16383, 16382, 16380, 16378, 16376, 
16374, 16372, 16369, 16365, 16362, 16358, 16354, 16349, 
16345, 16339, 16334, 16328, 16322, 16316, 16309, 16303, 
16295, 16288, 16280, 16272, 16263, 16255, 16246, 16236, 
16227, 16217, 16206, 16196, 16185, 16174, 16162, 16151, 
16138, 16126, 16113, 16101, 16087, 16074, 16060, 16046, 
16031, 16017, 16001, 15986, 15971, 15955, 15938, 15922, 
15905, 15888, 15871, 15853, 15835, 15817, 15798, 15780, 
15760, 15741, 15721, 15701, 15681, 15661, 15640, 15619, 
15597, 15576, 15554, 15532, 15509, 15487, 15464, 15440, 
15417, 15393, 15369, 15344, 15320, 15295, 15270, 15244, 
15219, 15193, 15166, 15140, 15113, 15086, 15059, 15031, 
15003, 14975, 14947, 14918, 14890, 14861, 14831, 14802, 
14772, 14742, 14711, 14681, 14650, 14619, 14588, 14556, 
14525, 14492, 14460, 14428, 14395, 14362, 14329, 14296, 
14262, 14228, 14194, 14160, 14125, 14090, 14055, 14020, 
13985, 13949, 13913, 13877, 13841, 13804, 13767, 13731, 
13693, 13656, 13619, 13581, 13543, 13505, 13466, 13428, 
13389, 13350, 13311, 13272, 13232, 13192, 13152, 13112, 
13072, 13032, 12991, 12950, 12909, 12868, 12826, 12785, 
12743, 12701, 12659, 12617, 12575, 12532, 12489, 12447, 
12404, 12360, 12317, 12273, 12230, 12186, 12142, 12098, 
12054, 12009, 11965, 11920, 11875, 11830, 11785, 11740, 
11695, 11649, 11603, 11558, 11512, 11466, 11420, 11373, 
11327, 11280, 11234, 11187, 11140, 11093, 11046, 10999, 
10952, 10904, 10857, 10809, 10762, 10714, 10666, 10618, 
10570, 10522, 10474, 10425, 10377, 10328, 10280, 10231, 
10182, 10134, 10085, 10036, 9987, 9938, 9889, 9839, 
9790, 9741, 9691, 9642, 9593, 9543, 9493, 9444, 
9394, 9344, 9294, 9245, 9195, 9145, 9095, 9045, 
8995, 8945, 8895, 8845, 8795, 8745, 8694, 8644, 
8594, 8544, 8494, 8443, 8393, 8343, 8293, 8242
);

-- Defines the signal for data processing 
-- of the Sine waveform to be currently output.
signal sine_table_idx       : integer range 0 to sine_table_max-1 := 0;
signal current_sine_data    : unsigned(data_bit_width-1 downto 0)
                            := (others => '0');

-- Defines the type and signal for selecting the polarity of the waveform.
-- (Method for saving resources)
type wave_pol_t is (wave_pol_rising, wave_pol_falling);
signal wave_polarity        : wave_pol_t := wave_pol_rising;

begin

    -- Determine the index and polarity.
    process(clk)
    begin
    if (rising_edge(clk)) then
        if (rst_n = '0') then
            sine_table_idx <= idx_offset;
            wave_polarity <= wave_pol_rising;
        else
            if (sine_table_idx >= sine_table_max-1) then
                sine_table_idx <= 0;
                if (wave_polarity = wave_pol_rising) then
                    wave_polarity <= wave_pol_falling;
                else
                    wave_polarity <= wave_pol_rising;
                end if; -- end of if (wave_polarity)
            else
                sine_table_idx <= sine_table_idx+1;
            end if; -- end of if (sine_table_idx >= sine_table_max-1)
        end if; -- end of if (rst_n = '0')
    end if; -- end of if (rising_edge(clk))
    end process;

    -- Determines the data of the current SINE WAVE.
    process(clk)
    begin
    if (rising_edge(clk)) then
        if (rst_n = '0') then
            current_sine_data <= (others => '0');
        else
            current_sine_data <= 
                to_unsigned(sine_table(sine_table_idx), data_bit_width);
        end if; -- end of if (rst_n = '0')
    end if; -- end of if (rising_edge(clk))
    end process;

    wave_out <= std_logic_vector(current_sine_data)
                when (wave_polarity = wave_pol_rising) else 
                std_logic_vector((2**(data_bit_width-2))-current_sine_data);

end behavioral;
