load('M');  load('N');  load('Ltr');  load('Lte');

Mm = zeros(5000, 2);
Nn = zeros(5000, 2);
Kk =  zeros(5000, 2);
Hh =  zeros(5000, 2);
for n = 1:4   %for all 0s, 1s, 2s, 3s
    for j = 1:500   %for all the 0s, 1s, 2s, 3s      
        l = 1;
        k = 28;
        pic = zeros(28);
        for i = 1:28
            pic(:, i) = M(j, l:k,n);   %the pic in a 28x28 matrix
            l = l + 28;
            k = k+28;
        end
        %%imshow(pic)  %you can vizualize the image of the number
        x= mean(pic,2);  %means of rows
        y= mean(pic',2); %means of columns
        if n == 1
            Nn(j,1) = skewness(x);
            Nn(j,2) = kurtosis(y);
        elseif n == 2
            Kk(j,1) = skewness(x) ;
            Kk(j,2) =kurtosis(y);
        elseif  n ==3
            Mm(j,1) = skewness(x) ;
            Mm(j,2) =kurtosis(y) ;
        else
            Hh(j,1) =  skewness(x);
            Hh(j,2) = kurtosis(y);
        end
    end
end

%choose 500 from each class to have better vizualization
x0 = Nn(1:500,1);    y0 = Nn(1:500,2);
x1 = Kk(1:500,1);    y1 = Kk(1:500,2);
x2 = Mm(1:500,1);  y2 = Mm(1:500,2);
x3 = Hh(1:500,1);    y3 = Hh(1:500,2);

%Visualization
figure
scatter(x0,y0,100,'.');  hold on;
scatter(x1,y1,100,'.'); hold on;
scatter(x2,y2,100, '.'); hold on;
scatter(x3,y3,100,'.');
legend('0','1','2','3');
xlabel('skewness');
ylabel('kurtosis');

%save the train set and the labels to the matrices M3 and Ltr3 respectively
M3 = [Nn; Kk; Mm; Hh];
Ltr3 = [Ltr(1:5000,1); Ltr(1:5000,2); Ltr(1:5000,3); Ltr(1:5000,4)];
save('M3.mat', 'M3')
save ('Ltr3.mat', 'Ltr3')