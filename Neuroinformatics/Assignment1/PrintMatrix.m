% Chapter 4 of ANTS
% Question 1
% creating a matrix of random numbers and then looping through them to find
% elements that are greater than 0.5 but also naming/indexing the ith jth
% positions element via its row and column name. but also adding st, nd and
% rd for 1st, 2nd and 3rd positions
% Next add the entire code in function so that you can call it out in the
% command window 

function matrix = PrintMatrix(rows,columns)

    
    matrix = rand(rows,columns)
    
    for row = 1:rows
        for column = 1:columns
            i = matrix(row, column);
    
            % Change row suffix
            row_num_suffix = 'th';
            if row == 1
                row_num_suffix = 'st';
            elseif row == 2
                row_num_suffix = 'nd';
            elseif row == 3
                row_num_suffix = 'rd';
            end
    
            % Change column suffix
            column_num_suffix = 'th';
            if column == 1
                column_num_suffix = 'st';
            elseif column == 2
                column_num_suffix = 'nd';
            elseif column == 3
                column_num_suffix = 'rd';
            end
    
            % Print to console
            if i > 0.5
                fprintf('The %d %s row and %d %s column has a value of %d and is bigger than 0.5 \n', row, row_num_suffix, column, column_num_suffix, i);
            end
            if i < 0.5
                fprintf('The %d %s row and %d %s column has a value of %d and is smaller than 0.5 \n', row, row_num_suffix, column, column_num_suffix, i);
            end
        end
    end
end

