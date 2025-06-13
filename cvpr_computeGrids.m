function all_grid_hist=cvpr_computeGrids(img,G,FUNC,Q)

numofrows  = size(img, 1);
numofcols  = size(img, 2);
GCL = floor(numofcols/G);
GRL = floor(numofrows/G);

all_grid_hist = [];
for i = 1:G
    for j = 1:G
        if i == G
            grid_end_row = numofrows;
        else
            grid_end_row = i*GRL;
        end
        if j == G
            grid_end_col = numofcols;
        else
            grid_end_col = j*GCL;
        end
        if FUNC == 'RGB' 
            grid_hist = cvpr_globalRGBhist(img(((i-1)*GRL + 1):grid_end_row,((j-1)*GCL + 1):grid_end_col,:),Q);
        end
        if FUNC == 'EOH'
            grid_hist = cvpr_eoh(img(((i-1)*GRL + 1):grid_end_row,((j-1)*GCL + 1):grid_end_col,:),Q);
        end
        if FUNC == 'COM'
            grid_hist_c = cvpr_globalRGBhist(img(((i-1)*GRL + 1):grid_end_row,((j-1)*GCL + 1):grid_end_col,:),Q);
            grid_hist_e = cvpr_eoh(img(((i-1)*GRL + 1):grid_end_row,((j-1)*GCL + 1):grid_end_col,:),Q);
            grid_hist = [grid_hist_c,grid_hist_e];
        end    
        all_grid_hist = [all_grid_hist, grid_hist];
    end
end

return;
