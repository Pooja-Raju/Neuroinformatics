%Question 1, Create a family of morlet wavelets ranging in frequency from 2
%Hz to 30 Hz in 5 steps

lowest_freq = 2;
highest_freq = 30;
n_steps = 5;
frequency_range = linspace(lowest_freq,highest_freq,n_steps);
% z = [2:7:30]

load sampleEEGdata.mat
eegdata = 'sampleEEGdata.mat';

eoi = 'Fcz';
chan_index = find(strcmpi(eoi,{EEG.chanlocs.labels}));
eegdata = squeeze(EEG.data(chan_index,: ,: ))';
time = -1:1/EEG.srate:1; %check what happens if we change 1
wavelet_family = zeros(length(frequency_range),length(time));
 
% Loop through frequencies and make a family of wavelets.
for fi=1:n_steps
    
    % create a sine wave at this frequency
    sinewave = exp(2*1i*pi*frequency_range(fi).*time); % the "1i" makes it a complex wavelet
    
    % create a Gaussian window
    gaus_win = exp(-time.^2./(2*(6/(2*pi*frequency_range(fi)))^2));
    
    % create wavelet via element-by-element multiplication of the sinewave and gaussian window
    wavelet_family(fi,:) = sinewave.*gaus_win;
    plot(real(wavelet_family(fi,:)))
end

for trial = 1:size(eegdata,1)
    eegdata_trial = eegdata(trial,:);
    for wavelet_number = 1:size(wavelet_family,1)
        convol{trial}(wavelet_number,:) = real(conv(eegdata_trial, wavelet_family(wavelet_number,:),'same'));
    end
end

samp_convol_data = convol{66}(2,:);

n = length(samp_convol_data);  % Number of samples
frequencies = linspace(0, EEG.srate/2, n/2 + 1);  % Frequency axis
fft_1 = fft(samp_convol_data);
magnitude_spectrum = abs(fft_1(1:n/2 + 1));
plot(frequencies, magnitude_spectrum);

% the following graph depicts the band pass filtering of data from 4Hz to
% 13Hz, with the peaks at 9.2Hz

% Question 2, Now, average the result(s) of convolution over all trials and plot an ERP corresponding to each wavelet frequency. Each frequency should be in its own subplot. 
% Plot the broadband ERP (without any convolution) too.
% How do the wavelet-convolved ERPs compare with the broadband ERP?


%% Averaging the result(s) of convolution over all trials and  and plotting  an ERP corresponding to each wavelet frequency.

% 
% for j = 1:5
%     for l = 1:size(eeg_data_all_trials,1)
%          same_freq_store{j}(l,:) = convol_result{l}(1,:);
%     end
% 
%     mean_result = mean(same_freq_store{j},1);
%     figure;
%     plot(real(mean_result));
%     disp(mean_result);
% 
% end
convol_results = cell(1, length(frequency_range));

% Convolve each frequency's data
for i = 1:length(frequency_range)
    convol_result = zeros(size(eegdata_trial));
    for l = 1:size(eegdata_trial, 1)
        convol_result(l, :) = real(conv(eegdata_trial(l, :), wavelet_family(wavelet_number,:), 'same'));
    end
    disp(convol_result);
    convol_results{i} = convol_result;
end



% Compute the broadband ERP (without convolution)
broadband_ERP = mean(eegdata_trial, 1);

% Plotting
figure;
plot(broadband_ERP)


mean_results = cell(1, length(frequency_range));
% Plot each frequency's ERP in its own subplot
for i = 1:length(frequency_range)
    subplot(length(frequency_range)+1, 1, i);
    mean_result = mean(convol_results{i}, 1);
    mean_results{i} = mean_result;
    plot(mean_result);
    title(['ERP for frequency: ' num2str(frequency_range(i)) ' Hz']);
    xlabel('Time');
    ylabel('Amplitude');
end

% Plotting the broadband ERP
subplot(length(frequency_range)+1, 1, length(frequency_range)+1);
plot(broadband_ERP);
title('Broadband ERP (without convolution)');
xlabel('Time');
ylabel('Amplitude');

