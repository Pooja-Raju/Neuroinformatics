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

[h,p,ci,stats] = ttest2(x,y)

%Question2:Creating 4 individuals sine waves and a combined wave 
%sampling frequency
Fs = 1000;
t = [0:0.1:2*pi]
a = sin(t);
plot(t,a)

A = sin(2*pi*2*t)
plot(A)
