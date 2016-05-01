function varargout = Result(varargin)
% UNTITLED1 MATLAB code for untitled1.fig
%      UNTITLED1, by itself, creates a new UNTITLED1 or raises the existing
%      singleton*.
%
%      H = UNTITLED1 returns the handle to a new UNTITLED1 or the handle to
%      the existing singleton*.
%
%      UNTITLED1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED1.M with the given input arguments.
%
%      UNTITLED1('Property','Value',...) creates a new UNTITLED1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled1

% Last Modified by GUIDE v2.5 21-Mar-2016 15:44:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled1_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled1_OutputFcn, ...
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


% --- Executes just before untitled1 is made visible.
function untitled1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled1 (see VARARGIN)

% Choose default command line output for untitled1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled1 wait for user response (see UIRESUME)
% uiwait(handles.Figure_Result);


% --- Outputs from this function are returned to the command line.
function varargout = untitled1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 Matches=getappdata(0,'Matches');
 
 row={};
 output=getappdata(0,'Proteins_Output');
 if(numel(Matches)<str2num(output))
     num_oputput=numel(Matches);
 else
     num_oputput=str2num(output);
end
 
for z = 1:num_oputput
    Name=Matches{z}.Name;
    ID=Matches{z}.Id;
    Score=Matches{z}.Final_Score;
    MolW=Matches{z}.MolW;
     row=cat(2,row,num2str(z));
     set(handles.uitable2,'RowName',row);
     if(z==1)     
     protein_data= {Name,ID,num2str(MolW),num2str(Score),'...view...'};
     set(handles.uitable2,'data',protein_data);
     else
     data=get(handles.uitable2,'Data');
     protein_data= {Name,ID,num2str(MolW),num2str(Score),'...view...'};
     newRowdata = cat(1,data,protein_data);
     set(handles.uitable2,'data',newRowdata);
     end
   
end
   data=get(handles.uitable2,'Data');
   data=sortrows(data,-4); 

    set(handles.uitable2,'data',data);
    entry=size(data);
    data=get(handles.uitable2,'Data');
    X=460;
    Y=240;
    c=size(data);
 
   
varargout{1} = handles.output;




% --- Executes when selected cell(s) is changed in uitable2.
function uitable2_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitable2 (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
   a=eventdata.Indices;
   if a(2)==5
       Matches=getappdata(0,'Matches');
        Rank=a(1)
        Matches{Rank}.rank=Rank;
        setappdata(0,'Matches',Matches);
        setappdata(0,'Rank',Rank);
        try
        addpath(strcat(pwd,'/ResultsDetailedView'))
%        close(Detail_view);
        Detail_view;
        catch exception
        errordlg(getReport(exception,'basic','hyperlinks','off'));
        end

   end

   

% --- Executes on button press in pushbutton_Finish.
function pushbutton_Finish_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Finish (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.Figure_Result)


% --- Executes on scroll wheel click while the figure is in focus.
function Figure_Result_WindowScrollWheelFcn(hObject, eventdata, handles)
% hObject    handle to Figure_Result (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	VerticalScrollCount: signed integer indicating direction and number of clicks
%	VerticalScrollAmount: number of lines scrolled for each click
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on uitable2 and none of its controls.
function uitable2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to uitable2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_back.
function pushbutton_back_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
close(handles.Figure_Result);
                 addpath(strcat(pwd,'\Score'));
                 Final_Scoring;
                setappdata(0,'w1',getappdata(0,'w1'));
                setappdata(0,'w2',getappdata(0,'w2'));
                setappdata(0,'w3',getappdata(0,'w3')); 
                final_score;
                    result=getappdata(0,'Matches');
                    setappdata(0,'Matches',result);
                    addpath(strcat(pwd,'\ResultsSummaryView'));
                 %  der=Tag_sizeone(Tags_Ladder);
                %   setappdata(0,'Tags_Ladder',Tag_ladder);
                 %  setappdata(0,'Proteins_Output',Proteins_Output);
                if(getappdata(0,'FScoringWindowClosed') == false)
                    Result;
                
                end  
