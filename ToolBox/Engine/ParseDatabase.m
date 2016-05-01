function [Candidate_ProteinsList] = ParseDatabase(Protein_ExperimentalMW,MWTolerance,source_filePath,idx_file_dir)
   
    bio_Object = BioIndexedFile('FASTA',idx_file_dir);
    clc;
    NumEntries = bio_Object.NumEntries;
    Candidate_ProteinsList = {};
    Filtered_Protein=0;
    for Num_Protein = 1: NumEntries
        %     [Header,Sequence] = fastaread('C:\Users\Hira\Desktop\Summer 2014\Toolbox\uniprot_sprot.fasta','BLOCKREAD', k);
        Entry = getEntryByIndex(bio_Object,Num_Protein);

        %% Extract Sequence and Header
        NewLine_chars = strfind(Entry,char(10));
        Header = Entry(2:NewLine_chars(1)-1); % header is separated by first NewLine char - get header without Newline char
        Sequence = Entry(NewLine_chars(1)+1:end);
        Sequence = strrep(Sequence,char(10),''); % remove new line chars from sequence too

        %% --- Calculate Molecular Weight of Database Protein
        DBProtein_MW = Return_Protein_MW(Sequence);
        %Check if MW of Database protein is within the MW tolerance and get
        %list of candidate proteins
        if abs(DBProtein_MW - Protein_ExperimentalMW)<= MWTolerance % initial List of condidate Proteins after applying
            Filtered_Protein= Filtered_Protein+1;                          % Molecular Weight as filter 
            Candidate_ProteinsList{Filtered_Protein}{1}=Header;
            Candidate_ProteinsList{Filtered_Protein}{2}=DBProtein_MW;
            Candidate_ProteinsList{Filtered_Protein}{3}=Sequence;
        end
    end
end

