%% EEE3032 - Computer Vision and Pattern Recognition (ee3.cvpr)
%%
%% cvpr_visualsearch.m
%% Skeleton code provided as part of the coursework assessment
%%
%% This code will load in all descriptors pre-computed (by the
%% function cvpr_computedescriptors) from the images in the MSRCv2 dataset.
%%
%% It will pick a descriptor at random and compare all other descriptors to
%% it - by calling cvpr_compare.  In doing so it will rank the images by
%% similarity to the randomly picked descriptor.  Note that initially the
%% function cvpr_compare returns a random number - you need to code it
%% so that it returns the Euclidean distance or some other distance metric
%% between the two descriptors it is passed.
%%
%% (c) John Collomosse 2010  (J.Collomosse@surrey.ac.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

close all;
clear all;

%% Select which 'DISTANCE' you want to calculate:
%DISTANCE = 'EUCLIDEAN';
DISTANCE = 'MANHATTAN';
%DISTANCE = 'MAHALANOB';
%DISTANCE = 'PEARSONCO';
%DISTANCE = 'COSINESIM';


%% Edit the following line to the folder you unzipped the MSRCv2 dataset to
DATASET_FOLDER = '~/Advaith_Vellanki_CVPR_Coursework/MSRC_ObjCategImageDatabase_v2';

%% Folder that holds the results...
DESCRIPTOR_FOLDER = '~/Advaith_Vellanki_CVPR_Coursework/descriptors';
%% and within that folder, another folder to hold the descriptors
%% we are interested in working with

%% Below are the Descriptors before PCA
%DESCRIPTOR_SUBFOLDER='globalRGBhisto';
%DESCRIPTOR_SUBFOLDER='colourMoment';
%DESCRIPTOR_SUBFOLDER='gridRGBhisto';
%DESCRIPTOR_SUBFOLDER='gridEOhisto';
DESCRIPTOR_SUBFOLDER='gridRGBEOhisto';

%% Below are the Descriptors after PCA
%DESCRIPTOR_SUBFOLDER='globalRGBhistoPCA';
%DESCRIPTOR_SUBFOLDER='colorMomentPCA';
%DESCRIPTOR_SUBFOLDER='gridRGBhistoPCA';
%DESCRIPTOR_SUBFOLDER='gridEOhistoPCA';
%DESCRIPTOR_SUBFOLDER='gridRGBEOhistoPCA';



%% 1) Load all the descriptors into "ALLFEAT"
%% each row of ALLFEAT is a descriptor (is an image)

ALLFEAT=[];
ALLFILES=cell(1,0);
ctr=1;
allfiles=dir (fullfile([DATASET_FOLDER,'/Images/*.bmp']));
for filenum=1:length(allfiles)
    fname=allfiles(filenum).name;
    imgfname_full=([DATASET_FOLDER,'/Images/',fname]);
    img=double(imread(imgfname_full))./255;
    thesefeat=[];
    featfile=[DESCRIPTOR_FOLDER,'/',DESCRIPTOR_SUBFOLDER,'/',fname(1:end-4),'.mat'];%replace .bmp with .mat
    load(featfile,'F');
    ALLFILES{ctr}=imgfname_full;
    ALLFEAT=[ALLFEAT ; F];
    ctr=ctr+1;
end

%% 2) Pick an image at random to be the query

NIMG=size(ALLFEAT,1);           % number of images in collection
%queryimg=floor(rand()*NIMG); %index of a random image
%queryimg=364; %trees
%queryimg=502; %cars
%queryimg=101; %bookshelf
%queryimg=417; %plane
%queryimg=225; %Buildings
queryimg=533; %cycles 


%% 3) Compute Eigen Model to calculate Eigen Vectors for Mahalanobis Distance
%e = Eigen_Build(ALLFEAT');
%v=e.val;

%% 4) Compute the distance of image to the query
dst=[];
for i=1:NIMG
    candidate=ALLFEAT(i,:);
    query=ALLFEAT(queryimg,:);
    %figure(1);
    %imgshow(imread(ALLFILES{queryimg}));
    if DISTANCE == 'EUCLIDEAN'
        thedst=Euclidean(query,candidate);
    end
    if DISTANCE == 'MANHATTAN'
       x=query - candidate;
       x=abs(x);
       thedst=sum(x);
    end
    if DISTANCE == 'MAHALANOB' %Use when one of the PCA Descriptors are selected
       thedst=MahalanobisDistance(query,candidate,ALLFEAT);
    end
    if DISTANCE == 'PEARSONCO'
        thedst=Pearson(query, candidate);
    end
    if DISTANCE == 'COSINESIM'
        thedst=Cosinesim(query, candidate);
    end
    dst=[dst ; [thedst i]];
end
dst=sortrows(dst,1);  % sort the results
dst_all=dst;



%% 5) Visualise the results
%% These may be a little hard to see using imgshow
%% If you have access, try using imshow(outdisplay) or imagesc(outdisplay)

SHOW=10; % Show top 10 results
dst=dst(1:SHOW,:);
outdisplay=[];
for i=1:size(dst,1)
   img=imread(ALLFILES{dst(i,2)});
   img=img(1:2:end,1:2:end,:); % make image a quarter size
   img=img(1:81,:,:); % crop image to uniform size vertically (some MSVC images are different heights)
   outdisplay=[outdisplay img];
end
figure(2);
imshow(outdisplay);
axis off;

%% 6) Precision-Recall:
% Used to evaluate the results

[precision, recall] = evaluate_PR(dst, ALLFILES);
[fullPrecision, fullRecall]= evaluate_PRCurve(dst_all, ALLFILES);
fprintf("Precision: %f", precision);
fprintf("\nRecall: %f\n",recall);
figure()
axis on;

plot(fullRecall, fullPrecision)
xlabel('Recall');
ylabel('Precision');
title('Precision Recall Curve for Image', queryimg);
clear all;

