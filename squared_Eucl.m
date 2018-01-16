function sq_Eucl = squared_Eucl(DATA, centroid)
% Compute 1 x N row vector of square distances for N x dim and 1 x dim DATA and centroid, respectively.
sq_Eucl = sum(bsxfun(@minus, DATA, centroid).^2, 2)';
end