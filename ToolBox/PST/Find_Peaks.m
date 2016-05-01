% function  protsave= findpeaks(AminoAcidTags, AminoAcidMWs, Peak_List)
function  Hop_Info = Find_Peaks(AminoAcid_Tags, AminoAcid_MWs, Peak_List,User_Hop_Threshold)

    Hop_Info={} ;
    % User_Hop_Threshold = 0.001; % in Daltons

   Ladder_Index = 00; %index ladder

    for Peak_Index = 1:(size(Peak_List,1)-1) % Hop_Index
        for Hop_Index = (Peak_Index+1) : size(Peak_List,1)
            % Molecular weight difference between two peaks
            Peaks_MW_Difference = Peak_List(Hop_Index) - Peak_List(Peak_Index);
            for AminoAcid_Index = 1:20
                if abs ( AminoAcid_MWs(AminoAcid_Index)- Peaks_MW_Difference)  <= User_Hop_Threshold
                    
                   Ladder_Index =Ladder_Index + 1;
                   % Error = calculated MW of peaks - actual weight of the amino acid
                    Error = Peaks_MW_Difference - AminoAcid_MWs(AminoAcid_Index);
                    % Store following to Hop_Info: 
                        % Current peak index
                        % Next peak
                        % Amino acid Tag
                    	% Amino acid Mol wts
                        Hop_Info{Ladder_Index} = {Peak_Index,Hop_Index,Peak_List(Peak_Index),...
                        Peak_List(Hop_Index),Peaks_MW_Difference, ...
                        AminoAcid_Tags(AminoAcid_Index),AminoAcid_MWs(AminoAcid_Index),Error...
                        (Peak_List(Peak_Index,2)+Peak_List(Hop_Index,2))/2};
                end
            end
        end
    end

    % checks consecutive tags and places them in the same cell
    for Start_Peak = 1:Ladder_Index
        AA_info = 1;
        for End_Peak = (Start_Peak+1):Ladder_Index
            if (Hop_Info{1,Start_Peak}{1,2} == Hop_Info{1,End_Peak}{1,1})% if ending peak of one is same as starting peak of another
                AA_info = AA_info+1; % AA_info in new row
                % then store all atributes of the target hop (Hop_Index) in new AA_info of Hop_Info:
     
                Hop_Info{1,Start_Peak}{AA_info,1} = Hop_Info{1,End_Peak}{1,1};  % Current peak index
                Hop_Info{1,Start_Peak}{AA_info,2} = Hop_Info{1,End_Peak}{1,2};  % Next peak index
                Hop_Info{1,Start_Peak}{AA_info,3} = Hop_Info{1,End_Peak}{1,3};  % Current peak index value
                Hop_Info{1,Start_Peak}{AA_info,4} = Hop_Info{1,End_Peak}{1,4};  % Next Peak index value
                Hop_Info{1,Start_Peak}{AA_info,5} = Hop_Info{1,End_Peak}{1,5} ; % Mol wt difference bw two peaks
                Hop_Info{1,Start_Peak}{AA_info,6} = Hop_Info{1,End_Peak}{1,6};  % Amino acid name of the next peak
                Hop_Info{1,Start_Peak}{AA_info,7} = Hop_Info{1,End_Peak}{1,7};  % Amino acid mol wt of the next peak
                Hop_Info{1,Start_Peak}{AA_info,8} = Hop_Info{1,End_Peak}{1,8};  % Error 
                Hop_Info{1,Start_Peak}{AA_info,9} = Hop_Info{1,End_Peak}{1,9};  % mean of frequencies of two peaks

            end
        end
    end

end % end function  findpeaks()




