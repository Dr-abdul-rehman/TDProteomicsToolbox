% generate insilico fragments
function Candidate_ProteinsList = Insilico_frags_Generator_modifier(Candidate_ProteinsList,Frag_technique,HandleIon)
% Protein.sequence = 'MAPNASCLCVHVRSEEWDLMTFDANPYDSVKKIKEHVRSKTKVPVQDQVLLLGSKILKPRRSLSSYGIDKEKTIHLTLKVVKPSDEELPLFLVESGDEAKRHLLQVRRSSSVAQVKAMIETKTGIIPETQIVTCNGKRLEDGKMMADYGIRKGNLLFLACYCIGG';

for ProteinListIndex= 1:numel(Candidate_ProteinsList)
    
    % Candidate_ProteinsList{ProteinListIndex,1}.Score = Candidate_ProteinsList{ProteinListIndex,1}.EST_Score + Candidate_ProteinsList{ProteinListIndex,1}.PTM_score;
    %Candidate_ProteinsList{ProteinListIndex,1}.ExperimentalPeakList=ExperimentalPeakList;
    
    similar_fragments = {'CID','IMD','BIRD','SID','HCD'};
    similar_fragments2 = {'ECD','ETD'};
    similar_fragments3 = {'EDD','NETD'};
    match = strcmpi(Frag_technique,similar_fragments); % compares the selected fragmentation technique with the set of similar techniques (ions wise)
    %if ~isempty(HandleIon)
    
    if any(match) % checks if any value in match array is non-zero
        %     disp('in similar techniques')
        %this function is for CID,IMD,BIRD,SID,HCD (i.e. B-ions and Y-ions)
        Candidate_ProteinsList{ProteinListIndex,1}.LeftIons= Candidate_ProteinsList{ProteinListIndex,1}.LeftIons + 1.00794; % adding the molecular weight of a hydrogen from left fragment to produce b-ion
        Candidate_ProteinsList{ProteinListIndex,1}.RightIons= Candidate_ProteinsList{ProteinListIndex,1}.RightIons - 1.00794; % subtracting the molecular weight of a hydrogen from right fragment to produce y-ion
         if(HandleIon{2,1} == 1)
            Candidate_ProteinsList{ProteinListIndex,1}.LeftIons = Candidate_ProteinsList{ProteinListIndex,1}.LeftIons-18;
        elseif(HandleIon{7,1} == 1)
            Candidate_ProteinsList{ProteinListIndex,1}.LeftIons = Candidate_ProteinsList{ProteinListIndex,1}.LeftIons-17.026549;
        elseif(HandleIon{8,1} == 1)
            Candidate_ProteinsList{ProteinListIndex,1}.RightIons = Candidate_ProteinsList{ProteinListIndex,1}.RightIons-17.026549;
        elseif(HandleIon{3,1} == 1)
            Candidate_ProteinsList{ProteinListIndex,1}.RightIons = Candidate_ProteinsList{ProteinListIndex,1}.RightIons-18;
         end
    
        
         
    elseif any(strcmpi(Frag_technique,similar_fragments2))
        %     disp('in ECD')
        %this function is for ECD (i.e. c-ions and z-ions)
       
        Candidate_ProteinsList{ProteinListIndex,1}.LeftIons = Candidate_ProteinsList{ProteinListIndex,1}.LeftIons +16.02258; % adding NH2 to left fragment to produce c-ion
        Candidate_ProteinsList{ProteinListIndex,1}.RightIons = Candidate_ProteinsList{ProteinListIndex,1}.RightIons -16.02258; % subtracting NH2 from right fragment to produce z-ion
         if(HandleIon{4,1} == 1)
            Candidate_ProteinsList{ProteinListIndex,1}.RightIons = Candidate_ProteinsList{ProteinListIndex,1}.RightIons+1;
        elseif(HandleIon{5,1} == 1)
            Candidate_ProteinsList{ProteinListIndex,1}.RightIons = Candidate_ProteinsList{ProteinListIndex,1}.RightIons+2;
         end
        
         
         
    elseif any(strcmpi(Frag_technique,similar_fragments3))
        %     disp('in EDD')
        
        %this function is for EDD (i.e. A-ions and X-ions)
        
        Candidate_ProteinsList{ProteinListIndex,1}.LeftIons  = Candidate_ProteinsList{ProteinListIndex,1}.LeftIons - 29.01804; % subtracting the molecular weight of CHO from left fragment to produce a-ion
        Candidate_ProteinsList{ProteinListIndex,1}.RightIons = Candidate_ProteinsList{ProteinListIndex,1}.RightIons + 27.02534; % adding the molecular weight of CO and subtracting H from right fragment to produce x-ion
        if(HandleIon{1,1} == 1)
            Candidate_ProteinsList{ProteinListIndex,1}.LeftIons = Candidate_ProteinsList{ProteinListIndex,1}.LeftIons-18;
        elseif(HandleIon{6,1} == 1)
            Candidate_ProteinsList{ProteinListIndex,1}.LeftIons = Candidate_ProteinsList{ProteinListIndex,1}.LeftIons-17.026549;
        end
        
        
    end
    
    
end
end