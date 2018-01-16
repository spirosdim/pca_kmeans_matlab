
function [centres]=my_minimax(X,K)
%%%initialize the centroids by taking the futhest vectors from each other
%simple implimentation of minimax
%Dimitriadis Spyros 27/5/2017
[N,dim] = size(X); % dataset dimensions

centres = zeros(K,dim);
pX = X;
Dists1 = zeros(N,1);
r = randi(N);
centres(1,:) = pX(r,:); %choose a random feature vector as the 1st centroid
pX(r,:)= []; %remove this vector to continue for the next centroid

for c = 1:K
    for i =1:size(pX,1)
        Dists1(i,1) = norm(pX(i,:) - centres(1,:) );
        [tmp,idx1] = max(Dists1);
    end
end
centres(2,:) =  pX(idx1,:);  %%choose the 2nd centroid
pX(idx1,:)= [];
%choose the next centroid
for C = 2:K-1
    N = size(pX,1);
    Dists1 = zeros(N,c);
    for c = 1:C
        for i =1:N
            Dists1(i,c) = norm(pX(i,:) - centres(c,:) ); %distances between the centroids
        end
    end
    Dm = zeros(N,1);
    for d =1:N
        [minimum,i] = min(Dists1(d,:)); %find the maximum dist 
        Dm(d) = minimum;
    end
    [Dmax, idxm] = max(Dm);
    centres(C+1,:) = pX(idxm,:);
    pX(idxm,:)= [];
end
end
% scatter(centres(:,1), centres(:,2),150, '*')
