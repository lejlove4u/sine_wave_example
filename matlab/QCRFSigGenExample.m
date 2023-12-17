%% Creating and Downloading an IQ Waveform to a RF Signal Generator
% This example shows how to use the Quick-Control RF Signal Generator to generate and transmit RF waveforms.
%

%% Introduction
% In this example we will create an IQ waveform and transmit this waveform using the Quick-Control RF Signal Generator.

%% Requirements
% To run this example you need:
% 
% * Keysight Technologies&reg; N5172B signal generator
% * Keysight VISA version 17.3
% * IVI-C driver for Keysight Technologies N5172B signal generator
% * National Instruments&trade; IVI&reg; compliance package version 16.0.1.2 or higher

%% Create IQ waveform
% We will create an IQ waveform that consists of two sinusoid signals with real and imaginary values.
%
% When generating signals for the RF Signal Generator ensure that the waveform is a continuous row vector. 

% Configure parameters for waveform. 

% Number of points in the waveform
points = 1000;  

% Determines the frequency offset from the carrier
cycles = 101;   
phaseInc = 2*pi*cycles/points;
phase = phaseInc * (0:points-1);

% Create an IQ waveform
Iwave = cos(phase);
Qwave = sin(phase);
IQData = Iwave+1i*Qwave;
IQData = IQData(:)';

%% Create an RF Signal Generator Object
rf = rfsiggen();
%%
% Discover all the available instrument resources you can connect to, using the |resources| method.
rf.resources

%%
% Discover all the available instrument drivers, using |drivers| method.
rf.drivers

%% Connect to Signal Generator
% Set |Resource| and |Driver| property before connecting to the object.
rf.Resource = 'TCPIP0::A-N5172B-50283.dhcp.mathworks.com::inst0::INSTR';
rf.Driver = 'AgRfSigGen';
% Connect to the instrument
connect(rf);

%% Download the Waveform
% Download the waveform, |IQData| to the instrument with sampling rate of 10MHz.
samplingRate = 10e6;
download(rf, IQData, samplingRate);

%% Transmit the Waveform
% Transmit the downloaded waveform with center frequency of 1GHz and output power of 0dBm. Note these values are selected as
% reference values and is not intended to be recognized as standard values for transmitting any RF signals.
% Loop count represents the number of times the waveform should be repeated.
centerFrequency = 1e9;
outputPower = 0;
loopCount = Inf;
start(rf, centerFrequency, outputPower, loopCount);

%% Stop Transmitting the Waveform
% Once you have finished transmitting the signal, stop the transmission. 
stop(rf);

%% Clean Up
% Close the connection of the signal generator and remove it from the workspace.
disconnect(rf);
delete(rf);
clear rf



%% 
% Copyright 2012 The MathWorks, Inc.
