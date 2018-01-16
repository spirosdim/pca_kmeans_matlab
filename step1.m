% load training set and testing set
train_set = loadMNISTImages('train-images.idx3-ubyte')';
train_label = loadMNISTLabels('train-labels.idx1-ubyte');
test_set = loadMNISTImages('t10k-images.idx3-ubyte')';
test_label = loadMNISTLabels('t10k-labels.idx1-ubyte');

train_size = size(train_set);
n = train_size(1); % number of training samples
d = train_size(2); % dimension of feature vector, 784pixels
j = [1,1,1,1];  %j(1)=number of 0s  |   j(2)=number of 1s  in the train set
k = [1,1,1,1];
%make the M &N Matrixes
for i = 1:n
    if train_label(i,1) == 0
        M(j(1), :, 1 ) =   train_set(i, :);
        Ltr(j(1),1) = 0;
        j(1) = j(1) + 1;
    end
    if train_label(i,1) == 1
        M(j(2), :,2 ) =   train_set(i, :);
        Ltr(j(2),2) = 1;
        j(2) = j(2) + 1;
    end
    if train_label(i,1) == 2
        M(j(3), :, 3 ) =   train_set(i, :);
        Ltr(j(3),3) = 2;
        j(3) = j(3) + 1;
    end
    if train_label(i,1) == 3
        M(j(4), :, 4 ) =   train_set(i, :);
        Ltr(j(4),4) = 3;
        j(4) = j(4) + 1;
    end
    
    if i<=10000
        if train_label(i,1) == 0
            N(k(1), :, 1 ) =   test_set(i, :);
            Lte(k(1),1) = 0;
            k(1) = k(1) + 1;
        end
        if train_label(i,1) == 0
            N(k(2), :, 2 ) =   test_set(i, :);
            Lte(k(2),2) = 1;
            k(2) = k(2) + 1;
        end
        if train_label(i,1) == 0
            N(k(1), :, 3 ) =   test_set(i, :);
            Lte(k(3),3) = 2;
            k(3) = k(3) + 1;
        end
        if train_label(i,1) == 0
            N(k(4), :, 4 ) =   test_set(i, :);
            Lte(k(4),4) = 3;
            k(4) = k(4) + 1;
        end
    end
    
end

M = M(1:5000,:,:);     %M   5000x784x4
Ltr = Ltr(1:5000,:);     %Ltr  5000x4
N = N(1:1000,:,:);       %N   1000x784x4
Lte = Lte(1:1000,:);    %Lte  1000x4


save ('M.mat', 'M')
save ('N.mat', 'N')
save ('Ltr.mat', 'Ltr')
save ('Lte.mat', 'Lte')



        
        