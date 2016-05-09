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
function [Candidate_ProteinsList_MW_score]=Score_Mol_Weight(Candidate_ProteinsList,Prot_Intact_MW)
 for index=1:length(Candidate_ProteinsList)
        Candidate_ProteinsList_MW_score{index}{1}=Candidate_ProteinsList{index}{1};% store protein's name
        Candidate_ProteinsList_MW_score{index}{2}=Candidate_ProteinsList{index}{2};% store protein's mass
        Candidate_ProteinsList_MW_score{index}{3}=Candidate_ProteinsList{index}{3};%Store protein's  seq
        ERROR=abs(Prot_Intact_MW-Candidate_ProteinsList{index}{2});
        if(ERROR==0)
          MW_score=1;   %diff=0 mw_score=1
        else
        MW_score=10/(ERROR);% compute mol_weight Score for proteins via mw_score=10/|diff|
        end
       Candidate_ProteinsList_MW_score{index}{4}=MW_score;%store protein's       
end
