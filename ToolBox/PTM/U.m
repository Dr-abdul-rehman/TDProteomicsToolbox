clear
clc
Protein.sequence = 'MAPNASCLCVHVRSEEWDLMTFDANPYDSVKKIKEHVRSKTKVPVQDQVLLLGSKILKPRRSLSSYGIDKEKTIHLTLKVVKPSDEELPLFLVESGDEAKRHLLQVRRSSSVAQVKAMIETKTGIIPETQIVTCNGKRLEDGKMMADYGIRKGNLLFLACYCIGG';
PTM_tol = 0.3;
Sites_acety = ala_acetylation(Protein.sequence,PTM_tol);
Sites_methyl = arg_methylation(Protein.sequence,PTM_tol);
All_PTMs = [Sites_acety; Sites_methyl];

combinations = cell(1,size(All_PTMs,1));
for i=1:size(All_PTMs,1)
    combinations{i}= combnk(1:size(All_PTMs,1),i);
end

structs_array = cell(1,size(All_PTMs,1));
for i = 1:size(combinations,2)
    for j = 1:size(combinations{1,i},1)
        for k = 1:size(combinations{1,i},2)
            Combined_idx = combinations{1,i}(j,k);
            info = All_PTMs(Combined_idx,:);
            PTM.seq_idx = info{1,1}; % position of site in sequence
            PTM.score = info{1,2}; %PTM score
            PTM.mod_MW = info{1,3};
            PTM.name = info{1,4};
            PTM.site = info{1,5}; % amino acid site
            PTM.consensus_window = info{1,6};
            structs_array{1,i}(j,k) = PTM;
        end
    end
end


for i = 1:size(structs_array,2)
    for j = 1:size(structs_array{1,i},1) % get rows in each cell of structs_array
        % work on sequence starts here
        for l = i:numel(Protein.sequence)
            Protein.LeftIons = zeros(length(Protein.sequence),1);
            Protein.RightIons = zeros(length(Protein.sequence),1);
            
            for k = 1:size(structs_array{1,i},2)
                Combined_idx = structs_array{1,i}(j,k);
                
                if l == 1
                    Protein.LeftIon(l) = GetMWofAA(Protein.sequence(l));
                else
                    Protein.LeftIon(l) = (Protein.LeftIon(l-1) + GetMWofAA(Protein.sequence(l))) ;
                    
                end
                Protein.LeftIon(i)
                if l == Combined_idx
                    Protein.LeftIons(l)= Protein.LeftIons(l)+ structs_array{1,i}(j,k).mod_MW;
                end
                Protein.LeftIon(i)
            end
        end
        Protein.MolW= Protein.LeftIon(length(Protein.sequence)); % last Leftion will be the MW
        
        % calculate right ions by subtracting left ions from MW of protein
        for m= 1: numel(Protein.LeftIon)
            Protein.RightIon(m) = Protein.MolW - Protein.LeftIon(m);
        end
        
        Protein.LeftIons(length(Protein.sequence))= []; % as this will be the MW of protein
        Protein.RightIons(length(Protein.sequence))= []; % as this will be zero
        
    end
end