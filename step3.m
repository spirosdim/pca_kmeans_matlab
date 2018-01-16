load('M3'); load('Ltr3');
%choose 500 from each class to vizualize better
Labels0 =  [Ltr3(1:500,:); Ltr3(5001:5500,:); Ltr3(10001:10500,:); Ltr3(15001:15500,:)];
data0 = [M3(1:500,:); M3(5001:5500,:); M3(10001:10500,:); M3(15001:15500,:)];

% shuffle the rows of the  two matrices with the same order
numberOfRows = size(data0, 1);  % Find out how many rows we need to randomize.
newRowOrder = randperm(numberOfRows);   % Get a new order for the rows.
data = data0(newRowOrder, :);    % Apply that order to both arrays.
Labels = Labels0(newRowOrder, :);

A = data;
K = 4;
%call the function my_kmeans
[idx,centres]=my_kmeans(A,K);

%evaluate k-means with purity
Purity =  sum(idx' -1 == Labels) / numel(Labels);
perc=100*Purity;
disp(['Purity ', num2str(perc), '%'])


% plot and show the data in clusters
figure
for c = 1:K
    scatter(A(idx==c,1),A(idx==c,2),100,'.');  %dataset
    hold on;
    scatter(centres(c,1), centres(c,2),'k*');   %centres
end
