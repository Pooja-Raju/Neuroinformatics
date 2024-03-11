% Question 1. Create a family of Morlet wavelets, ranging in frequencies
% from 2 Hz to 30 Hz in five steps
clear
close all
lowest_freq = 2;
highest_freq = 30;
n_steps = 5;
frequency_range = linspace(lowest_freq,highest_freq,n_steps);
% disp(frequency_range)

load sampleEEGdata.mat
eegdata = 'sampleEEGdata.mat';

eoi = 'Fcz';
chan_index = find(strcmpi(eoi,{EEG.chanlocs.labels}));
eegdata = squeeze(EEG.data(chan_index,: ,: ))';
time = -1:1/EEG.srate:1; %check what happens if we change 1
no_cycles = 6;

wavelets = cell(length(frequency_range), 1);
figure;
for i = 1:length(frequency_range)
    frequency = frequency_range(i);
    s = no_cycles/(2*pi*frequency);
    morlet_wavelets(i,:) = (1/(sqrt(s*sqrt(pi)))) * exp(2*1i*pi*frequency.*time).* exp(-time.^2/(2*s^2));
    plot(real(morlet_wavelets(i,:)))
    hold on
    legend
end
hold off

% Question 2, Convolve each wavelet with the electrode data that you used in the last class for any one trial.


