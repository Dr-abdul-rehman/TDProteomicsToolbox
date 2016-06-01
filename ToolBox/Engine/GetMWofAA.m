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
function dblMWAA = GetMWofAA( strAminoAcid ) 
%function reading the letter code of a specific amino acid and returing back its MW
C_M=getappdata(0,'Othermodification_Cysteine');% to get user defined chemical modifications on cysteine residue
M_M=getappdata(0,'Othermodification_Methionine');% to get user defined chemical modifications on methionine residue
  


    dblMWAA = 0; %initialize MW variable
    MW = Monoisotopic_weight;
    switch(strAminoAcid)
        case 'M'                %If AA is  Methionine return its MW
           if strcmp(M_M,'MSO') % for  modified Cysteine 
                 dblMWAA=147.0354;
            elseif strcmp(M_M,'M_S')
                dblMWAA=32.00;
           else
               dblMWAA = MW{14,1}{3} ;
           end
        case 'Q'                %If AA is  Glutamine return its MW
        dblMWAA = MW{11,1}{3};
        case 'A'                %If AA is Alanine return its MW
        dblMWAA = MW{2,1}{3};
        case 'R'                %If AA is Arginine return its MW
        dblMWAA = MW{17,1}{3};
        case 'N'                %If AA is Asparagine return its MW
        dblMWAA = MW{9,1}{3};
        case 'D'                %If AA is  Aspartic Acid return its MW
        dblMWAA = MW{10,1}{3};
        case'C'                %If AA is Cysteine return its MW
             if strcmp(C_M,'Cys_CAM') % for  modified Cysteine 
                 dblMWAA=160.03065;
            elseif strcmp(C_M,'Cys_CM')
                dblMWAA=161.01466;
            elseif strcmp(C_M,'Cys_PE')
                dblMWAA=208.067039;
                elseif strcmp(C_M,'Cys_PAM')
                 dblMWAA=174.04631;
             else
                dblMWAA = MW{7,1}{3};
             end
        case 'E'               %If AA is  Glutamic acid return its MW
        dblMWAA = MW{13,1}{3};
        case 'G'               %If AA is Glycine its MW
        dblMWAA = MW{1,1}{3};
        case 'H'                %If AA is Histidine return its MW
        dblMWAA = MW{15,1}{3};
        case  'I'               %If AA is Isoleucine return its MW
        dblMWAA = MW{8,1}{3};
        case  'L'               %If AA is Leucine return its MW
        dblMWAA = MW{8,1}{3};
        case 'K'%If AA is Lysine its MW
        dblMWAA = MW{12,1}{3};
        case 'F'%If AA is Phenylalanine its MW
        dblMWAA = MW{16,1}{3};
        case'P'%If AA is Proline return its MW
        dblMWAA = MW{4,1}{3};
        case 'S'%If AA is Serine return its MW
        dblMWAA = MW{3,1}{3};
        case 'T'%If AA is Threonine return its MW
        dblMWAA = MW{6,1}{3};
        case 'W'%If AA is Tryptophan return its MW
        dblMWAA = MW{19,1}{3};
        case 'Y'        %If AA is Tyrosine return its MW
        dblMWAA = MW{18,1}{3};
        case 'V'%If AA is Valine return its MW
        dblMWAA = MW{5,1}{3};         
        otherwise
        dblMWAA = MW{21,1}{3};  
    end    
    %http://www.matrixscience.com/help/aa_help.html
end
