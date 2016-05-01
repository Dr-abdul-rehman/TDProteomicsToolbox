function Modified_Protein_Seqs = PTMs_Generator_Insilico_Generator(Candidate_ProteinsList,Protein_sequence,Protein_ExperimentalMW,MWTolerance,Protein_name,Protein_id,PTM_tol,fixed_modifications,variable_modifications,EST_Score)

Modified_Protein_Seqs = {};
Modified_Protein = {};
All_Var_PTMs = {};
All_Fixed_PTMs = {};

fixed_tol = 0;
newline = sprintf('\r');
Protein_sequence = strrep(Protein_sequence, newline,'');

number_of_variable_mods = numel(variable_modifications);
number_of_fixed_mods = numel(fixed_modifications);

for variable_modification_idx = 1 : number_of_variable_mods
    
    used_to_call_PTM_functions=num2str(cell2mat(variable_modifications(variable_modification_idx)));
    used_to_call_PTM_functions = strcat(used_to_call_PTM_functions,'(',' ','''',Protein_sequence,'''', ',' ,'''',num2str(PTM_tol),'''',')',';');
    % addpath(strcat(pwd,'\','PTM'));
    sites = eval(used_to_call_PTM_functions);
    All_Var_PTMs = [All_Var_PTMs ; sites];
end

for fixed_modification_idx = 1 : number_of_fixed_mods
    
    used_to_call_PTM_functions=num2str(cell2mat(fixed_modifications(fixed_modification_idx)));
    used_to_call_PTM_functions = strcat(used_to_call_PTM_functions,'(',' ','''',Protein_sequence,'''', ',' ,'''',num2str(fixed_tol),'''',')',';');
    %   addpath(strcat(pwd,'\','PTM'));
    sites = eval(used_to_call_PTM_functions);
    All_Fixed_PTMs = [All_Fixed_PTMs; sites];
end

combinations = cell(1,size(All_Var_PTMs,1));
for index=1:size(All_Var_PTMs,1)
    combinations{index}= combnk(1:size(All_Var_PTMs,1),index); % make combinations of size 1,2,3.. till number of sites of modification
end

%% obtain modifications informations corresponding to combinations of indices of PTMs generated

structs_array = cell(1,size(All_Var_PTMs,1)+1);
for index = 1:size(combinations,2) % number of entries(columns) in combinations array
    for index1 = 1:size(combinations{1,index},1) % number of rows in each cell of combinations array
        for index2 = 1:size(combinations{1,index},2)  % number of columns in each cell of combinations array
            Combined_idx = combinations{1,index}(index1,index2);
            info = All_Var_PTMs(Combined_idx,:);
            PTM.seq_idx = info{1,1}; % position of site in sequence
            PTM.score = info{1,2}; %PTM score
            PTM.mod_MW = info{1,3};
            PTM.name = info{1,4};
            PTM.site = info{1,5}; % amino acid site
            PTM.consensus_window = info{1,6};
            structs_array{1,index}(index1,index2) = PTM;
        end
    end
end

%% insilico code and MW filtering

% Modified_Protein_Seqs = cell(1,size(structs_array,1)); % to store modified protein seqs and their left and right ions


%% In case no variable modification is selected
if(isempty(structs_array{1}) && ~isempty(All_Fixed_PTMs))
    for prot_index = 1:numel(Protein_sequence)
        % calculate left ion wihtout mod
        if prot_index == 1
            Modified_Protein.LeftIons(prot_index) = GetMWofAA(Protein_sequence(prot_index));
        else
            Modified_Protein.LeftIons(prot_index) = (Modified_Protein.LeftIons(prot_index-1) + GetMWofAA(Protein_sequence(prot_index)));
            
        end
        
        for fixedIndex = 1 : size((All_Fixed_PTMs),1)
            if Protein_sequence(prot_index) ==  All_Fixed_PTMs{fixedIndex,5}
                Modified_Protein.LeftIons(prot_index)= Modified_Protein.LeftIons(prot_index)+ All_Fixed_PTMs{fixedIndex,3};
                break;
            end
        end
    end
    
    
    Modified_Protein.MolW = Modified_Protein.LeftIons(length(Protein_sequence)); % last Leftion will be the MW
    %% check if Molecular weight matches Experimental MW of protein
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Check if MW of Database protein is within the MW tolerance
    if abs(Modified_Protein.MolW - Protein_ExperimentalMW) <= MWTolerance
        % else generate right ions and store info for this modified sequence
        % Calculate Right ions by subtracting left ions from MW of protein
        for InsilicoIndex = 1: numel(Modified_Protein.LeftIons)
            Modified_Protein.RightIons(InsilicoIndex) = Modified_Protein.MolW - Modified_Protein.LeftIons(InsilicoIndex);
        end
        
        Modified_Protein.LeftIons(length(Protein_sequence))= []; % as this will be the MW of protein
        Modified_Protein.RightIons(length(Protein_sequence))= []; % as this will be zero
        
        Modified_Protein.Sequence = Protein_sequence;
        Modified_Protein.Name = Protein_name; %from database
        Modified_Protein.Id = Protein_id; %from database
        
        Modified_Protein.PTM_score=0;
        Modified_Protein.consensus_window = '';
        Modified_Protein.PTM_name='';
        PTMIndex = 0;
      
        for fixedIndex = 1 : size((All_Fixed_PTMs),1)
            PTMIndex = PTMIndex+1;
            Modified_Protein.PTM_seq_idx(PTMIndex,1)=All_Fixed_PTMs{fixedIndex,1};
            Modified_Protein.PTM_score = Modified_Protein.PTM_score + All_Fixed_PTMs{fixedIndex,2}; %PTM score
            Modified_Protein.PTM_site(PTMIndex,1)=All_Fixed_PTMs{fixedIndex,5};
            Modified_Protein.PTM_name=[Modified_Protein.PTM_name; All_Fixed_PTMs{fixedIndex,4}];
            Modified_Protein.consensus_window=[Modified_Protein.consensus_window All_Fixed_PTMs{fixedIndex,6}];
        end
        
        Modified_Protein.EST_Score = EST_Score;
        
        ERROR=abs(Protein_ExperimentalMW- Modified_Protein.MolW);
        if(ERROR==0)
            Modified_Protein.MWScore=1;   %diff=0 mw_score=1
        else
            Modified_Protein.MWScore=10/(ERROR);% compute mol_weight Score for proteins via mw_score=10/|diff|
        end
        
        Modified_Protein.PTM_score = 1- exp(-Modified_Protein.PTM_score/3);
        
        % store this modified prot seq with related info
        % Modified_Protein_Seqs{1,i}(j,1) = Modified_Protein;
        Modified_Protein_Seqs = [ Modified_Protein_Seqs ; Modified_Protein ];
    end
end


for index = 1:size(structs_array,2)
    for index1 = 1:size(structs_array{1,index},1) % get rows in each cell of structs_array
        % every row of each cell of the structs_array represents an instance of possible
        % mods in the protein sequence at one given time
        % work on sequence starts here
        
        %Initializations
        Modified_Protein.LeftIons = zeros(length(Protein_sequence),1);
        Modified_Protein.RightIons = zeros(length(Protein_sequence),1);
        Modified_Protein.PTM_score = 0;
        Modified_Protein.PTM_name = '';
        Modified_Protein.consensus_window= '';
        % % % % % % % % %             for l = i:numel(Protein_sequence)
        for prot_index = 1:numel(Protein_sequence)
            % calculate left ion wihtout mod
            if prot_index == 1
                Modified_Protein.LeftIons(prot_index) = GetMWofAA(Protein_sequence(prot_index));
            else
                Modified_Protein.LeftIons(prot_index) = (Modified_Protein.LeftIons(prot_index-1) + GetMWofAA(Protein_sequence(prot_index)));
                
            end
            
            
            for fixedIndex = 1 : size((All_Fixed_PTMs),1)
                if Protein_sequence(prot_index) ==  All_Fixed_PTMs{fixedIndex,5}
                    Modified_Protein.LeftIons(prot_index)= Modified_Protein.LeftIons(prot_index)+ All_Fixed_PTMs{fixedIndex,3};
                    break;
                end
            end
            
            
            for varIndex = 1:size(structs_array{1,index},2) % columns
                Modified_site = structs_array{1,index}(index1,varIndex);
                
                % check for modification at this index
                if prot_index == Modified_site.seq_idx
                    Modified_Protein.LeftIons(prot_index)= Modified_Protein.LeftIons(prot_index)+ Modified_site.mod_MW;
                end
                
            end
        end
        Modified_Protein.MolW = Modified_Protein.LeftIons(length(Protein_sequence)); % last Leftion will be the MW
        %% check if Molecular weight matches Experimental MW of protein
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Check if MW of Database protein is within the MW tolerance
        if abs(Modified_Protein.MolW - Protein_ExperimentalMW) >= MWTolerance
            continue; % go to next modified sequence(next row) in the array as MW tolerance not satisfied
        end
        % else generate right ions and store info for this modified sequence
        % Calculate Right ions by subtracting left ions from MW of protein
        for InsilicoIndex = 1: numel(Modified_Protein.LeftIons)
            Modified_Protein.RightIons(InsilicoIndex) = Modified_Protein.MolW - Modified_Protein.LeftIons(InsilicoIndex);
        end
        
        Modified_Protein.LeftIons(length(Protein_sequence))= []; % as this will be the MW of protein
        Modified_Protein.RightIons(length(Protein_sequence))= []; % as this will be zero
        
        Modified_Protein.Sequence = Protein_sequence;
        Modified_Protein.Name = Protein_name; %from database
        Modified_Protein.Id = Protein_id; %from database
        
        
        PTMIndex = 0;
        for PTMIndex = 1:size(structs_array{1,index},2) % columns
            Modified_site = structs_array{1,index}(index1,PTMIndex);
            Modified_Protein.PTM_seq_idx(PTMIndex,1)=Modified_site.seq_idx;
            Modified_Protein.PTM_score = Modified_Protein.PTM_score + Modified_site.score; %PTM score
            Modified_Protein.PTM_site(PTMIndex,1)=Modified_site.site;
            Modified_Protein.PTM_name=[Modified_Protein.PTM_name; Modified_site.name];
            Modified_Protein.consensus_window=[Modified_Protein.consensus_window Modified_site.consensus_window];
        end
        
        for fixedIndex = 1 : size((All_Fixed_PTMs),1)
            PTMIndex = PTMIndex+1;
            Modified_Protein.PTM_seq_idx(PTMIndex,1)=All_Fixed_PTMs{fixedIndex,1};
            Modified_Protein.PTM_score = Modified_Protein.PTM_score + All_Fixed_PTMs{fixedIndex,2}; %PTM score
            Modified_Protein.PTM_site(PTMIndex,1)=All_Fixed_PTMs{fixedIndex,5};
            Modified_Protein.PTM_name=[Modified_Protein.PTM_name; All_Fixed_PTMs{fixedIndex,4}];
            Modified_Protein.consensus_window=[Modified_Protein.consensus_window All_Fixed_PTMs{fixedIndex,6}];
        end
        
        ERROR=abs(Protein_ExperimentalMW- Modified_Protein.MolW);
        if(ERROR==0)
            Modified_Protein.MWScore=1;   %diff=0 mw_score=1
        else
            Modified_Protein.MWScore=10/(ERROR);% compute mol_weight Score for proteins via mw_score=10/|diff|
        end
        
        Modified_Protein.EST_Score = EST_Score;
        Modified_Protein.PTM_score = 1- exp(-Modified_Protein.PTM_score/3);
        % store this modified prot seq with related info
        % Modified_Protein_Seqs{1,i}(j,1) = Modified_Protein;
        Modified_Protein_Seqs = [ Modified_Protein_Seqs ; Modified_Protein ];
        
    end
end

end