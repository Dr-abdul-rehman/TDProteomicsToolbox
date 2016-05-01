function [Tuned_MolWt, Fragments_SumofMolWt,Fragments_MaxIntensity ,Fragments_SumofIntensity,Histc_Unique_Fragments_MolWt,Unique_Fragments_Occurrences] =  FilterProteinMWs(SliderValue,Intact_Protein_Mass)
%global File_Path;
       
    %PeaksData.mz=importdata(File_Path);                         %reads the mass spec data file
   
%     PeaksData.Experimental_Protein_Mass = PeaksData.mz(1,1);             % obtain the molcular weight and intensity from file
%     Sorted= sortrows(PeaksData.mz,1);                                  % sort the molcular weight in an ascending order
%     PeaksData.Peaks_List_MolWt = Sorted(:,1);                                % obtain the sorted peak list molcular weights
%     PeaksData.Fragments_Selected = {};                                         % initialize variable
%     k=0;
%     PeaksData.Peaks_List_Intensity = Sorted(:,2);                                 %obtain the intensity from the sorted peak list

    % Reads the object (from LUMSProT.m) containing peak list molecular weights
    PeaksData.Peaks_List_MolWt = getappdata(0,'Fragments_Masses');
    % Reads the object (from LUMSProT.m) containing peak list intensities
%     PeaksData.Peaks_List_Intensity = getappdata(0,'Fragments_Intensities');
    % Reads the object (from LUMSProT.m) containing peak list intact protein experimental mass
    PeaksData.Peaks_List_Intensity = rand(252,1);
    PeaksData.Experimental_Protein_Mass = Intact_Protein_Mass;
    if isstr(PeaksData.Experimental_Protein_Mass)
        PeaksData.Experimental_Protein_Mass=str2num(PeaksData.Experimental_Protein_Mass);
    end
    k = 0;
    PeaksData.WholeProtein_Tolerance_PPM = SliderValue;                  %set the tolerance equal to the initial slider value provided by user
    PeaksData.Fragment_Tolerance = 0.001;                               %set the tolerance of the fragments in daltons (tolerance is 0.01% of the whole weight of the fragment)
   % PeaksData.Fragment_Tolerance =  150.0; %getappdata(0,'Peptide_Tol');
    PeaksData.Final_Tolerance = 0;                                       %Initialization of final tol variable
    PeaksData.Sum_of_Fragments_Tolerance = 0;                              %Initialization of tolrance of sum of fragments variable
    PeaksData.WholeProtein_Calculated_Tolerance = (PeaksData.WholeProtein_Tolerance_PPM * PeaksData.Experimental_Protein_Mass)/ (10^6); % tolerance in daltons


    % summing up fragments and selecting the ones which are in a certain
    % tolerance of the experimental whole protein molecular weight
    % if the 2 fragments are in the certain tolerance their intensities are
    % compared and the maximum intensity is chosen and stored in a cell
    for i = 1:size(PeaksData.Peaks_List_MolWt,1)                               %for loop which runs for the number of fragments in the peak list
        if i == size(PeaksData.Peaks_List_MolWt,1)                           % break the loop when the last fragment is chosen in the peak list
            break
        else
            for j = i+1:size(PeaksData.Peaks_List_MolWt,1)
                PeaksData.Sum_of_MolWt = PeaksData.Peaks_List_MolWt(i,1) + PeaksData.Peaks_List_MolWt(j,1);         %sum up one MW fragment with all the fragments present after it
                PeaksData.Sum_of_Fragments_Tolerance = PeaksData.Sum_of_MolWt * PeaksData.Fragment_Tolerance; % calculate tolerance of the sum of fragments (0.01% * MW)
                PeaksData.Final_Tolerance = PeaksData.WholeProtein_Calculated_Tolerance +  PeaksData.Sum_of_Fragments_Tolerance; % %calculate the final tolerance which is sum of whole protein tolerance and tolerance of the fragments
                if abs(PeaksData.Sum_of_MolWt - PeaksData.Experimental_Protein_Mass) <= PeaksData.Final_Tolerance; %if the difference between the sum of molcular weights and experimental peak list is within the set tolerance then the sum of molecular weights is chosen
                    k=k+1;
                    if PeaksData.Peaks_List_Intensity(i) > PeaksData.Peaks_List_Intensity(j) %compare the intensity and select the highest intensity from the sum to display in the GUI
                        PeaksData.Fragment_Max_Intensity = PeaksData.Peaks_List_Intensity (i);
                    else
                        PeaksData.Fragment_Max_Intensity = PeaksData.Peaks_List_Intensity (j);
                    end
                    PeaksData.Fragments_Selected{k,1} = {PeaksData.Sum_of_MolWt ,PeaksData.Fragment_Max_Intensity, i , j}; %store the intensity, sum of fragments and their fragment numbers in a cell
                end %  if abs(PeaksData.Sum_of_MolWt - PeaksData.Experimental_Protein_Mass) <= PeaksData.Final_Tolerance
            end % for j=i+1:size(PeaksData.Peaks_List_MolWt,1)
        end % if i == size(PeaksData.Peaks_List_MolWt,1)
    end % for i=1:size(PeaksData.Peaks_List_MolWt,1)

    Fragments_SumofMolWt = zeros(k,1);                            %initialize variable containing MW fragments with limited size
    Fragments_MaxIntensity = zeros(k,2) ;                       %initialize variable containing intensities with limited size
    %intensity and sum of fragments molcular weight is stored in an array
    for m=1:k
        Fragments_SumofMolWt(m) = cell2mat ( PeaksData.Fragments_Selected{m,1}(1));          %convert the cell array of stored MW sums into a numeric array
        Fragments_MaxIntensity(m,2) = cell2mat ( PeaksData.Fragments_Selected {m,1} (2)); %convert the cell array of stored intensities into a numeric array
    end

    Fragments_MaxIntensity(:,1) =  Fragments_SumofMolWt;



    Fragments_SumofIntensity = zeros(size(Fragments_MaxIntensity,1),1);
    Fragments_MaxIntensity = sortrows(Fragments_MaxIntensity,1); % selected intensities are sorted in an ascending order

    % for an interval of 1 Dalton all the intensities within the range are summed up

    for h = 1:size(Fragments_MaxIntensity,1)
        for g = 1:size(Fragments_MaxIntensity,1)
            if abs(Fragments_MaxIntensity(h,1) - Fragments_MaxIntensity(g,1)) <= 0.1
                Fragments_SumofIntensity(h) = Fragments_SumofIntensity(h) + Fragments_MaxIntensity(g,2);
            end  
        end % for g= 1:size(Fragments_MaxIntensity,1)
    end % for h= 1:size(Fragments_MaxIntensity,1)

    Fragments_SumofIntensity = Fragments_SumofIntensity/100;                           %sum of intensity is divided by 100
   
if isempty(Fragments_SumofIntensity)
    Tuned_MolWt=0;
    Fragments_SumofMolWt=0;
    Fragments_MaxIntensity=0;
    Fragments_SumofIntensity=0;
    Histc_Unique_Fragments_MolWt=0;
    Unique_Fragments_Occurrences=0;
    return 
end
    
    %Normalization to  be between 0 and 1
    Fragments_MaxIntensity (:,2) = (Fragments_MaxIntensity (:,2)- min(Fragments_MaxIntensity (:,2)))/(max(Fragments_MaxIntensity (:,2))- min(Fragments_MaxIntensity (:,2)));
    Fragments_SumofIntensity = (Fragments_SumofIntensity- min(Fragments_SumofIntensity))/ (max(Fragments_SumofIntensity)- min(Fragments_SumofIntensity));

    % for an interval of 0.1 Da the no of occurances of Mw fragments in that
    % window are plotted as a frequency ( divided by 100)


Fragments_Selected_SumofMolWt_Rounded = round(Fragments_SumofMolWt*100000)/100000;                                      %round off the molcular weight fragments to 5 decimal places
Fragments_Selected_SumofMolWt_Rounded = sort(Fragments_Selected_SumofMolWt_Rounded); % sort the MWs in an ascending order

[Unique_Selected_Fragments,Unique_Corresponding_Intensities ] = unique(Fragments_Selected_SumofMolWt_Rounded);   %select only the unique weights and get their indexes
%for the repeated MWs take the mean of their corresponding intensities and
%place them against the unique MWs
for f= 1:size(Unique_Selected_Fragments)
    if f == 1
        Final_Intensity_Sum(f)= mean(Fragments_SumofIntensity(1:(Unique_Corresponding_Intensities(f))));
    else
        Final_Intensity_Sum(f)= mean(Fragments_SumofIntensity((Unique_Corresponding_Intensities(f-1))+1:(Unique_Corresponding_Intensities(f))));
    end
end

    Histc_Unique_Fragments_Selected = [Unique_Selected_Fragments,histc(Fragments_Selected_SumofMolWt_Rounded(:),Unique_Selected_Fragments)];
    Histc_Unique_Fragments_Selected_Size = size(Histc_Unique_Fragments_Selected,1);
    Histc_Unique_Fragments_MolWt = zeros(Histc_Unique_Fragments_Selected_Size,1);
    Unique_Fragments_Occurrences = zeros(Histc_Unique_Fragments_Selected_Size,1);
    % find Histc_Unique_Fragments_Selected the number of occurances of each MW at an interval of 1
    % Dalton
    for d=1:Histc_Unique_Fragments_Selected_Size
        Histc_Unique_Fragments_MolWt(d) = Histc_Unique_Fragments_Selected(d,1);
        Unique_Fragments_Occurrences(d) = Histc_Unique_Fragments_Selected(d,2);
    end

     Unique_Fragments_Occurrences = Unique_Fragments_Occurrences/100  ;                                             %divide the number of occurance by 100


    %% Calculating the score to determine the tuned MW
    Score_of_Peaks= 2.*( Unique_Fragments_Occurrences/100); %peaks score based on their frequency
    Final_Intensity_Sum = transpose(Final_Intensity_Sum); %take transpose to convert from column to row vector

    Score_of_Intensity = Final_Intensity_Sum/100; %intensity score based on its frequency

    Total_Score = Score_of_Peaks + Score_of_Intensity; %total score is the sum of the score fo intensity and MW
    [Max_Score Max_Score_Index] = max(Total_Score);
    % choose the MW with the highest score for a specific tolerance value

    
    Tuned_MolWt = Unique_Selected_Fragments(Max_Score_Index) ;
    
    