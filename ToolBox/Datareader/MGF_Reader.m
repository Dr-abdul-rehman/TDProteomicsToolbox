function Files=MGF_Reader(directory, fileName)

inputfile = fopen(strcat(strcat(directory,'\'),fileName));
FileNameIndex = 0;
while ~feof(inputfile)
    data=fgetl(inputfile);
    if(length(data)>2)
        FileNameIndex=FileNameIndex+1;
        if(data == -1)
            break
        end
        
        
            data1='BEGIN IONS';
            
               while(~(strcmp(data,data1)))
                    data=fgetl(inputfile);
                end
            
           
       
        dlmwrite(strcat(strcat(strcat(directory,'\',fileName), num2str(FileNameIndex)),'.txt'),'','delimiter','');
        data3='PEPMASS=';
        while(isempty(findstr(data,data3)))
            data=fgetl(inputfile);
        end
        data1=data(9:end);
        data1 = strcat(data1,{' '},'1');
        str = data;
        str(str==' ') = '';
        str(str=='.') = '';
        A = isstrprop(str, 'digit');
        check = all(A(:));
        
        while(~check)
            data=fgetl(inputfile);
            str = data;
            str(str==' ') = '';
            str(str=='.') = '';
            A = isstrprop(str, 'digit');
            check = all(A(:));
            if(~isempty(findstr(data,'CHARGE')))
                data1 =  strcat(strcat(data1,{' '}),data(8));
            end
        end
        dlmwrite(strcat(strcat(strcat(directory,'\',fileName), num2str(FileNameIndex)),'.txt'),data1,'delimiter','','newline', 'pc');
        data1='END IONS';
        while(~strcmp(data,data1))
            dlmwrite(strcat(strcat(strcat(directory,'\',fileName), num2str(FileNameIndex)),'.txt'),data,'-append','delimiter','','newline', 'pc');
            data=fgetl(inputfile);
        end
    end
end

%close all
