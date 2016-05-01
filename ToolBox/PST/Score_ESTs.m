    function [Final_EST_Score,Tag_Ladder,ExperimentalPeakList] = Score_ESTs(User_TagLength_Threshold,User_Hop_Threshold,User_TagError_Threshold )


    %prot.mz=importdata(Peaklist_Data);
    % Reads the whole peaklist data file (from LUMSProT.m) as is done by prot.mz earlier
    Fragments_Peaklist_Data = getappdata(0,'Peaklist_Data');
    N = size(Fragments_Peaklist_Data,1); % Size/number of the fragments peaks
    % All fragment peaks will be extracted except the mass of the intact protein
    ExperimentalPeakList = sortrows(Fragments_Peaklist_Data(2:N,:)); 
   % Reads the object (from LUMSProT.m) containing peak list intact protein experimental mass
   % prot_MW_ExperimentalFile = getappdata(0,'Intact_Protein_Mass');
   % prot_Charge = Fragments_Peaklist_Data(1,2); % prot_Charge = prot.mz(1,2);
    Ladders = {};

    % Experimental molecular weight of each amino acid
    AminoAcids_MolWt = [131.040485 128.058578 71.037114 156.101111 114.042927 115.026943 103.009185 129.042593 57.021464 137.058912 113.084064 113.084064 128.094963 147.068414 97.052764 87.032028 101.047679 186.079313 163.06332 99.068414];
    AminoAcids_Tags = ['M' 'Q' 'A' 'R' 'N' 'D' 'C' 'E' 'G' 'H' 'I' 'L' 'K' 'F' 'P' 'S' 'T' 'W' 'Y' 'V'];

    % ---- User provided parameters ------
    % User_Tag_ladder.Taglength_threshold = 1; % user provided
    % User_tagError_threshold = 5;

    %% extract PSTs using the find peaks function
    Ladders_List = Find_Peaks(AminoAcids_Tags,AminoAcids_MolWt, ExperimentalPeakList,User_Hop_Threshold);
    Ladders.Tags_Length = cellfun('size',Ladders_List,1);               % finding length of tags

    %%----- filter tags according to user min tag length threshold----------
    for i = 1:size(Ladders.Tags_Length,2)
        if (Ladders.Tags_Length(i) < User_TagLength_Threshold)
            Ladders_List{i} = [];
        end
    end
    Ladders_List = Ladders_List(~cellfun('isempty',Ladders_List)); % trim the Ladders_List cell array


    %%----------- CALCULATING TAG ERROR AND SCORING -------------
    Tags_Error_List = cell(1,size(Ladders_List,2));
    Tags_Intesnsity_List = cell(1,size(Ladders_List,2));
    for m = 1:size(Ladders_List,2)
        Ladders_List_Error = [];
        Ladders_List_Intensity = [];
        for n=1: size(Ladders_List{m},1) % for the length of the tag --- # of hops
            Ladders_List_Error = [Ladders_List_Error Ladders_List{1,m}{n,8}]; % Errors in 8th column {1}{8}
            Ladders_List_Intensity = [Ladders_List_Intensity Ladders_List{1,m}{n,9}]; % Mean of intensities in 9th column {1}{9}
        end
        Error_sum = 0;
        Intensity_sum = 0;
        for i= 1:size(Ladders_List_Error,2)
            Intensity_sum = Intensity_sum + Ladders_List_Intensity(i);
            Error_Sqaure = Ladders_List_Error(i)^2; % square the Error_Sqaure
            Error_sum = Error_sum + Error_Sqaure; % sum all errors for the tag
        end
        RMSE = sqrt(Error_sum)/size(Ladders_List_Error,2); % Root Mean Squared Error/# of hops
        Tags_Error_List{m} = RMSE;
        Tags_Intesnsity_List {m} = Intensity_sum /size(Ladders_List_Error,2);
    end

    %% --------------- Filter tags according to fulltag error threshold -----

    for m = 1:size(Ladders_List,2)
        if (Tags_Error_List{m} > User_TagError_Threshold)
            Ladders_List{m} = []; % remove that tag from the Ladders_List
            Tags_Error_List{m} = []; % remove that error from list
            Tags_Intesnsity_List{m} = [];
        end
    end

    Ladders_List = Ladders_List(~cellfun('isempty',Ladders_List)); % trim the Ladders_List cell array
    Tags_Error_List = Tags_Error_List(~cellfun('isempty',Tags_Error_List)); % trim the lTags_Error_Vector array
    Tags_Intesnsity_List = Tags_Intesnsity_List (~cellfun('isempty',Tags_Intesnsity_List));
    %% ----------- Score tags according to errors --------
    % y = -0.1(x^2) + 0.4   (at error 2 the score should be zero)

    Ladders.Score_Error = zeros(1,size(Tags_Error_List,2));
    for m = 1:size(Tags_Error_List,2)
        Ladders.Score_Error(m) = -0.1*(Tags_Error_List{m}^2) + 0.4;
    end

    %% -------- Final EST SCORE CALCULATION -----------

    % ---- frequency of ESTs above threshold length-----


    %% ------- SCORING TAG LENGTH------------
    Ladders.Tags_Length = cellfun('size',Ladders_List,1);              % finding length of tags

    Ladders.Tag= cell(1,size(Ladders_List,2));

    Scoreforlength = zeros(1,size(Ladders_List,2));
    Frequency = zeros(1,size(Ladders_List,2));
    for p = 1:size(Ladders.Tags_Length,2)                        % no. of tags
        Scoreforlength(p) = (Ladders.Tags_Length(p))^2;      % quadratic function for length (score= length^2)
        Ladders.Frequency(p) = Tags_Intesnsity_List{p}.*Scoreforlength(p);
        Tag = '';
        for row = 1: size(Ladders_List{1,p},1) % for the length of the tag - indicated by rows in one cell
            Tag  = strcat(Tag ,Ladders_List{1,p}{row,6}); % concatenate to get the complete the tag to search it in the protein sequence
        end
        Ladders.Tag(p) = cellstr(Tag);
    end
    Tag_Ladder = {};
    for l = 1:size(Ladders.Tags_Length,2)
        Tag_Ladder{l} = {cell2mat(Ladders.Tag(l)),Ladders.Tags_Length(l),Ladders.Score_Error(l),Ladders.Frequency(l)};
    end

    %%  ---- EST Scoring Function ----
    if(isnan(sum(Ladders.Frequency)))
        Final_EST_Score = sum(Scoreforlength)+ sum(Ladders.Score_Error);
    else
        Final_EST_Score = sum(Scoreforlength)+ sum(Ladders.Score_Error) + sum(Ladders.Frequency); % simple sum right now
    end
   % disp(Final_EST_Score);

    end
