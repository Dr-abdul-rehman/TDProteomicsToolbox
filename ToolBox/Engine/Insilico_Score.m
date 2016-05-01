function Matches = Insilico_Score(Candidate_ProteinsList,ExperimentalPeakList,IonssMW_threshold)

Matches = {}; % get proteins whose Ionss match
% set matched attribute false - will be used to prevent duplicate proteins entries in final array
for ProteinListIndex= 1: numel(Candidate_ProteinsList)
    Candidate_ProteinsList{ProteinListIndex,1}.Matches_Score = 0;
    for PeakListIndex = 1:numel(ExperimentalPeakList)
   
        
        %check in Left Ionss
        for k = 1:numel(Candidate_ProteinsList{ProteinListIndex,1}.LeftIons)
            
            if abs(ExperimentalPeakList(PeakListIndex) - Candidate_ProteinsList{ProteinListIndex,1}.LeftIons(k)) <= IonssMW_threshold
                Candidate_ProteinsList{ProteinListIndex,1}.Matches_Score = Candidate_ProteinsList{ProteinListIndex,1}.Matches_Score + 1;
            
            end
            if abs(ExperimentalPeakList(PeakListIndex) - Candidate_ProteinsList{ProteinListIndex,1}.RightIons(k)) <= IonssMW_threshold
                Candidate_ProteinsList{ProteinListIndex,1}.Matches_Score = Candidate_ProteinsList{ProteinListIndex,1}.Matches_Score + 1; % only update score 
            end
        end
    end
    
    
Candidate_ProteinsList{ProteinListIndex,1}.Matches_Score = Candidate_ProteinsList{ProteinListIndex,1}.Matches_Score / numel(ExperimentalPeakList);
% Candidate_ProteinsList{ProteinListIndex,1}.Matches_Score = Candidate_ProteinsList{ProteinListIndex,1}.Matches_Score + Candidate_ProteinsList{ProteinListIndex,1}.Matches_Score ;
Matches = [Matches; Candidate_ProteinsList{ProteinListIndex,1}]; % add the protein to Matches_Score
end
end