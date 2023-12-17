clear; close all; clc;

f = 1;
fs = 128;
t = linspace(0, 1-(1/fs), fs);

Iwave = cos(2*pi*f*t);
Qwave = sin(2*pi*f*t);

Qwave1 = zeros(1,fs);
Qwave1(1:(fs*3/4)) = Qwave((fs*1/4+1):fs);
Qwave1((fs*3/4+1):fs) = Qwave(1:(fs*1/4));

% Display plot
figure(1);
hold on; plot(t, Iwave, '--'); plot(t, Qwave, 'b--o'); plot(t, Qwave1, 'c*'); hold off;
title('I/Q Display');
xlabel('Seconds'); ylabel('Amplitude'); grid on;
legend('I\_cos', 'Q\_sin', 'Qwave1');
