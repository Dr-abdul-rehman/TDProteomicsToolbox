function [computed_mass]=Return_Protein_MW(seq)% function to compute mass of proteins from database
AA_monoisotopicMass=Monoisotopic_weight;% to get mono-isotopic mass of amino acids
mass=0.0;
len_pro=length(seq);
for index_AA=1:len_pro
           mass=(mass+GetMWofAA( seq(index_AA)))-18.0129; % calculate Mol.weight of proteins       
end

computed_mass=(mass+((len_pro+1)*18.0129));%  Mol.weight of proteins 



