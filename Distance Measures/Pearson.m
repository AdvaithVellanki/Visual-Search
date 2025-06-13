function dst = Pearson(F1,F2)
% Pearson Correlation Coefficient measures the linear correlation between
% the two sets of data

%% Manually calculating the coefficient:
%Calculate the mean of both F1 and F2
mean_F1=mean(F1);
mean_F2=mean(F2);

%Calculating covariance:
cov=sum((F1-mean_F1) .* (F2-mean_F2));

%Calculating the product of standard deviations:
stddev_F1=sum((F1-mean_F1).^2);
stddev_F2=sum((F2-mean_F2).^2);

%Calculating the pearson correlation coefficient:
correlation_coefficient=cov / sqrt(stddev_F1*stddev_F2);

%Calculating the distance:
dst=1-correlation_coefficient;

return;

