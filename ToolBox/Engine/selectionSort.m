function dataOut = selectionSort(data)
    lenD = size(data,2);
    for i=1:lenD
        j = i;
        for k = i:lenD
            if(data{j,1}.Score>data{k,1}.Score)
                j = k;
            end
        end
        tmp = data{i,1};
        data{i,1} = data{j,1};
        data{j,1} = tmp;
     end
dataOut = data;