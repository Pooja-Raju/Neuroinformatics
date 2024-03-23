% Question 1: Select one electrode and one frequency and compute power over time at that electrode and that frequency for all trials using 
% (1) complex wavelet convolution, (2) filter-Hilbert, (3) the short-time FFT, and (4) multi-taper method.

load sampleEEGdata

% Select electrode
chan2use = 'fcz';

% Frequency of interest
freq_of_interest = 10; % For example, 10 Hz

% Wavelet parameters
time = -1:1/EEG.srate:1;
s = 5 / (2*pi*freq_of_interest); % "5" for the number of wavelet cycles

% Wavelet and data sizes
n_wavelet = length(time);
n_data = EEG.pnts * EEG.trials;
n_convolution = n_wavelet + n_data - 1;
n_conv_pow2 = pow2(nextpow2(n_convolution));
half_of_wavelet_size = (n_wavelet - 1) / 2;

% To extract FFT of the data for the selected channel
chanidx = strcmpi(chan2use, {EEG.chanlocs.labels});
eegfft = fft(reshape(EEG.data(chanidx,:,:), 1, EEG.pnts*EEG.trials), n_conv_pow2);

% Create the wavelet
wavelet = fft(sqrt(1/(s*sqrt(pi))) * exp(2*1i*pi*freq_of_interest.*time) .* exp(-time.^2./(2*s^2)), n_conv_pow2);

% Perform convolution
eegconv = ifft(wavelet.*eegfft);
eegconv = eegconv(1:n_convolution);
eegconv = eegconv(half_of_wavelet_size+1:end-half_of_wavelet_size);

% Reshape and compute power
eegpower_time = abs(reshape(eegconv, EEG.pnts, EEG.trials)).^2;
mean_power = mean(eegpower_time, 2);

mu = mean(mean_power);
sigma = std(mean_power);

% Apply z-score normalization
zScoreNormalizedSignal = (mean_power - mu) / sigma;
figure
subplot(311)
plot(EEG.times, eegpower_time);
xlabel('Time (ms)');
ylabel('Power (dB)');
title(sprintf('Power over time at %s electrode, %d Hz', chan2use, freq_of_interest));
xlim([EEG.times(1), EEG.times(end)]);

subplot(312)
plot(EEG.times, mean_power);
xlabel('Time (ms)');
ylabel('Power (uV^2)'); % Adjust the unit based on your data
title(sprintf('Trial-Averaged Power at %d Hz for Electrode %s', freq_of_interest, chan2use));
xlim([EEG.times(1), EEG.times(end)]); % Adjust the x-axis limits to the EEG time range


subplot(313)
plot(EEG.times, zScoreNormalizedSignal)
xlabel('Time (ms)')
ylabel('Z-score normalized amplitude')
title(sprintf('Z-score Normalized Trial-Averaged Signal for Wavelet Convolution at Electrode FCz'))

