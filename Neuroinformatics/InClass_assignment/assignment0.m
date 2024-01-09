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

y = mean(x,1);
subplot(5,1,5)
plot(y)
xlim([0 4000])
%
