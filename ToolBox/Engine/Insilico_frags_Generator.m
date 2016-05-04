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
% generate insilico fragments
function Candidate_ProteinsList = Insilico_frags_Generator(Candidate_ProteinsList,Frag_technique,no_of_output,ExperimentalPeakList)
% Protein.sequence = 'MAPNASCLCVHVRSEEWDLMTFDANPYDSVKKIKEHVRSKTKVPVQDQVLLLGSKILKPRRSLSSYGIDKEKTIHLTLKVVKPSDEELPLFLVESGDEAKRHLLQVRRSSSVAQVKAMIETKTGIIPETQIVTCNGKRLEDGKMMADYGIRKGNLLFLACYCIGG';

for j= 1:numel(Candidate_ProteinsList)
    Candidate_ProteinsList{j,1}.Matches_Score = 0;
    Candidate_ProteinsList{j,1}.Matched = false;
    Candidate_ProteinsList{j,1}.Score = Candidate_ProteinsList{j,1}.EST_Score + Candidate_ProteinsList{j,1}.PTM_score;
    Candidate_ProteinsList{j,1}.Output=no_of_output;
    Candidate_ProteinsList{j,1}.ExperimentalPeakList=ExperimentalPeakList;
    
    similar_fragments = {'CID','IMD','BIRD','SID','HCD'};
    
    match = strcmpi(Frag_technique,similar_fragments); % compares the selected fragmentation technique with the set of similar techniques (ions wise)
    if any(match) % checks if any value in match array is non-zero
        %     disp('in similar techniques')
        %this function is for CID,IMD,BIRD,SID,HCD (i.e. B-ions and Y-ions)
        Candidate_ProteinsList{j,1}.LeftIons= Candidate_ProteinsList{j,1}.LeftIons + 1.00794; % adding the molecular weight of a hydrogen from left fragment to produce b-ion
        Candidate_ProteinsList{j,1}.RightIons= Candidate_ProteinsList{j,1}.RightIons - 1.00794; % subtracting the molecular weight of a hydrogen from right fragment to produce y-ion
        
    elseif isequal(Frag_technique,'ECD')
        %     disp('in ECD')
        %this function is for ECD (i.e. c-ions and z-ions)
        
        Candidate_ProteinsList{j,1}.LeftIons = Candidate_ProteinsList{j,1}.LeftIons +16.02258; % adding NH2 to left fragment to produce c-ion
        Candidate_ProteinsList{j,1}.RightIons = Candidate_ProteinsList{j,1}.RightIons -16.02258; % subtracting NH2 from right fragment to produce z-ion
        
    elseif isequal(Frag_technique,'EDD')
        %     disp('in EDD')
        
        %this function is for EDD (i.e. A-ions and X-ions)
        
        Candidate_ProteinsList{j,1}.LeftIons  = Candidate_ProteinsList{j,1}.LeftIons - 29.01804; % subtracting the molecular weight of CHO from left fragment to produce a-ion
        Candidate_ProteinsList{j,1}.RightIons = Candidate_ProteinsList{j,1}.RightIons + 27.02534; % adding the molecular weight of CO and subtracting H from right fragment to produce x-ion
        
    end
    
    
end
end
