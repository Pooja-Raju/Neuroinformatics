% Question2
% get the image of amsterdam from the online matlab github code
% plot a thick red line from “Nieuwmarkt” (near the center of the picture) to “Station Amsterdam Centraal” (near the top of the picture)
% Plot a magenta star over the Waterlooplein metro station (a bit South of Nieuwmarkt)
% Find the maximum value on each color dimension (red, green, or blue) and plot a circle using that color. There may be more than one pixel with a maximum value; if so, pick one pixel at random
% 
% Loading the image

AmsterdamPic = imread('/Users/pooja/Downloads/amsterdam (1).bmp');
figure;
imshow(AmsterdamPic);
title('Amsterdam');
whos AmsterdamPic %understanding the features of the image
axis on; %turned the axis on so that roughly I can figure out the coordinates of the areas on the map
grid on; %turned the grid on 
hold on; %need matlab to help draw things of interest on the current figure and hence hold on command is helping in that 
%from the figure, i roughly calculated the coordinates of the nieuwmarkt
%and amsterdam central then used the respective coordinates to basically
%draw a red line of width 5
line ([370,380],[350,80],'Color', 'red','LineWidth', 5 ); %(line([x1,x2],[y1,y2]......)

WaterloopleinCoords = [390,490]; %using the axis and grids i did the same to obtain the coordinates of waterlooplein 
hold on; %hold on function helping draw the structure of interest on the images
%drawing a magenta * over waterlooplein
plot(WaterloopleinCoords(1), WaterloopleinCoords(2), 'magenta *', 'MarkerSize', 20);
% I actually don't understand the third question one bit about drawing a
% circle with the max values of red, green and blue
% Find the maximum value in each color channel
max_red = max(max(AmsterdamPic(:,:,1)));
max_green = max(max(AmsterdamPic(:,:,2)));
max_blue = max(max(AmsterdamPic(:,:,3)));

% Display the results
disp(['Maximum value in red channel: 'num2str(max_red)]);
disp(['Maximum value in green channel: ' num2str(max_green)]);
disp(['Maximum value in blue channel: ' num2str(max_blue)]);

% Question3, first part is to create a 32X3 matrix using the same function PrintMatrix and then convert the values greater than 0.5 to 1 and return elements that are not greater than 0.5 to 0
% second, write this into a txt file, that contains this 32X3 matrix along
% with appropriate variable labels in the first row and it should be
% de-limited

%creating the matrix
mat = PrintMatrix(32,3);

rows = size(mat, 1);
columns = size(mat,2);
for row = 1:rows
    for column = 1:columns
       if mat(row,column) > 0.5
           mat(row,column) = 1;
       else 
           mat(row,column) = 0;

        end
    end
end

disp(mat)

%creating a text with appropriate variable names
mat = PrintMatrix(32,3)

Result_Table = array2table(mat, 'VariableNames', {'RowIn', 'ColumnIn', 'Result'});
writetable(Result_Table, 'ResultMatrix.txt', 'Delimiter', '\t');

