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
function varargout = progress_bar(varargin)
% PROGRESS_BAR MATLAB code for progress_bar.fig
%      PROGRESS_BAR, by itself, creates a new PROGRESS_BAR or raises the existing
%      singleton*.
%
%      H = PROGRESS_BAR returns the handle to a new PROGRESS_BAR or the handle to
%      the existing singleton*.
%
%      PROGRESS_BAR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROGRESS_BAR.M with the given input arguments.
%
%      PROGRESS_BAR('Property','Value',...) creates a new PROGRESS_BAR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before progress_bar_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to progress_bar_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help progress_bar

% Last Modified by GUIDE v2.5 25-Mar-2016 12:19:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @progress_bar_OpeningFcn, ...
                   'gui_OutputFcn',  @progress_bar_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before progress_bar is made visible.
function progress_bar_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to progress_bar (see VARARGIN)

% Choose default command line output for progress_bar

            handles.output = hObject;
            [a,map]=imread('play.jpg');
            [r,c,d]=size(a);  
            x=ceil(r/30);  
            y=ceil(c/30); 
            g=a(1:x:end,1:y:end,:);
            g(g==255)=5.5*255;
             
           set(handles.pushbutton_play,'CData',g);  
            set(handles.pushbutton_play,'String','Start'); 
           set(handles.pushbutton_play,'ForegroundColor',[1 1 1]);
         
     
            [a,map]=imread('stop.jpg');
            [r,c,d]=size(a);  
            x=ceil(r/30);  
            y=ceil(c/30); 
            g=a(1:x:end,1:y:end,:);
            g(g==255)=5.5*255;
            set(handles.pushbutton_stop,'CData',g);  
                  set(handles.pushbutton_stop,'String','Cancel'); 
           set(handles.pushbutton_stop,'ForegroundColor',[1 1 1]);
           
            [a,map]=imread('pause.jpg');
            [r,c,d]=size(a);  
            x=ceil(r/30);  
            y=ceil(c/30); 
            g=a(1:x:end,1:y:end,:);
            g(g==255)=5.5*255;
            set(handles.pushbutton_pause,'CData',g);  
           set(handles.pushbutton_pause,'String','Pause'); 
        %   set(handles.pushbutton_pause,'ForegroundColor',[0 0 0]);
            
            
setappdata(0,'computed_prot',1);
 handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes progress_bar wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = progress_bar_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
%varargout{1} = handles.output;


% --- Executes on button press in pushbutton_play.
function pushbutton_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text_status,'String','Processing .....  ');
setappdata(0,'P_condotion',1);
c=0;
minutes=0;
hours=0;
sec=0;
com_prot=getappdata(0,'computed_prot');


            tic
Database_Path = getappdata(0,'Database_Path'); % Database path of single and batch search modes
Selected_Database = getappdata(0,'Selected_Database'); % Concatenated: Database_Path + Database selected from menu_Database
Batch_Peaklist_Data = getappdata(0,'Batch_Peaklist_Data'); % Peaklist data for BATCH search mode
DirectoryContents=getappdata(0,'BatchFolderContents');
Path=getappdata(0,'path');
I_cd=getappdata(0,'initial_path');
MW_Tolerance = getappdata(0,'Molecular_Weight_Tol'); % Molecular Weight tolerance
Peptide_Tolerance = getappdata(0,'Peptide_Tol'); % Peptide tolerance
PTM_Tolerance = getappdata(0,'PTM_Tol'); % Peptide tolerance
HandleIon = getappdata(0,'HandleIon'); 
User_EST_parameters=getappdata(0,'User_EST_parameters');
initial_path=pwd;
Fixed_Modifications = getappdata(0,'Fixed_Modifications'); % Fixed Modifications
 Variable_Modifications = getappdata(0,'Variable_Modifications'); % Variable Modifications
 Fragmentation_Type = getappdata(0,'Fragmentation_type'); % Fragmentation type
 Experimental_Protein_Mass = getappdata(0,'Experimental_Protein_Mass'); % Experimental Proein Mass (Protein mass)
 Project_Title=getappdata(0,'Project_Title');
 

    for i= com_prot:size(DirectoryContents,1)     % for mgf and text files  (all files present in specified folder)
   clc;    
     Batch_Peaklist_Data(i).name = Batch_Peaklist_Data(i).name(1:end-4);
     Save_Batch_File = strcat(Project_Title,'_',Batch_Peaklist_Data(i).name,'.results');
   
               ec=sec-(c*60); 
        if~(sec==0)&&~mod(sec,60)
                  minutes=minutes+1;
                   c=c+1;
        end
        
         if (minutes==60)
                hours=hours+1; 
                minutes=0;
         end
            
             
      time=size(DirectoryContents,1);
       temp_count=toc;
      
       time_elapse= num2str(toc);
       time_sec=strsplit(time_elapse,'.');
        Time_counter=i/size(DirectoryContents,1);
       
       sec=str2double(time_sec(1)); 
            if((Time_counter<0.26)||Time_counter==1)
                set(handles.text_percent,'String','25%');
                set(handles.text_1,'BackGroundColor',[0 .5 0]);
                set(handles.text_2,'BackGroundColor',[0 .5 0]);
               
            end 
               if((Time_counter>0.25 && Time_counter<0.5)|| Time_counter==1)
                set(handles.text_percent,'String','50%'); 
                set(handles.text_3,'BackGroundColor',[0 .5 0]);
                set(handles.text_4,'BackGroundColor',[0 .5 0]);
                set(handles.text_5,'BackGroundColor',[0 .5 0]);
  
               end
              
               if((Time_counter>0.5 && Time_counter<0.75)||Time_counter==1)
               set(handles.text_percent,'String','75%');
                 set(handles.text_6,'BackGroundColor',[0 .5 0]);
                 set(handles.text_7,'BackGroundColor',[0 .5 0]);
                set(handles.text_8,'BackGroundColor',[0 .5 0]);
               end
               
               if(Time_counter>.75)
                    set(handles.text_percent,'String','100%');
                    set(handles.text_9,'BackGroundColor',[0 .5 0]);
                    set(handles.text_10,'BackGroundColor',[0 .5 0]);
               end
             
        set(handles.text_ID,'String',strcat('ID:',DirectoryContents(i).name));
              set(handles.text_Time,'String',strcat('Time:',num2str(hours),':',num2str(minutes),':',num2str(sec)));
               set(handles.text_NumProt,'String',strcat(num2str(i),'/',num2str(size(DirectoryContents,1))));

                Batch_Search_File = [Path,'\',DirectoryContents(i).name];
             
                if(getappdata(0,'Type_file')==1)
                Imported_Data =  importdata(Batch_Search_File);
                setappdata(0,'Peaklist_Data',Imported_Data);
                Experimental_Protein_Mass = Imported_Data(1,1);
                
                elseif(getappdata(0,'Type_file')==2)
                  file_data = mzxmlread(Batch_Search_File); 
               data_all=mzxml2peaks(file_data, 'Levels', 2);
               [dummy, Index] = sort(cellfun('size',data_all,1), 'descend');
               data_all_sort=data_all(Index);
         
               setappdata(0,'Peaklist_Data',data_all_sort{1});
               
               [data_all,times]=mzxml2peaks(file_data, 'Levels', 1);
               [dummy, Index] = sort(cellfun('size',data_all,1), 'descend');
              Protein_Mass=data_all{Index(1)};
              Experimental_Protein_Mass=Protein_Mass(length(Protein_Mass));
                else 
                
                    Imported_Data =  importdata(Batch_Search_File);
                     if(isstruct(Imported_Data))
                     Data_text=strsplit(Imported_Data.textdata{1})
                     Experimental_Protein_Mass=str2num(Data_text{1})*str2num(Data_text{3})
                    t_data_size= size(Imported_Data.textdata)
                    Data_text=[str2num(Data_text{1}),str2num(Data_text{2})]
                     for t_data=2:t_data_size(1)
                         Data_text=[Data_text;str2num(Imported_Data.textdata{t_data})];
                     end 
                    setappdata(0,'Peaklist_Data',[Data_text;Imported_Data.data]);
                     else
                          setappdata(0,'Peaklist_Data',Imported_Data);
                          Experimental_Protein_Mass = Imported_Data(1,1);
                         
                     end
                  
                end
                %Export_Objects (handles,Batch_Search_File);
            try  
                
                
           %   menu_File = fopen(Save_Batch_File,'a');
               set(handles.text_Exp,'String','Filter DataBase');
               cd(strcat(I_cd,'\Engine'));
               Candidate_ProteinsList_Initial = ParseDatabase(Experimental_Protein_Mass,MW_Tolerance,Database_Path,Selected_Database); 
               cd(initial_path);
               set(handles.text_Exp,'String','Molecular weight scoring');
                cd(strcat(I_cd,'\Score'));% add to path to access Score_Mol_Weight 
               Candidate_ProteinsList_MW=Score_Mol_Weight(Candidate_ProteinsList_Initial,Experimental_Protein_Mass); 
               cd(initial_path)
               set(handles.text_Exp,'String','PST Extraction and scoring');
               cd(strcat(I_cd,'\PST'));
               Tags_Ladder = Prep_Score_ESTs(str2num(User_EST_parameters{1}),str2num(User_EST_parameters{2}),str2num(User_EST_parameters{3}),str2num(User_EST_parameters{4}));
                cd(initial_path);
               cd(strcat(I_cd,'\Engine'));
               set(handles.text_Exp,'String','PTM Indentification and scoring');
               Candidate_ProteinsList = Updated_ParseDatabase(Experimental_Protein_Mass,MW_Tolerance,Tags_Ladder,Candidate_ProteinsList_MW,PTM_Tolerance,Fixed_Modifications,Variable_Modifications );
               set(handles.text_Exp,'String','Insilico Fragmentation and scoring');
               Candidate_ProteinsList = Insilico_frags_Generator_modifier(Candidate_ProteinsList,Fragmentation_Type,HandleIon);
               Matches = Insilico_Score(Candidate_ProteinsList,getappdata(0,'Peaklist_Data'),Peptide_Tolerance);
              set(handles.text_Exp,'String',' Calculating Final Score ');
                % add to path to access Score_Mol_Weight 
                setappdata(0,'Matches',Matches);
                cd(strcat(I_cd,'\Score'));
                final_score;
                 cd(initial_path);
                   %For saving all files in the Directory naming convention: ProjectTitle_Filesname.results
                cd(getappdata(0,'Result_Folder'));
               result=getappdata(0,'Matches');
               menu_File = fopen(Save_Batch_File,'a'); 
                for out_put=1:numel(result)
                header=strcat('>',result{out_put}.Name,'|ID:',num2str(result{out_put}.Id),'|Score:',num2str(result{out_put}.Final_Score),'| Molweight:',num2str(result{out_put}.MolW));
                fprintf(menu_File,header);
                fprintf(menu_File,'\n');
                fprintf(menu_File,result{out_put}.Sequence);
                fprintf(menu_File,'\n');
                end
               fclose(menu_File);
                cd(initial_path)
                com_prot=com_prot+1;
                setappdata(0,'computed_prot',com_prot);
            catch
                cd(initial_path);
               cd(getappdata(0,'Result_Folder'));
                menu_File = fopen(Save_Batch_File,'a'); 
                fprintf(menu_File,'\n');
                fprintf(menu_File,'No Result Found Please serach with another set of parameters'); 
                fclose( menu_File);
                cd(initial_path)
                    continue ;   
                end

    end
    clc;
 cd(initial_path)
    close();
   
              %close(Prohressbar);
%             resultText = strcat(resultFileName,'_',DirectoryContents(i).name,'.results');
%             path = fullfile(parent_folder,resultText);
%            file = fopen(path,'wt');
%             fprintf(file,'Tuned Mass: %s\n', num2str(TunedMW(1)));
%           fclose(file); 

  
% --- Executes on button press in pushbutton_stop.
function pushbutton_stop_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text_status,'String','Cancelling......  ');
close();


% --- Executes on button press in pushbutton_pause.
function pushbutton_pause_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text_status,'String','Paused!  ');
   set(handles.pushbutton_play,'Value',0)
  waitfor(handles.pushbutton_play,'Value',1);


  


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: delete(hObject) closes the figure
delete(hObject);
