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
function [AA_monoisitopicMass]=Monoisotopic_weight
AA_monoisitopicMass={
                    {'Gly','G',57.02146,57.0519};{'Ala','A',71.03711,71.0788}; %monoisotopic and average mass of amino acids
                    {'Ser','S',87.03203,87.0782};{'Pro','P',97.05276,97.1167}; %with one and three letter alphabitical representation 
                    {'Val','V',99.06841,99.1326};{'Thr','T',101.04768,101.1051};%Mol.Wieght are obtained from expasy.
                    {'Cys','C',103.00919,103.1388};
                    {'Leu','L',113.08406,113.1594};{'Asn','N',114.04293,114.1038};
                    {'Asp','D',115.02694,115.0886};{'Gln','Q',128.05858,128.1307};
                    {'Lys','K',128.09496,128.1741};{'Glu','E',129.04259,129.1155};
                    {'Met','M',131.04049,131.1926};{'His','H',137.05891,137.1411};
                    {'Phe','F',147.06841,147.1766};{'Arg','R',156.10111,156.1875};
                    {'Tyr','Y',163.06333,163.1760};{'Trp','W',186.07931,186.2132}; 
                    {'PHOS_Y','Y',79.9663+163.06333,79.9799+163.1760};% modified amino acid addition for PTM
                    {'PHOS_T','T',79.9663+101.04768,79.9799+101.1051};
                    {'PHOS_S','S',79.9663+87.03203,79.9799+87.0782};
                    {'METH_K','K',14.0157+128.09496,14.0269+128.1741};
                    {'METH_R','R',14.0157+156.10111,14.0269+156.10111};
                    {'ACET_R','R',42.0106+156.10111,42.0373+156.1875};
                    {'ACET_S','S',42.0106+87.03203,42.0373+87.0782};
                    {'ACET_K','K',42.0106+128.09496,42.0373+128.1741};
                    {'ACET_K','K',42.0106+128.09496,42.0373+128.1741};
                    {'AMID_F','F',-0.9840+147.068414,-0.9847+147.1739};
                    {'HYDX_P','P',15.9949+97.05276,15.9949+97.1167};
                    {'O-glyco_T','T',203.0794+101.04768,203.1950+101.1051};
                    {'O-glyco_S','N',203.0794+87.03203,87,203.1950+87.0782};
                    {'N-glyco_N','S',3491.1373+114.04293,3491.1373+114.1038};
                   };
end
