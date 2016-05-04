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
function [computed_mass]=Return_Protein_MW(seq)% function to compute mass of proteins from database
AA_monoisotopicMass=Monoisotopic_weight;% to get mono-isotopic mass of amino acids
mass=0.0;
len_pro=length(seq);
for index_AA=1:len_pro
           mass=(mass+GetMWofAA( seq(index_AA)))-18.0129; % calculate Mol.weight of proteins       
end

computed_mass=(mass+((len_pro+1)*18.0129));%  Mol.weight of proteins 



