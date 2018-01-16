%%%Gaussian Naive Bayes Classifier
%Implimentation in MNIST
%Dimitriadis Spyros  21/5/2017
load('M'); load('Ltr');  load('N'); load('Lte');
M5 = [M(1:500,:,1); M(1:500,:,2); M(1:500,:,3); M(1:500,:,4)]; % 2000x784
Ltr5 = [Ltr(1:500,1); Ltr(1:500,2); Ltr(1:500,3); Ltr(1:500,4)];   % 2000x1

% M5 = [M(:,:,1); M(:,:,2); M(:,:,3); M(:,:,4)];  %These are for the whole dataset
% Ltr5 = [Ltr(:,1); Ltr(:,2); Ltr(:,3); Ltr(:,4)];

K = 4; %classes

%PCA to the training set
V=60;  % chose V the number of dimensions you want i.e. number of the eigenvectors
%call the function my_PCA
 [EV,PC,PC_M5] = my_PCA(M5);
% [PC,PC_M5,EV] = pca(M5);  %build in function of PCA
M55 = PC_M5(:,1:V);

%%% Visualize in 1 Dimension  for V=1
% x0=M55(1:500,1);
% x1=M55(501:1000,1);
% x2=M55(1001:1500,1);
% x3=M55(1501:2000,1);
% figure
% histfit(x0)
% hold on
% histfit(x1)
% hold on
% histfit(x2)
% hold on
% histfit(x3)
% hold on

%compute the mean and the variance for each feature and each  class
m = zeros(V,K);
s = zeros(V,K);
q = size(M5,1)/K;
l=1; k=q;
for j=1:K
    for i=1:V
        m(i,j) = mean(M55(l:k,i));   %mean
        s(i,j) = std(M55(l:k,i));    %standard deviation
    end
    l = l+q;
    k= k+q;
end

%%%Test in train set
[n1,n2] =size(M55);
perFeature = zeros(n1,V,K);
for j=1:K
    for i=1:V
        perFeature(:,i,j)= normpdf(M55(:,i),m(i,j),s(i,j));
    end
end

naive_probs=zeros(n1,K);
for j=1:K
    for l=1:n1
        naive_probs(l,j)=prod(perFeature(l,:,j));
    end
end

%Accuracy
sam = 0;
idx=zeros(n1,1);
for l=1:n1
    [temp,idx(l)]=max(naive_probs(l,:));
    if idx(l) == Ltr5(l) + 1
        sam = sam+1;
    end
end
Accuracy_train_set =  sam/ numel(Ltr5)
% Ltr5 =Ltr5+ 1;
% CP = classperf(Ltr5, idx); %build class preformance



%%%Test in test set
% N5 = [N(1:200,:,1); N(1:200,:,2); N(1:200,:,3); N(1:200,:,4)];   % 800x784
% Lte5 = [Lte(1:200,1); Lte(1:200,2); Lte(1:200,3); Lte(1:200,4)];   % 800x1

N5 = [N(:,:,1); N(:,:,2); N(:,:,3); N(:,:,4)];   % 4000x784
Lte5 = [Lte(:,1); Lte(:,2); Lte(:,3); Lte(:,4)];   % 4000x1



%PCA preprocessing - mean normalization
% Calculate the mean for each column i.e. dimention
x_mean = mean(M5, 1);
% Mean shift the original matrix
N5 = bsxfun(@minus, N5, x_mean);    %i.e.  N5 = (N5 - mean(N5))./std(N5);
% %prepare the test set, using the same eigenvectors as in  train set
[n,d]=size(N5);
PC_N5 = N5 * PC;
N5 = PC_N5(:,1:V);

%test
perFeature = zeros(n,V,K);
for j=1:K
    for i=1:V
        perFeature(:,i,j)= normpdf(N5(:,i),m(i,j),s(i,j));
    end
end

naive_probs=zeros(n,K);
for j=1:K
    for l=1:n
        naive_probs(l,j)=prod(perFeature(l,:,j));
    end
end

%Accuracy
sam = 0;
idx=zeros(n,1);
for l=1:n
    [temp,idx(l)]=max(naive_probs(l,:));
    if idx(l) == Lte5(l) + 1
        sam = sam+1;
    end
end
Accuracy_test_set =  sam/ numel(Lte5)
