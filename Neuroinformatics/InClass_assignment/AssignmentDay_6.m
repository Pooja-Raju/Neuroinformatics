%Question 1: create two kernels for convolution that look like 
% A) An inverted U 
%extra stuff about symmetrical kernels they allow for the resultant conv to
%match 
kernel_1 = [.1 .2 .4 .2 .1];


% B) A decay function
kernel_2 = [1 .8 .6 .4 .2];

% C) A rando function

kernel_3 = [.2 .4 .5 .8 1];

kernel_store = {kernel_1, kernel_2, kernel_3};

figure
subplot (3,1,1)
plot(kernel_1)
title('kernel 1, inverted u')
set(gca,'xlim',[0 5],'ylim',[-.1 1.1])

subplot (3,1,2)
plot(kernel_2,'.-')
title('kernel 2, decay')
set(gca,'xlim',[0 5],'ylim',[-.1 1.1])

%Question 2: convolve the above two kernels with 50 time-points of EEG data
%from one electrode-use the recording of the Fcz electrode for the first
%trial from sampleEEGdata. Now make two 3*1 plots showing the kernels, the
%EEG data and the result of the convolution 
%%
load sampleEEGdata.mat
data = 'sampleEEGdata.mat';

%electrode of interest
eoi = 'Fcz';
%chan_index is the channel index we gotta find the labels within the data
chan_index = find(strcmpi(eoi,{EEG.chanlocs.labels}));
eegdata = squeeze(EEG.data(chan_index, 1:50,1));
plot(eegdata)

% Padding the eegdata with zeros to perform convolution using the length of
% the kernels, since both of them are length 5 i will add one of them to
% the front and back of the eegdata

padded_eegdata = [zeros(1, length(kernel_2) - 1), eegdata, zeros(1, length(kernel_2) - 1)];

% Perform convolution using dot product
for i = 1:length(kernel_store)
    kernel = kernel_store{i};
    for j = 1:length(eegdata)+length(kernel) - 1
        manually_convolved_data{i}(1,j) = sum(kernel .* padded_eegdata(j:j+length(kernel)-1));
    end
    auto_convolved_data{i} = conv(eegdata, kernel, 'same');
    trimmed_convolved_data{i} = manually_convolved_data{i}(3:52); % hardcoded
    figure;
    subplot(3,1,1)
    plot(kernel)
    % title ('kernel 1')
    
    subplot(3,1,2)
    plot(eegdata)
    title('eeg data')
    
    subplot(3,1,3)
    plot(trimmed_convolved_data{i})
    hold on
    plot(auto_convolved_data{i})
    legend
    hold off
end

tic
for k = 1:1000
    for j = 1:length(eegdata)+length(kernel_1) - 1
        manually_convolved_data(1,j) = sum(kernel_1 .* padded_eegdata(j:j+length(kernel_1)-1));
    end
end
toc
%plotting data in a 3*1 manner where kernel, data and the convoluted data
%is visible for both of the kernels
%figure;

% figure;
% subplot(3,1,1)
% plot(kernel_2)
% title ('kernel 2')
% 
% subplot(3,1,2)
% plot(eegdata)
% title('eeg data')
% 
% subplot(3,1,3)
% plot(convolved_data_2)
% title('convolution with kernel 2')

% Plotting the results where we can compare the eegdata with its two
% convolutions with the respectiv etwo kernels
% figure;
% 
% % Plot for Kernel 1
% subplot(3,1,1)
% plot(eegdata)
% title('Original EEG Data')
% 
% subplot(3,1,2)
% plot(convolved_data_1)
% title('Convolved with Kernel 1')
% 
% % Plot for Kernel 2
% subplot(3,1,3)
% plot(convolved_data_2)
% title('Convolved with Kernel 2')


%how to do the same convultion using the matlab function conv. TA, please
%ignore this part
%conv_data_invertedU = conv(eegdata, kernel_1,'same');
%plot(conv_data_invertedU)
%conv_data_decay = conv(eegdata, kernel_2,'same');
%plot(conv_data_decay)

%Question 3, based on visual inspection, what is the effect of convolving
%the EEG data with these two kernels?

Upon inspection of the two convolutions I can tell that there

%Redo Question 2-- but for the entire duration by performing the
%convolution using 
%A) discrete time fourier transform(DTFT)
%B) Custom Matlab functions fft and ifft. Do not use conv 
% i)which of three methods that you learnt is the fastest? slowest?

kernel_1 = [.1 .3 .5 .3 .1];

kernel_2 = [1 .8 .6 .4 .2];

load sampleEEGdata.mat
data = 'sampleEEGdata.mat';

%there are total 640 timepoints in our sample EEG data

eegData = EEG.data(strcmpi('Fcz',{EEG.chanlocs.labels}),:,1);
plot(eegData)


fft_data = fft(eegData, length(eegData) + length(kernel_1) - 1);
fft_kernel = fft(kernel_1, length(eegData) + length(kernel_1) - 1);
fft_product = fft_data.* fft_kernel;
conv_output = ifft(fft_product);
conv_output = conv_output(3:642);


tic
for k=1:1000
    fft_data = fft(eegData, length(eegData) + length(kernel_1) - 1);
    fft_kernel = fft(kernel_1, length(eegData) + length(kernel_1) - 1);
    fft_product = fft_data.* fft_kernel;
    conv_output = ifft(fft_product);
    conv_output = conv_output(3:642);
end
toc
auto_conv = conv(eegData, kernel_1, 'same');

figure;
plot(conv_output)
hold on 
plot(auto_conv)
legend

%i) after running the tic toc for both we can see that the manual
%convolution is faster than using the fft function from matlab 
%0.157870 seconds (fft) > 0.072779 seconds (manual)

% the following is for understnding dtft
% N = length(eegData);
% time = (0:N-1)/N;
% for fi = 1:N
%     sinewave = exp(-1i*2*pi*(fi-1).*time);
%     fourier(fi) = sum(sinewave.*eegData);
% end
% N_kernel_dtft= length(kernel_1);
% time = (0:N_kernel_dtft-1)/N_kernel_dtft;
% for fik = 1:N_kernel_dtft
%     sinewave = exp(-1i*2*pi*(fi-1).*time);
%     fourier(fik) = sum(sinewave.*kernel_1);
% end









