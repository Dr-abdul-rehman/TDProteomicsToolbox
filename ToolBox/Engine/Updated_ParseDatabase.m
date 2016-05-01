function [Proteins_Insilico_Spectra] = Updated_ParseDatabase(Protein_ExperimentalMW,MWTolerance,Tags_ladder,Candidate_ProteinsList,PTM_tol,fixed_modifications,variable_modifications )
%data = strcat(data1,data);
%'C:\Users\Hira\Desktop\Summer 2014\Toolbox\uniprot_sprot.fasta';
% source_filePath = 'C:\Users\Hira\Desktop\Summer 2014\Toolbox\ubiquitin_db.fasta';
%'C:\Users\Hira\Desktop\Summer 2014\Toolbox\ESTs';

Proteins_Insilico_Spectra = {};

%for index = 1: numel(Candidate_ProteinsList)
    
  index=1;
    Header = Candidate_ProteinsList{index}{1}; % Header
    Sequence = Candidate_ProteinsList{index}{3}; % seq
  
     Protein_i= strsplit( Header,'|'); % second index has the protein id
     si=size(Protein_i);
     if (si(2)-1)
     Protein_id=Protein_i{2};
     else
         Protein_id='';
     end
    [Final_EST_Score,Tag_indices] = PST_Score(Tags_ladder,Sequence);
    
   % if (Tag_indices) % if tag is found in the sequence
        
        
        
        %% ---- Extract Database Protein Name ---------
        Protein_info = regexp(Header,' OS','split'); %break string before 'OS' found in string - protein name is before 'OS'
        Header_start = Protein_info{1}; % get the initial part of the header
        space_index = strfind(Header_start,' '); % find space in the string containing name
        Protein_name = Header_start (space_index(1)+1:end);
        
        %% Generate sequences with PTMs and filter according to MW
        Shortlisted_ModProteins_W = WithoutPTM_ParseDatabase(Tags_ladder,Candidate_ProteinsList);
        Proteins_Insilico_Spectra = [Proteins_Insilico_Spectra; Shortlisted_ModProteins_W];
       initial_path= getappdata(0,'initial_path');
        addpath(strcat(initial_path,'\','PTM'));
        Shortlisted_ModProteins = PTMs_Generator_Insilico_Generator(Candidate_ProteinsList{index},Sequence,Protein_ExperimentalMW,MWTolerance,Protein_name,Protein_id,PTM_tol,fixed_modifications,variable_modifications,Final_EST_Score);
        Proteins_Insilico_Spectra = [Proteins_Insilico_Spectra; Shortlisted_ModProteins];
         rmpath(strcat(initial_path,'\','PTM'));
        
        
 %   end
    
%end
end