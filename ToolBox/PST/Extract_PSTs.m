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
function Ladders_List =  Extract_PSTs(Peak_List, User_max_TagLength_Threshold,User_Hop_Threshold)
    
    Ladders_List=[];
    AA_monoisotopicMass=Monoisotopic_weight;
Hop_Info={} ;
Ladder_Index = 00; %index ladder
User_Hop_Threshold = User_Hop_Threshold/17;
for Peak_Index = 1:(size(Peak_List,1)-1) % Hop_Index
    for Hop_Index = (Peak_Index+1) : size(Peak_List,1)
        % Molecular weight difference between two peaks
        Peaks_MW_Difference = Peak_List(Hop_Index) - Peak_List(Peak_Index);
        for AminoAcid_Index = 1:33 % need to change
            Error = Peaks_MW_Difference - AA_monoisotopicMass{AminoAcid_Index}{3};
            if abs ( Error)  <= User_Hop_Threshold
                
                Ladder_Index =Ladder_Index + 1;
                % Error = calculated MW of peaks - actual weight of the amino acid
                

                Hop_Info{Ladder_Index} = {Peak_Index,Hop_Index,Peak_List(Peak_Index),...
                    Peak_List(Hop_Index),Peaks_MW_Difference, ...
                    AA_monoisotopicMass{AminoAcid_Index}{2},AA_monoisotopicMass{AminoAcid_Index}{3},Error...
                    (Peak_List(Peak_Index,2)+Peak_List(Hop_Index,2))/2};
            end
        end
    end
end


Num_AAs_Found=(length(Hop_Info)-1); ladder={}; counter=0;
length_tags=1;
Ladder_raw={};
for Home_peak=1:(Num_AAs_Found-1)
    
    for Strat_peak=1:(Num_AAs_Found-1)
        AA_Next='';
        
        Hop_peak=(Strat_peak+1);
        if(Hop_Info{Home_peak}{2}==Hop_Info{Hop_peak}{1})
            AA_Next=Join(Hop_peak,length_tags,Hop_Info,Num_AAs_Found);
            AA_Next=[Hop_Info{Home_peak};AA_Next];
            %           AA_Next=strcat(Hop_Info{Home_peak}{6},AA_Next);  
               Ladder_raw{length_tags,1}= AA_Next;
            length_tags = length_tags+1;
        
        end
     
    end
    
    %    disp(num2str(length_tags));
    %        ladder{ladder_index}= Join(ladder_index,Num_AAs_Found,Hop_Info,length_tags);
end
 if(~isempty(Ladder_raw))
    Ladders_List = ladder_extrection_trim(Ladder_raw,User_max_TagLength_Threshold);
 end
end
