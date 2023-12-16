% + === + === + === + === + === + === + === + === + === + === + === + === +
% |                                                                       |
% | This MATLAB script was written for the purpose of generating          |
% | the lookup table needed to output a sine wave from an FPGA.           |
% |                                                                       |
% + === + === + === + === + === + === + === + === + === + === + === + === +

% Clean up all past data.
clc; close all; clear;

% Change the following variable values to the values used in the FPGA program.
sample_rate = 1024;
data_bit_width = 16;

%%
%% Set the following variable values to generate a signal.
%%

% Set the frequency value to generate the waveform.
% (One cycle is sufficient for the amount of data this script will generate.)
f = 1;

% Determine the sampling rate.
% (This value must match the number of data tables you will use in your FPGA.)
fs = (sample_rate/2);

% Determine the time value.
% (Determine the value based on the sampling rate set above.)
t = linspace(0, 1-(1/fs), fs);

%%
%% Generates a signal using the variable values set above.
%%

% Adjust the values of the variables that determine the amplitude 
% to output natural numbers as much as possible.
amp_max = 2^(data_bit_width-2);
amp_off = amp_max/2;

% The value of variable "X" stores the value for the original waveform, 
% and the value of variable "X1" stores the value 
% for the amplitude-adjusted waveform, allowing the results to be compared.
% ------------------------------------------------------------------------------ 
% Please refer to the following to understand the SINE waveform.
% The formula for generating the SINE waveform is as follows, 
% but can be changed arbitrarily to save FPGA resources.
% x = a*sin(2*pi*f*t)
x_sine = sin(2*pi*f*t);
x_half = sin(pi*f*t);
x_ampl = sin(pi*f*t)*amp_max;
x_amp1 = sin(pi*f*t)*amp_off+amp_off;

%%
%% For each waveform, create a graph to compare results.
%%

% Output the original SINE waveform as a graph.
figure(1);
plot(t, x_sine); grid on;
title('Original sine waveform');
xlabel('Seconds'); ylabel('Amplitude');

% Outputs a SINE waveform in which only the positive polarity region exists.
figure(2);
plot(t, x_half); grid on;
title('Half sine waveform with only bipolar polarity');
xlabel('Seconds'); ylabel('Amplitude');

% Outputs a SINE waveform with the amplitude changed.
figure(3);
hold on; plot(t, x_ampl); plot(t, x_amp1); hold off; grid on;
title('Multiple sine waveforms with adjusted amplitude');
xlabel('Seconds'); ylabel('Amplitude'); legend('x\_amp\_0', 'x\_amp\_1');

%%
%% Outputs the result data.
%%

% The resulting value is derived in natural number form.
x_data = cast(x_amp1, "uint32");

% Prints random text to identify the copy area.
fprintf("===== [ Please copy and use from here. ] =====\r\n");

% Outputs SINE waveform data.
idx_length=size(x_data,2);
for idx = 1:idx_length
    if idx == idx_length
        fprintf('%d\r', x_data(idx))
    else
        fprintf('%d, ', x_data(idx))
    end

    if (mod(idx,8) == 0)
        fprintf('\n')
    end
end

% Prints random text to identify the copy area.
fprintf("===== [ This is the end of the copy area. ] =====\r\n");

