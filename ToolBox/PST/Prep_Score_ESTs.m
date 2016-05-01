%% This Fuction is used to pepare the PSTs for Protein Specific Scoring
function [Tag_Ladder] = Prep_Score_ESTs(User_Taglength_min_threshold,User_Taglength_max_threshold,User_hop_threshold,User_tagError_threshold )


    Fragments_Peaklist_Data = getappdata(0,'Peaklist_Data');
    size_pkList = size(Fragments_Peaklist_Data,1); % Size/number of the fragments peaks
    % All fragment peaks will be extracted except the mass of the intact protein
    prot_ExperimentalPeakList = sortrows(Fragments_Peaklist_Data(2:size_pkList,:)); 
% % % % % % % % % % %     % Reads the object (from LUMSProT.m) containing peak list intact protein experimental mass
% % % % % % % % % % %     prot_MW_ExperimentalFile = getappdata(0,'Intact_Protein_Mass');
% % % % % % % % % % %     prot_Charge = Fragments_Peaklist_Data(1,2); % prot_Charge = prot.mz(1,2);
    Tag_ladder = {};


% extract ESTs using the find peaks function
addpath(strcat(pwd,'\PST'));

ladder = Extract_PSTs(prot_ExperimentalPeakList,User_Taglength_max_threshold,User_hop_threshold);
if ~isempty(ladder)
    Tag_ladder.Taglength = cellfun('size',ladder,1);               % finding length of tags


    Tags_Error_Array = cell(1,size(ladder,2));
    Tags_Intesnsity_Array = cell(1,size(ladder,2));

    for index = 1:size(Tag_ladder.Taglength,2)
        %%----- filter tags according to user min tag length
        %%threshold----------
        if ((Tag_ladder.Taglength(index) < User_Taglength_min_threshold)||(Tag_ladder.Taglength(index) >  User_Taglength_max_threshold))
            ladder{index} = [];
        end


    end
    ladder = ladder(~cellfun('isempty',ladder)); % trim the ladder cell array


    %%----------- CALCULATING TAG ERROR AND SCORING -------------

    for index = 1: size(ladder,2)

            Error_sum = 0;
            Intensity_sum = 0;
            for index1= 1:size(ladder{1,index},1)
                Intensity_sum = Intensity_sum +ladder{1,index}{index1,9};
                error = ladder{1,index}{index1,8}^2; % square the error
                Error_sum = Error_sum + error; % sum all errors for the tag
            end
            RMSE = sqrt(Error_sum)/size(ladder{1,index},1); % Root Mean Squared Error/# of hops
            Tags_Error_Array{index} = RMSE*10;
            Tags_Intesnsity_Array {index} = Intensity_sum /size(ladder{1,index},1);

    end
    %% --------------- Filter tags according to fulltag error threshold -----
    Tag_ladder.Score_Error = zeros(1,size(Tags_Error_Array,2));

    for index = 1:size(ladder,2)
        if (Tags_Error_Array{index} > User_tagError_threshold)
            ladder{index} = []; % remove that tag from the ladder
            Tags_Error_Array{index} = []; % remove that error from list
            Tags_Intesnsity_Array{index} = [];
        else
    %% ----------- Score tags according to errors --------
    % y = -0.1(x^2) + 0.4   (at error 2.23 the score should be zero)

            Tag_ladder.Score_Error(index) = exp(-Tags_Error_Array{index}*2);
        end
    end

    ladder = ladder(~cellfun('isempty',ladder)); % trim the ladder cell array
    Tags_Intesnsity_Array = Tags_Intesnsity_Array (~cellfun('isempty',Tags_Intesnsity_Array));




    %% -------- Final EST SCORE CALCULATION -----------

    % ---- frequency of ESTs above threshold length-----


    %% ------- SCORING TAG LENGTH------------
    Tag_ladder.Taglength = cellfun('size',ladder,1);              % finding length of tags

    Tag_ladder.Tag= cell(1,size(ladder,2));

    Scoreforlength = zeros(1,size(ladder,2));
    Frequency = zeros(1,size(ladder,2));
    for index = 1:size(Tag_ladder.Taglength,2)                        % no of tags
        Scoreforlength(index) = (Tag_ladder.Taglength(index))^2;      % quadratic function for length (score= length^2)
        Tag_ladder.Frequency(index) = Tags_Intesnsity_Array{index}.*Scoreforlength(index);
        Tag = '';
        for row = 1: size(ladder{1,index},1) % for the length of the tag - indicated by rows in one cell
            Tag  = strcat(Tag ,ladder{1,index}{row,6}); % concatenate to get the complete the tag to search it in the protein sequence
        end
        Tag_ladder.Tag(index) = cellstr(Tag);
    end
    Tag_Ladder = {};
    for l = 1:size(Tag_ladder.Taglength,2) 
        Tag_Ladder{l} = {cell2mat(Tag_ladder.Tag(l)),Tag_ladder.Taglength(l),Tag_ladder.Score_Error(l),Tag_ladder.Frequency(l)};
    end
else
    Tag_Ladder = {};
end

end




   


%% This Function Will find and join and return all possible PSTs
% function  Return_Ladder = Extract_PSTs_Helper(AA_monoisotopicMass,Peak_List,User_Hop_Threshold,User_max_TagLength_Threshold)
% 
% 
%  AA_monoisotopicMass=Monoisotopic_weight;
% Hop_Info={} ;
% Ladder_Index = 00; %index ladder
% User_Hop_Threshold = User_Hop_Threshold/17;
% for Peak_Index = 1:(size(Peak_List,1)-1) % Hop_Index
%     for Hop_Index = (Peak_Index+1) : size(Peak_List,1)
%         % Molecular weight difference between two peaks
%         Peaks_MW_Difference = Peak_List(Hop_Index) - Peak_List(Peak_Index);
%         for AminoAcid_Index = 1:19 % need to change
%             if abs ( AA_monoisotopicMass{AminoAcid_Index}{3}- Peaks_MW_Difference)  <= User_Hop_Threshold
%                 
%                 Ladder_Index =Ladder_Index + 1;
%                 % Error = calculated MW of peaks - actual weight of the amino acid
%                 Error = Peaks_MW_Difference - AA_monoisotopicMass{AminoAcid_Index}{3};
% 
%                 Hop_Info{Ladder_Index} = {Peak_Index,Hop_Index,Peak_List(Peak_Index),...
%                     Peak_List(Hop_Index),Peaks_MW_Difference, ...
%                     AA_monoisotopicMass{AminoAcid_Index}{2},AA_monoisotopicMass{AminoAcid_Index}{3},Error...
%                     (Peak_List(Peak_Index,2)+Peak_List(Hop_Index,2))/2};
%             end
%         end
%     end
% end
% 
% 
% Num_AAs_Found=(length(Hop_Info)-1); ladder={}; counter=0;
% length_tags=1;
% for Home_peak=1:(Num_AAs_Found-1)
%     
%     for Strat_peak=1:(Num_AAs_Found-1)
%         AA_Next='';
%         
%         Hop_peak=(Strat_peak+1);
%         if(Hop_Info{Home_peak}{2}==Hop_Info{Hop_peak}{1})
%             AA_Next=Join(Hop_peak,length_tags,Hop_Info,Num_AAs_Found);
%             AA_Next=[Hop_Info{Home_peak};AA_Next];
%             %           AA_Next=strcat(Hop_Info{Home_peak}{6},AA_Next);
%             Ladder_raw{length_tags,1}= AA_Next;
%             length_tags = length_tags+1;
%             
%         end
%         
%     end
%     
%     %    disp(num2str(length_tags));
%     %        ladder{ladder_index}= Join(ladder_index,Num_AAs_Found,Hop_Info,length_tags);
% end
% Return_Ladder = ladder_extrection_trim(Ladder_raw,User_max_TagLength_Threshold);
% 
% end % end function  findpeaks()











