function H=cvpr_eoh(img,Q)

img = double(rgb2gray(img));
sobel_xfilter = [-1,0,1;-2,0,2;-1,0,1]; % Sobel filter for horizontal differential
sobel_yfilter = sobel_xfilter'; % Sobel filter for vertical differential
img_xdiff = filter2(sobel_xfilter,img); % perform convolution to find df/dx  
img_ydiff = filter2(sobel_yfilter,img); % perform convolution to find df/dy  

img_mag = sqrt(img_xdiff.^2 + img_ydiff.^2); % compute magnitude
r=size(img_mag,1);
c=size(img_mag,2);
img_mag(1,:) = 0;
img_mag(r,:) = 0;
img_mag(:,1) = 0;
img_mag(:,c) = 0;
img_mag_max = max(max(img_mag));
img_mag_norm = img_mag./img_mag_max; % normalise
img_mag_high_ind = ceil(img_mag_norm - .20);

img_theta = atan2(img_ydiff, img_xdiff);
img_theta_vals=reshape(img_theta,1,size(img_theta,1)*size(img_theta,2));
img_mag_high_ind_vals=reshape(img_mag_high_ind,1,size(img_mag_high_ind,1)*size(img_mag_high_ind,2));
img_theta_vals_sel = [];
for i=1:(size(img_theta_vals,2))
    if img_mag_high_ind_vals(1,i) == 1
            img_theta_vals_sel = [img_theta_vals_sel,img_theta_vals(1,i)];
    end
end
img_theta_max = max(max(img_theta_vals_sel));
img_theta_vals_sel_norm = img_theta_vals_sel./img_theta_max;
img_theta_quanta_vals = floor(abs(img_theta_vals_sel_norm).*Q);

% Now we can use hist to create a histogram of Q^3 bins.
% H = hist(img_theta_quanta_vals,Q);
H = hist(img_theta_quanta_vals,Q);
% H = hist(img_theta_quanta_vals_sel,Q);
% It is convenient to normalise the histogram, so the area under it sum
% to 1.
H = H ./sum(H);
return;
