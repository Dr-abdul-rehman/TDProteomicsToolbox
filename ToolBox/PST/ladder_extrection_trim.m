%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           LUMSProT: A MATLAB Toolbox for Top-down Proteomics     %
%                            Version 1.0.0                         %
%        Copyright (c) Biomedical Informatics Research Laboratory, %
%          Lahore University of Management Sciences Lahore (LUMS), %
%                           Pakistan.                              %
%                    (http://birl.lums.edu.pk) 	                   %
%                     (safee.ullah@gmail.com)                      %
%                    Last Modified on: 4-May-2016                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This Function is used for the Extrection and the Triming of the Peptide
%% Sequece tag. It will also remove any duplicate entry present in the list
function Ladder =  ladder_extrection_trim(Ladder_raw,User_max_TagLength_Threshold)

for laddering = 1: size(Ladder_raw,1) %% Find and remove the Ledder which violate Maximum length condition
    if ((size(Ladder_raw{laddering,1},1)) > User_max_TagLength_Threshold)  
        Ladder_raw{laddering,1} = [];
        
    end
end
Ladder_raw = Ladder_raw(~cellfun('isempty',Ladder_raw)); % trim the ladder cell array

% Break the larger Tags into every possible way and get any tag possible
length_tags=0;
for laddering = 1: size(Ladder_raw,1)
    for startindex  = 1 : (size(Ladder_raw{laddering,1},1))
        for endindex = startindex : (size(Ladder_raw{laddering,1},1))
            length_tags = length_tags + 1;
            Ladder{length_tags} = Ladder_raw{laddering,1}(startindex:endindex,:);
        end
    end
end


[dummy, Index] = sort(cellfun('size', Ladder, 1), 'ascend'); %% arrange the ledder in the ascending order of their size
Ladder = Ladder(Index);


% Find all the duplicate tags from the ladder list and only keep the one
% with the lowest Root Mean Square Error (RMSE).
no_of_tag_of_given_size = 0;
inner_index = 1;
for outer_index = 1: User_max_TagLength_Threshold % For every possible length of Tag
    
    no_of_tag_of_given_size = no_of_tag_of_given_size + sum(cellfun('size', Ladder, 1) == outer_index); % Find the end index of a group of specific size
    
    for index = inner_index : no_of_tag_of_given_size-1
        if (~(isempty(Ladder{index})))
            for index1 = index+1 : no_of_tag_of_given_size
                if (~(isempty(Ladder{index1})))
                    Error_sum = 0;
                    Error_sum1 = 0;
                    Tag1 = '';
                    Tag = '';
                    for row = 1: size(Ladder{1,index},1) % for the length of the tag - indicated by rows in one cell
                        Tag1  = strcat(Tag ,Ladder{1,index}{row,6}); % concatenate to get the complete the tag to search it in the protein sequence
                        Tag  =  strcat(Tag ,Ladder{1,index1}{row,6}); % concatenate to get the complete the tag to search it in the protein sequence
                        error1 = Ladder{1,index}{row,8}^2;
                        error = Ladder{1,index1}{row,8}^2;
                        Error_sum1 =  Error_sum1  + error1;
                        Error_sum = Error_sum + error;
                    end
                    if(strcmp(Tag,Tag1))
                        
                        if(Error_sum1 < Error_sum)
                            Ladder{1,index1} = [];
                        else
                            Ladder{1,index} = [];
                        end
                        
                    end
                end
                
            end
        end
        
        inner_index = no_of_tag_of_given_size+1; % This index will start from the start index of the group of specific size
        
    end
end

Ladder = Ladder(~cellfun('isempty',Ladder)); % trim the ladder cell array
end
