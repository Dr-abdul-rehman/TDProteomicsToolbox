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
function varargout = Detail_view(varargin)
% DETAIL_VIEW MATLAB code for Detail_view.fig
%      DETAIL_VIEW, by itself, creates a new DETAIL_VIEW or raises the existing
%      singleton*.
%
%      H = DETAIL_VIEW returns the handle to a new DETAIL_VIEW or the handle to
%      the existing singleton*.
%
%      DETAIL_VIEW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DETAIL_VIEW.M with the given input arguments.
%
%      DETAIL_VIEW('Property','Value',...) creates a new DETAIL_VIEW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Detail_view_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Detail_view_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Detail_view

% Last Modified by GUIDE v2.5 16-Mar-2016 15:49:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Detail_view_OpeningFcn, ...
                   'gui_OutputFcn',  @Detail_view_OutputFcn, ...
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


% --- Executes just before Detail_view is made visible.
function Detail_view_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Detail_view (see VARARGIN)

% Choose default command line output for Detail_view
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Detail_view wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Detail_view_OutputFcn(hObject, eventdata, handles) 
%%
%%varibales contained data to be displayed
Tags_Ladder=getappdata(0,'Tags_Ladder');
%Matches=getappdata(0,'Matches');
data=getappdata(0,'data');
index=getappdata(0,'Rank');
Protein_Sequence=data{index,5};
len_pro=length(Protein_Sequence)-1;
setappdata(0,'len',len_pro);
Protein_Name=data{index,1};
Protein_ID=data{index,2};
Protein_Rank=index;
AminoAcid_Matches= ['/ ',num2str(len_pro)];
matche_count=0;
Protein_Score=data{index,4};
Whole_Protein_Mass=data{index,3};
%%
Symbols_Modifications=[{'\varpi'},{texlabel('omega')},{texlabel('psi')},{texlabel('alpha')},{'\Theta'},{'\otimes'},{'\oplus'},{'\oslash'},{'\nabla'},{texlabel('Delta')},{'\clubsuit'},{'\heartsuit'},{'\spadesuit'},{'\diamondsuit'}];
Name_Modifications=[{'Phos_Y'},{'Phos_T'},{'Phos_S'},{'Amid_F'},{'Acet_A'},{'Acet_K'},{'Acet_S'},{'Acet_R'},{'Meth_R'},{'Meth_K'},{'N-li_N'},{'O-li_S'},{'O-li_T'},{'Hydr_P'}];
 
X_Axis_Position=0.6;
Y_Axis_Firstline=0.3;
Y_Axis_Secondline=-.4;

Display_Protein_Name=['>Prot Name:  ',Protein_Name,'                                                      ID: ',Protein_ID];
Display_Protein_Nameb=['                                                                                                         ID:  '];

format_Display_Protein_Name=text(X_Axis_Position-.1,Y_Axis_Firstline-0,Display_Protein_Name);
%format_Protein_ID=text(X_Axis_Position+.4,Y_Axis_Firstline-0,Display_Protein_Nameb);
set(format_Display_Protein_Name,'FontSize',10);
%set(format_Protein_ID,'FontSize',10);
set(format_Display_Protein_Name,'FontWeight','bold');
set(format_Display_Protein_Name,'color','b');
second_line=['  Mass:                          Score:                                        Rank:                                       Matches:',];
second_line2=['>             ',num2str(Whole_Protein_Mass) ,'                            ',num2str(Protein_Score),'                                 ',num2str(Protein_Rank),'                                                       ',AminoAcid_Matches];
format_secondline=text(X_Axis_Position,Y_Axis_Secondline-0,second_line);     
format_secondline2=text(X_Axis_Position-.1,Y_Axis_Secondline-0,second_line2);
set(format_secondline,'FontSize',9);
set(format_secondline,'FontWeight','bold');
set(format_secondline,'color','b');
set(format_secondline2,'FontSize',9);

%%
 
%::::::::::::::::::::display mass_protein::::::::::::::::::

X_Axis_Position_vertical_Line=1; X_Axis_Position_vertical=1.7;
y1=-2;
x_axis1=2.8;
y_axis1=1;
AminoAcid_Insilico_Mass=0;
x_axis2=2;
y_axis2=1.3;
w2=-2; w3=-2.3;

for len=1:len_pro
    if mod(len,17)==0
        y_axis1=y_axis1+2.5;
        x_axis1=0.3;
         y_axis2=y_axis2+2.5;
        x_axis2=-0.4;
    end
    addpath(strcat(pwd,'\PTM'));
     AminoAcid_Insilico_Mass= GetMWofAA(Protein_Sequence(len));
      handles.AA_sequence_disp=text(1.5+x_axis2,w2-y_axis2,Protein_Sequence(len));
    handles.AA_number_disp=text(2.3+x_axis2,w3-y_axis2,num2str(len));
     for idx=1:length(Tags_Ladder)
        if(strcmp(Tags_Ladder{idx}{1},Protein_Sequence(len)))
            matche_count=matche_count+1;
            set(handles.AA_sequence_disp,'color','b')
              AminoAcid_Experimental_Mass=AminoAcid_Insilico_Mass+Tags_Ladder{idx}{3};
               h1=text((X_Axis_Position+x_axis1),(y1-y_axis1),num2str(AminoAcid_Experimental_Mass));
                set(h1,'Rotation',90);
                set(h1,'FontSize',7.5);
                set(h1,'color','b');
        end
     end
     
   
    set(handles.AA_number_disp,'FontSize',6.5);
    set(handles.AA_sequence_disp,'FontSize',11);
    h2=text((X_Axis_Position_vertical_Line+x_axis1),(y1-y_axis1),'---');%
    h3=text((X_Axis_Position_vertical+x_axis1),(y1-y_axis1),num2str(AminoAcid_Insilico_Mass));
    set(h2,'Rotation',90);
    set(h2,'FontSize',20);
    set(h3,'Rotation',90);
    set(h3,'FontSize',7.5);
    % protein_data={Name,ID,num2str(MolW),num2str(Score),Sequence,PTM_score,PTM_name,consensus_window,EST_Score,PTM_seq_idx,PTM_site,MWScore,...
       % Matches_Score,LeftIons,RightIons}   
  %:::::::::::::::::::::::::add modification in sequence::::::
    if (data{index,10}+1)  
        if (length(data{index,10}==1))
            %(length(Matches{index}.PTM_seq_idx)==1)
            name_mod=strcat(data{index,7},'_', data{index,11});
            for bi=1:14
                if(strcmp(Name_Modifications(bi),name_mod))
                    id_sym=bi;
                end
            end
            if(data{index,10}==len)
                k=text((X_Axis_Position_vertical_Line+x_axis1),((y1-y_axis1)+2.5), Symbols_Modifications(id_sym));
                set(k,'FontSize',14);
                set(k,'color','r');
            end
        else
        for li=1:length(data{index,10}) 
         name_mod=strcat(data{index,10}(li,1:4),'_', data{index,11});
             for bi=1:14
                if(strcmp(Name_Modifications(bi),name_mod(li,1:6)))
                     id_sym=bi;
                 end
             end
           if(data{index,10}(li)==len)
                k=text((X_Axis_Position_vertical_Line+x_axis1-.2),((y1-y_axis1)+1.3), Symbols_Modifications(id_sym));
                set(k,'FontSize',10);
                set(k,'color','r');
            end
        end 
       end
    end
x_axis1=x_axis1+2.4;
x_axis2=x_axis2+2.4;
end

h4=text(X_Axis_Position+32.3,Y_Axis_Secondline-0,num2str(matche_count));
set(h4,'FontSize',8);
set(handles.slider2,'Value',1);
set(handles.AA,'ToolTipString','Alphabetical representation of amino acids');
set(handles.s_mass,'ToolTipString','In silico mass');
set(handles.e_mass,'ToolTipString','Experimental mass');
set(handles.position,'ToolTipString','Position of amino acid in protein sequence');
set(handles.mod,'ToolTipString','Type of postranslational modifications (PTMs)');
clc
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
b = get(hObject,'Value');
a=1-b;
pos=get(handles.axes1,'Position');
Matches=getappdata(0,'Matches');
index=getappdata(0,'Rank');
Protein_Sequence= data{index,5};
len_pro=length(Protein_Sequence)-1;
condition=ceil(len_pro/100);
% display protein sequence
switch condition
    case 1
        set(handles.axes1,'Position',[pos(1) (a*1)+30 pos(3) pos(4)]);
    case 2
        set(handles.axes1,'Position',[pos(1) (a*30)+30 pos(3) pos(4)]);
    case 3
        set(handles.axes1,'Position',[pos(1) (a*40)+30 pos(3) pos(4)]);
    case 4
        set(handles.axes1,'Position',[pos(1) (a*50)+30 pos(3) pos(4)]);
    otherwise
        set(handles.axes1,'Position',[pos(1) (a*60)+30 pos(3) pos(4)]);
end




%30+(a*30)

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .6 .9]);
end


% --------to call legend
function uitoggletool2_OnCallback(hObject, eventdata, handles)
run('legend.m');

% --- Executes during object creation, after setting all properties.
function uipanel1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function uitoggletool3_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run('Amino_Acid_Chart.m');
