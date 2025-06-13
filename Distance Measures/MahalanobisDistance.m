function dst=MahalanobisDistance(F1, F2, ALLFEATURE)

% This function should compare F1 to F2 - i.e. compute the distance
% between the two descriptors via Mahalanobis distance
% Find the Eigenvalue of the features
t=ALLFEATURE';
e=Eigen_Build(t);
v=e.val;
% Subtract each element of feature F1 from feature F2
x=F1-F2;
% Square these differences and divide with eigenvalues (for all row elements)
x=x.^2./v(1:size(v,2));
% Sum up the square differences
x=sum(x);C
% Take the square root
dst=sqrt(x);

return;
