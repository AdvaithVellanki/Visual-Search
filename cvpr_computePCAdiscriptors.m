%% EEE3032 - Computer Vision and Pattern Recognition (ee3.cvpr)
%%
%% cvpr_computedescriptors.m
%% Skeleton code provided as part of the coursework assessment
%% This code will iterate through every image in the MSRCv2 dataset
%% and call a function 'extractRandom' to extract a descriptor from the
%% image.  Currently that function returns just a random vector so should
%% be changed as part of the coursework exercise.
%%
%% (c) John Collomosse 2010  (J.Collomosse@surrey.ac.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

%% Separate script to compute the Descriptors and perform PCA on them
%% and store them in different folders.

close all;
clear all;
%% Specify the "DESCRIPTOR" used to extract the descriptor from the image.
%% Also specify the parameters if required any for each method.
%% 1) Global Histogram
 %DESCRIPTOR = '0';
 %QUANTIZATION_NO = 4;

%% 2) Colour Moments Descriptor
 %DESCRIPTOR = '1';

%% 3) Grid level RGB histograms
 %DESCRIPTOR = '2';
 %GRIDFACTOR = 4;
 %FUNC = 'RGB';
 %QUANTIZATION_NO = 4;

%% 4) Grid level edge orientation histograms 
 DESCRIPTOR = '3';
 GRIDFACTOR = 4;
 FUNC = 'EOH';
 QUANTIZATION_NO = 4;

%% 5) Grid level RGB and edge orientation histograms (combined)
%DESCRIPTOR = '4';
%GRIDFACTOR = 4;
%FUNC = 'COM';
%QUANTIZATION_NO = 6;

% Define a matrix to store PCA features
ALLFEAT=[];
%% Edit the following line to the folder you unzipped the MSRCv2 dataset to
DATASET_FOLDER = '~/Advaith_Vellanki_CVPR_Coursework/MSRC_ObjCategImageDatabase_v2';

%% Create a folder to hold the results...
OUT_FOLDER = '~/Advaith_Vellanki_CVPR_Coursework/descriptors';
%% and within that folder, create another folder to hold these descriptors
%% the idea is all your descriptors are in individual folders - within
%% the folder specified as 'OUT_FOLDER'.
OUT_SUBFOLDER=''; 

if (DESCRIPTOR == '0')      %Storing the descriptors in their respective folders
    OUT_SUBFOLDER='globalRGBhistoPCA';
end

if (DESCRIPTOR == '1')
    OUT_SUBFOLDER='colourMomentPCA';
end

if (DESCRIPTOR == '2')
    OUT_SUBFOLDER='gridRGBhistoPCA';
end

if (DESCRIPTOR == '3')
    OUT_SUBFOLDER='gridEOhistoPCA';
end

if (DESCRIPTOR == '4')
    OUT_SUBFOLDER='gridRGBEOhistoPCA';
end

allfiles=dir (fullfile([DATASET_FOLDER,'/Images/*.bmp']));
for filenum=1:length(allfiles)
    fname=allfiles(filenum).name;
    fprintf('Processing file %d/%d - %s\n',filenum,length(allfiles),fname);
    tic;
    imgfname_full=([DATASET_FOLDER,'/Images/',fname]);
    img=double(imread(imgfname_full))./255;
    fout=[OUT_FOLDER,'/',OUT_SUBFOLDER,'/',fname(1:end-4),'.mat'];%replace .bmp with .mat
    if (DESCRIPTOR == '0')
        F=cvpr_globalRGBhist(img,QUANTIZATION_NO);
    end
    if (DESCRIPTOR == '1')
        F=ColourMoment(img);
    end
    if (DESCRIPTOR == '2')
        F=cvpr_computeGrids(img,GRIDFACTOR,FUNC,QUANTIZATION_NO);
    end
    if (DESCRIPTOR == '3')
        F=cvpr_computeGrids(img,GRIDFACTOR,FUNC,QUANTIZATION_NO);
    end
    if (DESCRIPTOR == '4')
        F=cvpr_computeGrids(img,GRIDFACTOR,FUNC,QUANTIZATION_NO);
    end
    % Using PCA first store descriptor information into ALLFEAT
    ALLFEAT=[ALLFEAT ; F];
    toc
end

% Build the PCA for each image and choose the dimension
% as third parameter in Eigen_Deflate
ALLFEAT=ALLFEAT';
e=Eigen_Build(ALLFEAT);
e=Eigen_Deflate(e,'keepn',9);
ALLFEATPCA=Eigen_Project(ALLFEAT,e)';


% Store the PCA information for descriptors
for filenum=1:length(allfiles)
    fname=allfiles(filenum).name;
    fprintf('Processing file %d/%d - %s\n',filenum,length(allfiles),fname);
    tic;
    imgfname_full=([DATASET_FOLDER,'/Images/',fname]);
    img=double(imread(imgfname_full))./255;
    fout=[OUT_FOLDER,'/',OUT_SUBFOLDER,'/',fname(1:end-4),'.mat'];%replace .bmp with .mat
    F=ALLFEATPCA(filenum,:);
    save(fout,'F');
    toc
end