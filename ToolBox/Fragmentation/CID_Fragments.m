function Protein = CID_Fragments(strProteinSequence);

clc
% Protein.sequence = strProteinSequence;
Protein.sequence = 'MAPNASCLCVHVRSEEWDLMTFDANPYDSVKKIKEHVRSKTKVPVQDQVLLLGSKILKPRRSLSSYGIDKEKTIHLTLKVVKPSDEELPLFLVESGDEAKRHLLQVRRSSSVAQVKAMIETKTGIIPETQIVTCNGKRLEDGKMMADYGIRKGNLLFLACYCIGG';
Protein.MW= 0;
Protein.LeftIon = zeros(length(Protein.sequence),1); %Molecular weight of the left ion generated by fragmentation
Protein.RightIon = zeros(length(Protein.sequence),1);

for i=1:length(Protein.sequence) %for loop running for the length of the protein sequence
    
    if i == 1
        Protein.LeftIon(i) = GetMWofAA(Protein.sequence(i));
    else
        Protein.LeftIon(i) = (Protein.LeftIon(i-1) + GetMWofAA(Protein.sequence(i))) ;
        
    end
end

Protein.MW= Protein.LeftIon(length(Protein.sequence)); % last Leftion will be the MW

% calculate right ions by subtracting left ions from MW of protein
for i= 1: numel(Protein.LeftIon)
    Protein.RightIon(i) = Protein.MW - Protein.LeftIon(i);
end

% to check sum is right

% for i= 1: numel(Protein.LeftIon)
%     Protein.RightIon(i)+Protein.LeftIon(i)
% end

Protein.LeftIon(length(Protein.sequence))= []; % as this will be the MW of protein
Protein.RightIon(length(Protein.sequence))= []; % as this will be zero 

%if this function is for CID (i.e. B-ions and Y-ions)

Protein.LeftIon= Protein.LeftIon + 1.00794; % adding the molecular weight of a hydrogen from left fragment to produce b-ion
Protein.RightIon= Protein.RightIon - 1.00794; % subtracting the molecular weight of a hydrogen from right fragment to produce y-ion

end

%http://www.matrixscience.com/help/fragmentation_help.html