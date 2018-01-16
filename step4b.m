load('M'); load('Ltr');
M4 = [M(1:500,:,1); M(1:500,:,2); M(1:500,:,3); M(1:500,:,4)]; % 2000x784
Ltr4 = [Ltr(1:500,1); Ltr(1:500,2); Ltr(1:500,3); Ltr(1:500,4)];   % 2000x1

% M4 = [M(:,:,1); M(:,:,2); M(:,:,3); M(:,:,4)];  %These are for the whole dataset
% Ltr4 = [Ltr(:,1); Ltr(:,2); Ltr(:,3); Ltr(:,4)];

% shuffle the rows of the  two matrices with the same order
numberOfRows = size(M4, 1);  % Find out how many rows we need to randomize.
newRowOrder = randperm(numberOfRows);   % Get a new order for the rows.
data = M4(newRowOrder, :);    % Apply that order to both arrays.
Labels = Ltr4(newRowOrder, :);
 [N dim] = size(data); % number of obseravations & dimensions

%call the function my_PCA
[EV,PC,PC_data] = my_PCA(data);

% %plot the ë eigenvalues
% plot(EV)  
% xlabel('Number of the eigenvalues');
% ylabel('The value of eigenvalue');
 
% chose V the number of dimensions you want i.e. number of the eigenvectors
V=60;

PC_data = PC_data(:,1:V);
K=4;
%call the function my_kmeans
[idx,centres]=my_kmeans(PC_data,K);

%evaluate k-means with purity
 Purity =  sum(idx' -1 == Labels) / numel(Labels);
 perc=100*Purity;
 disp(['Purity ', num2str(perc), '%'])

% % plot and show the data in clusters
% figure
% for c = 1:K
%     scatter(PC_data(idx==c,1),PC_data(idx==c,2),100,'.');  %dataset
%     hold on;
%     scatter(centres(c,1), centres(c,2),'k*');   %centres
% end
