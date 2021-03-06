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


function varargout = LUMSProT_OtherModifications(varargin)
% LUMSPROT_OTHERMODIFICATIONS MATLAB code for LUMSProT_OtherModifications.fig
%      LUMSPROT_OTHERMODIFICATIONS, by itself, creates a new LUMSPROT_OTHERMODIFICATIONS or raises the existing
%      singleton*.
%
%      H = LUMSPROT_OTHERMODIFICATIONS returns the handle to a new LUMSPROT_OTHERMODIFICATIONS or the handle to
%      the existing singleton*.
%
%      LUMSPROT_OTHERMODIFICATIONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LUMSPROT_OTHERMODIFICATIONS.M with the given input arguments.
%
%      LUMSPROT_OTHERMODIFICATIONS('Property','Value',...) creates a new LUMSPROT_OTHERMODIFICATIONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LUMSProT_OtherModifications_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LUMSProT_OtherModifications_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LUMSProT_OtherModifications

% Last Modified by GUIDE v2.5 24-May-2016 21:22:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LUMSProT_OtherModifications_OpeningFcn, ...
                   'gui_OutputFcn',  @LUMSProT_OtherModifications_OutputFcn, ...
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


% --- Executes just before LUMSProT_OtherModifications is made visible.
function LUMSProT_OtherModifications_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LUMSProT_OtherModifications (see VARARGIN)

% Choose default command line output for LUMSProT_OtherModifications
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LUMSProT_OtherModifications wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LUMSProT_OtherModifications_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Setappdata for other modifications defined by specific experimental protoclos  
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
C_Object=get(handles.uibuttongroup_Cysteine,'SelectedObject');
M_Object=get(handles.uibuttongroup_Methionine,'SelectedObject');


if strcmp('radiobutton_UNC',get(C_Object,'Tag'))
    setappdata(0,'Othermodification_Cysteine','');
else
   setappdata(0,'Othermodification_Cysteine',get(C_Object,'Tag'));% to get user defined chemical modifications on cysteine residue 
end
if strcmp('radiobutton_UNM',get(M_Object,'Tag'))
    setappdata(0,'Othermodification_Methionine','');
else
     setappdata(0,'Othermodification_Methionine',get(M_Object,'Tag'));% to get user defined chemical modifications on methionine residue
end

close(LUMSProT_OtherModifications);
%rmpath(strcat(pwd,'\OtherModifications'));
