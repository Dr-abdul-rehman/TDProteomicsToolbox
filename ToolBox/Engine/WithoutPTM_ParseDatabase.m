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
function [Candidate_ProteinsList] = WithoutPTM_ParseDatabase(Tags_ladder,Candidate_ProteinsList1 )

Candidate_ProteinsList = {};

for index = 1: numel(Candidate_ProteinsList1)
   
    Header = Candidate_ProteinsList1{index}{1}; % header is separated by first NewLine char - get header without Newline char
    Sequence = Candidate_ProteinsList1{index}{3};
    
    
    %% Scan database protein sequence for ESTs
    
   [Final_EST_Score,Tag_indices] = PST_Score(Tags_ladder,Sequence);
   

        
        % --- Extract Database Protein ID -------
        remain = Header;
        tokens = cell(1,3);
        count = 1;
        while true
            [str,remain] = strtok(remain, '|'); % tokenise header where '|' appears as it separates the id
            if isempty(str)
                break;
            end
            tokens{count} = str;
            count = count+1;
        end
        id = tokens{2}; % second index has the protein id
        
        
        %% ---- Extract Database Protein Name ---------
        Protein_info = regexp(Header,' OS','split'); %break string before 'OS' found in string - protein name is before 'OS'
        Header_start = Protein_info{1}; % get the initial part of the header
        space_index = strfind(Header_start,' '); % find space in the string containing name
        Protein_name = Header_start (space_index(1)+1:end);
        
        %% --- Calculate Molecular Weight of Database Protein
        
        
        
        
        Modified_Protein = {};
        Modified_Protein.LeftIons = zeros(length(Sequence),1);
        Modified_Protein.RightIons = zeros(length(Sequence),1);
        Modified_Protein.PTM_score = 0;
        Modified_Protein.PTM_name = '';
        Modified_Protein.consensus_window= '';
        newline = sprintf('\r');
        Sequence = strrep(Sequence , newline,'');
        addpath(strcat(pwd,'\PTM'));
        for l = 1:numel(Sequence)
            
            % calculate left ion wihtout mod
            if l == 1
                Modified_Protein.LeftIons(l) = GetMWofAA(Sequence(l));
            else
                Modified_Protein.LeftIons(l) = (Modified_Protein.LeftIons(l-1) + GetMWofAA(Sequence(l)));
                
            end
        end
        rmpath(strcat(pwd,'\PTM'));
        Modified_Protein.MolW = Modified_Protein.LeftIons(length(Sequence)); % last Leftion will be the MW
        % else generate right ions and store info for this modified sequence
        % Calculate Right ions by subtracting left ions from MW of protein
        for m = 1: numel(Modified_Protein.LeftIons)
            Modified_Protein.RightIons(m) = Modified_Protein.MolW - Modified_Protein.LeftIons(m);
        end
        
        Modified_Protein.LeftIons(length(Sequence))= []; % as this will be the MW of protein
        Modified_Protein.RightIons(length(Sequence))= []; % as this will be zero
        
        Modified_Protein.Sequence = Sequence;
        Modified_Protein.Name = Protein_name; %from database
        Modified_Protein.Id = id; %from database
        Modified_Protein.EST_Score = Final_EST_Score;
        
        Modified_Protein.PTM_seq_idx=-1;
        Modified_Protein.PTM_score = 0; %PTM score
        Modified_Protein.PTM_site ='';
        Modified_Protein.PTM_name='';
        Modified_Protein.consensus_window='';
        Modified_Protein.MWScore = Candidate_ProteinsList1{index}{4};
        Candidate_ProteinsList = [Candidate_ProteinsList; Modified_Protein];
end
end

