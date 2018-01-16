%%%just vizualize in 2 dimentions after PCA
load('M'); load('Ltr');
M4 = [M(1:500,:,1); M(1:500,:,2); M(1:500,:,3); M(1:500,:,4)];
Ltr4 = [Ltr(1:500,1); Ltr(1:500,2); Ltr(1:500,3); Ltr(1:500,4)];

% shuffle the rows of the  two matrices with the same order
numberOfRows = size(M4, 1);  % Find out how many rows we need to randomize.
newRowOrder = randperm(numberOfRows);   % Get a new order for the rows.
data = M4(newRowOrder, :);    % Apply that order to both arrays.
Labels = Ltr4(newRowOrder, :);
[N dim] = size(data); % number of obseravations & dimensions

%call the function my_PCA
 [EV,PC,PC_data] = my_PCA(data);
 
% chose V the number of dimensions you want i.e. number of the eigenvectors
V=2;

%scatter Labeled the dataset after PCA 
for i=1:N
    if Labels(i,1) ==  0
        scatter(PC_data(i,1),PC_data(i,2),100,'g.');  %dataset
        hold on;
    elseif  Labels(i,1) ==  1
        scatter(PC_data(i,1),PC_data(i,2),100,'r.');
        hold on;
    elseif Labels(i,1) ==  2
        scatter(PC_data(i,1),PC_data(i,2),100,'b.');
        hold on;
    else
        scatter(PC_data(i,1),PC_data(i,2),100,'m.');
        hold on;
    end
end
legend('0','1','2','3');
xlabel('1st Principal Component');
ylabel('2nd Principal Component');

