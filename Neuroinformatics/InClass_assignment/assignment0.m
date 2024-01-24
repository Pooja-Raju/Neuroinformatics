%Question1:
% transposed the given data to resemble the text where we have two
%conditions successful and unsucessful and the rows represent the trials.
data = load ('Power.mat');
Power_data = data.Power;

Power_data_transpose = Power_data';
%since we now have the required matrix we will do a t test to compare means
%of the two columns
x = Power_data_transpose(:,1);
y = Power_data_transpose(:,2);

[h,p,ci,stats] = ttest(x,y)
%I tried to do a dependent sample t-test(paired) assuming that the data are
%acquired by subject in successful and unsuccessful trials. Moreover,
%since p-value is 0.04 the results are significant assuming that we
%require a bar of less than 0.05.

%Question2:Creating 4 individuals sine waves and a combined wave 

t = [0:0.001:4];
A = [7 2 5 4];
Phase = [pi/3 pi/2 -pi/3 pi/4];
F = [2 8 12 25];
figure;
for i = 1:4
    x(i,:) = A(i)*sin(2*pi*F(i)*t+Phase(i));
    subplot(5,1,i)
    plot(x(i,:))
    xlim([0 4000])
end
%combined wave with the average of the other sine waves. 
y = mean(x,1);
subplot(5,1,5)
plot(y)
xlim([0 4000])
title('combined wave');
%im unable to recognize the different waves in the combined wave 
%using fast fourier transform to recover info in the combined wave plot
% Perform Fourier Transform on the combined wave to recover the other waves
figure;
fs = 1 / (t(2) - t(1));  % Sampling frequency
n = length(y);  % Number of samples
frequencies = linspace(0, fs/2, n/2 + 1);  % Frequency axis

% Compute Fourier Transform and plot the magnitude spectrum
fft_y = fft(y);
magnitude_spectrum = abs(fft_y(1:n/2 + 1));
plot(frequencies, magnitude_spectrum);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Fourier Transform of Combined Wave');

%Question3: To all of the individual waves, add different amounts of white noise, plot, and
% redo the frequency recovery

