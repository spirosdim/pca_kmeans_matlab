%%%  Principal Component Analysis (PCA) on data
% [EV,PC]=my_PCA(data) returned dim x 1 vector EV contains the eigenvalues,
% a matrix dim x dim PC  the principal components, i.e. eigenvectors
% and the principal subspace, a matrix N x dim, PC_data.
% Dimitriadis Spyros 7/5/2017

function [EV,PC,PC_Data,x_mean] = my_PCA(data)

%PCA preprocessing - mean normalization
% Calculate the mean for each column i.e. dimention
x_mean = mean(data, 1);
% Mean shift the original matrix
data = bsxfun(@minus, data, x_mean);    %mean normalization: X = (X - mean(X))./std(X)

% Compute covariance matrix of Data
covar_m = cov(data);

% find the eigenvectors and eigenvalues
% PC are the principal components, i.e. eigenvectors
% and EV are the corresponding eigenvalues
[PC, EV] = eig(covar_m);

% extract diagonal of matrix as vector
EV = diag(EV);

% sort the variances in decreasing order
[tmp, idx] = sort(EV, 1, 'descend');
EV = EV(idx,1);
PC = PC(:,idx);

% Transform the original data X to the principal subspace
PC_Data = data * PC;
end