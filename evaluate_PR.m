
function [precision, recall]=evaluate_PR(dst, ALLFILES)
    instance_per_class = [30,30,30,30,30,30,30,30,30,32,30,34,30,30,24,30,30,30,30,21];
    
    class = zeros(size(dst,1), 0);
    for i = 1:size(dst,1)
     
        path_name = ALLFILES{dst(i,2)};
        class(i) = getClass(path_name);
    end
    
    Q_Class = class(1);
    label_arr_temp = class;
    
    label_arr_temp(label_arr_temp ~= Q_Class) = 0;
    label_arr_temp(label_arr_temp == Q_Class) = 1;
    
    precision = (sum(label_arr_temp)) / length(label_arr_temp);
    recall = (sum(label_arr_temp)) / instance_per_class(Q_Class); % Each class has 20 items    
end

function class = getClass(path)
    indx = strfind(path,'/');
    index = indx(length(indx));
    name = path(index+1:end);
    
   
    indx = strfind(name,'_');
    class_name = name(1:indx(1)-1);
    class = str2double(class_name);
end

