%PR curve
function [precision_values, recall_values] = evaluate_PRCurve(dst_all, ALLFILES)
    precision_values = zeros(size(dst_all,1), 0);
    recall_values = zeros(size(dst_all,1), 0);
    
    for i = 1:length(dst_all)
        currDst = dst_all(1:i,:);
        [precision_values(i),recall_values(i)] = evaluate_PR(currDst, ALLFILES);
    end

end
