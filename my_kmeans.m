function [idx,centres]=my_kmeans(A,K)
%%%  k-means clustring with maximin algorithm to initialize the centroids
 %[idx, centres] = k_means(X, K) returned N x 1 vector idx contains the cluster indices of each point
%and the K clusters centroids locations in the K x dim matrix, centres.
%Dimitriadis Spyros  23/4/2017

[N dim] = size(A); % dataset dimensions


% initial cluster centres  PICK RANDOM POINTS
centres = zeros(K,dim);
for k=1:K
x = randi(N);
centres(k,:) =  A(x,:);  
end

% %call the function my_minimax to initialize the centroids
% [centres]=my_minimax(A,K);


% % fprintf('[0] Iteration: ')
% % centres % show cluster centres at iteration 0
maxiter = 100; % Maximum number of iterations
D = zeros(K, N); % KxN matrix for storing distances between cluster centres and observations
idx_prev=centres;
% Iterate ’maxiter’ times
for i = 1:maxiter
    % Compute Squared Euclidean distance
    % between each cluster centre and each observation
    for c = 1:K
        D(c,:) = squared_Eucl(A, centres(c,:)); %Squared Euclidean distance
        % D(c,:) = kl_div(A, centres(c,:));   %myKullback-Leibler divergence
    end
    % Assign data to clusters
    [Ds, idx] = min(D); % find min dist. for each observation
    
    % Update cluster centres
    for c = 1:K
        centres(c, :) = mean( A(idx==c,:) );
    end
    
    %break the loop if the centres are not changed
    if idx_prev ==centres
        break
    end
    idx_prev = centres;
    
    % %     fprintf('[%d] Iteration: ', i)
    % %     centres % show cluster centres at iteration i
end

end