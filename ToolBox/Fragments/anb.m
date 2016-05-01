function varargout = anb(varargin)
% ANB M-file for anb.fig
%      ANB, by itself, creates a new ANB or raises the existing
%      singleton*.
%
%      H = ANB returns the handle to a new ANB or the handle to
%      the existing singleton*.
%
%      ANB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANB.M with the given input arguments.
%
%      ANB('Property','Value',...) creates a new ANB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before anb_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to anb_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help anb

% Last Modified by GUIDE v2.5 10-Jul-2015 12:23:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @anb_OpeningFcn, ...
                   'gui_OutputFcn',  @anb_OutputFcn, ...
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


% --- Executes just before anb is made visible.
function anb_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to anb (see VARARGIN)
setappdata(0,'ao',0);
setappdata(0,'bo',0);
setappdata(0,'yo',0);
setappdata(0,'zoo',0);
setappdata(0,'zo',0);
setappdata(0,'astar',0);
setappdata(0,'bstar',0);
setappdata(0,'ystar',0);


similar_fragments = {'CID','IMD','BIRD','SID','HCD'};
similar_fragments2 = {'ECD','ETD'};
similar_fragments3 = {'EDD','NETD'};
if any(strcmpi(getappdata(0,'Fragmentation'),similar_fragments))
    set(handles.zoo,'Enable','off');
    set(handles.zo,'Enable','off');
    set(handles.astar,'Enable','off');
    set(handles.ao,'Enable','off');
elseif any(strcmpi(getappdata(0,'Fragmentation'),similar_fragments2))
    set(handles.ao,'Enable','off');
    set(handles.bo,'Enable','off');
    set(handles.astar,'Enable','off');
    set(handles.bstar,'Enable','off');
    set(handles.yo,'Enable','off');
    set(handles.ystar,'Enable','off');
elseif any(strcmpi(getappdata(0,'Fragmentation'),similar_fragments3))
    set(handles.zoo,'Enable','off');
    set(handles.zo,'Enable','off');
    set(handles.bo,'Enable','off');
    set(handles.bstar,'Enable','off');
    set(handles.yo,'Enable','off');
    set(handles.ystar,'Enable','off');
end



% Choose default command line output for anb
uiwait(gcf);

% Update handles structure
% guidata(hObject, handles);

% UIWAIT makes anb wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = anb_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
output={};
output{1,1} = getappdata(0,'ao');
output{2,1} = getappdata(0,'bo');
output{3,1} = getappdata(0,'yo');
output{4,1} = getappdata(0,'zo');
output{5,1} = getappdata(0,'zoo');
output{6,1} = getappdata(0,'astar');
output{7,1} = getappdata(0,'bstar');
output{8,1} = getappdata(0,'ystar');
varargout{1,1} = output;



% --- Executes on button press in ao.
function ao_Callback(hObject, eventdata, handles)
% hObject    handle to ao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'ao',get(hObject,'Value'));% returns toggle state of ao

set(handles.astar,'Value',0);
set(handles.bo,'Value',0);
set(handles.bstar,'Value',0);
set(handles.ystar,'Value',0);
set(handles.yo,'Value',0);
set(handles.zo,'Value',0);
set(handles.zoo,'Value',0);

setappdata(0,'bo',0);
setappdata(0,'yo',0);
setappdata(0,'zoo',0);
setappdata(0,'zo',0);
setappdata(0,'astar',0);
setappdata(0,'bstar',0);
setappdata(0,'ystar',0);

% --- Executes on button press in bo.
function bo_Callback(hObject, eventdata, handles)
% hObject    handle to bo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

setappdata(0,'bo',get(hObject,'Value'));

set(handles.ao,'Value',0);
set(handles.astar,'Value',0);
set(handles.bstar,'Value',0);
set(handles.ystar,'Value',0);
set(handles.yo,'Value',0);
set(handles.zo,'Value',0);
set(handles.zoo,'Value',0);

setappdata(0,'ao',0);
setappdata(0,'yo',0);
setappdata(0,'zoo',0);
setappdata(0,'zo',0);
setappdata(0,'astar',0);
setappdata(0,'bstar',0);
setappdata(0,'ystar',0);


% --- Executes on button press in astar.
function astar_Callback(hObject, eventdata, handles)
% hObject    handle to astar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'astar',get(hObject,'Value'));% returns toggle state of astar

set(handles.ao,'Value',0);
set(handles.bo,'Value',0);
set(handles.bstar,'Value',0);
set(handles.ystar,'Value',0);
set(handles.yo,'Value',0);
set(handles.zo,'Value',0);
set(handles.zoo,'Value',0);

setappdata(0,'ao',0);
setappdata(0,'bo',0);
setappdata(0,'yo',0);
setappdata(0,'zoo',0);
setappdata(0,'zo',0);
setappdata(0,'bstar',0);
setappdata(0,'ystar',0);


% --- Executes on button press in bstar.
function bstar_Callback(hObject, eventdata, handles)
% hObject    handle to bstar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

setappdata(0,'bstar',get(hObject,'Value'));

set(handles.ao,'Value',0);
set(handles.astar,'Value',0);
set(handles.bo,'Value',0);
set(handles.ystar,'Value',0);
set(handles.yo,'Value',0);
set(handles.zo,'Value',0);
set(handles.zoo,'Value',0);

setappdata(0,'ao',0);
setappdata(0,'bo',0);
setappdata(0,'yo',0);
setappdata(0,'zoo',0);
setappdata(0,'zo',0);
setappdata(0,'astar',0);
setappdata(0,'ystar',0);

% --- Executes on button press in ystar.
function ystar_Callback(hObject, eventdata, handles)
% hObject    handle to ystar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'ystar',get(hObject,'Value'));

set(handles.ao,'Value',0);
set(handles.astar,'Value',0);
set(handles.bo,'Value',0);
set(handles.yo,'Value',0);
set(handles.bstar,'Value',0);
set(handles.zo,'Value',0);
set(handles.zoo,'Value',0);

setappdata(0,'ao',0);
setappdata(0,'bo',0);
setappdata(0,'yo',0);
setappdata(0,'zoo',0);
setappdata(0,'zo',0);
setappdata(0,'astar',0);
setappdata(0,'bstar',0);


% --- Executes on button press in yo.
function yo_Callback(hObject, eventdata, handles)
% hObject    handle to yo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'yo',get(hObject,'Value'));

set(handles.ao,'Value',0);
set(handles.bo,'Value',0);
set(handles.ystar,'Value',0);
set(handles.astar,'Value',0);
set(handles.bstar,'Value',0);
set(handles.zo,'Value',0);
set(handles.zoo,'Value',0);

setappdata(0,'ao',0);
setappdata(0,'bo',0);
setappdata(0,'zoo',0);
setappdata(0,'zo',0);
setappdata(0,'astar',0);
setappdata(0,'bstar',0);
setappdata(0,'ystar',0);

% --- Executes on button press in zo.
function zo_Callback(hObject, eventdata, handles)
% hObject    handle to zo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'zo',get(hObject,'Value'));% returns toggle state of astar

set(handles.ao,'Value',0);
set(handles.astar,'Value',0);
set(handles.bo,'Value',0);
set(handles.bstar,'Value',0);
set(handles.ystar,'Value',0);
set(handles.yo,'Value',0);
set(handles.zoo,'Value',0);

setappdata(0,'ao',0);
setappdata(0,'bo',0);
setappdata(0,'yo',0);
setappdata(0,'zoo',0);
setappdata(0,'astar',0);
setappdata(0,'bstar',0);
setappdata(0,'ystar',0);
% Hint: get(hObject,'Value') returns toggle state of zo


% --- Executes on button press in zoo.
function zoo_Callback(hObject, eventdata, handles)
% hObject    handle to zoo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'zoo',get(hObject,'Value'));% returns toggle state of astar

set(handles.ao,'Value',0);
set(handles.astar,'Value',0);
set(handles.bo,'Value',0);
set(handles.bstar,'Value',0);
set(handles.ystar,'Value',0);
set(handles.yo,'Value',0);
set(handles.zo,'Value',0);

setappdata(0,'ao',0);
setappdata(0,'bo',0);
setappdata(0,'yo',0);
setappdata(0,'zo',0);
setappdata(0,'astar',0);
setappdata(0,'bstar',0);
setappdata(0,'ystar',0);
% Hint: get(hObject,'Value') returns toggle state of zoo

% --- Executes on button press in Okay.
function Okay_Callback(hObject, eventdata, handles)
% hObject    handle to Okay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 uiresume(gcbf);
 close(gcf);


% --- Executes on key press with focus on Okay and none of its controls.
function Okay_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to Okay (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on button press in checkbox13.
function checkbox13_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox13


% --- Executes on button press in checkbox14.
function checkbox14_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox14
