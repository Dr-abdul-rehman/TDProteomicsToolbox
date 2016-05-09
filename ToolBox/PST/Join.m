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
%% This function is used to join the Peptide Sequence tags
function AA_Next=Join(Home_peak,length_tags,Hop_Info,Num_AAs_Found)

    AA_Next= Hop_Info{Home_peak};
    for Start_peak=Home_peak:(Num_AAs_Found-1)
        Hop_peak=(Start_peak+1);

        if(Hop_Info{Home_peak}{2}==Hop_Info{Hop_peak}{1})
            length_tags=length_tags+1;
            AA_Next=Join(Hop_peak,length_tags,Hop_Info,Num_AAs_Found);
            AA_Next= [Hop_Info{Home_peak};AA_Next];
        end
    end
end
