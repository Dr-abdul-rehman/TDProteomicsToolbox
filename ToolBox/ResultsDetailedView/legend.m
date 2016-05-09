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
function varargout = legend(varargin)
% LEGEND MATLAB code for legend.fig
%      LEGEND, by itself, creates a new LEGEND or raises the existing
%      singleton*.
%
%      H = LEGEND returns the handle to a new LEGEND or the handle to
%      the existing singleton*.
%
%      LEGEND('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LEGEND.M with the given input arguments.
%
%      LEGEND('Property','Value',...) creates a new LEGEND or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before legend_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to legend_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help legend

% Last Modified by GUIDE v2.5 09-Mar-2015 17:42:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @legend_OpeningFcn, ...
                   'gui_OutputFcn',  @legend_OutputFcn, ...
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


% --- Executes just before legend is made visible.
function legend_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to legend (see VARARGIN)
set(hObject,'Name','LUMSProT-Legends');
% Choose default command line output for legend
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes legend wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = legend_OutputFcn(hObject, eventdata, handles) 
 symbols=[{'\varpi'},{texlabel('omega')},{texlabel('psi')},{texlabel('alpha')},{'\Theta'},{'\otimes'},{'\oplus'},{'\oslash'},{'\nabla'},{texlabel('Delta')},{'\clubsuit'},{'\heartsuit'},{'\spadesuit'},{'\diamondsuit'}];
 Modifications=[{'Phosphorylation_Y'},{'Phosphorylation_T'},{'Phosphorylation_S'},{'Amidation_F'},{'Acetylation_A'},{'Acetylation_K'},{'Acetylation_S'},{'Acetylation_R'},{'Methylation_R'},{'Methylation_K'},{'N-linked-glycosylation_N'},{'O-linked-glycosylation_S'},{'O-linked-glycosylation_T'},{'Hydroxylation_P'}];
legend =text(0.5,0.09,'Legends:');
%set(legend,'FontWeight','bold');
set(legend,'FontSize',16);
set(legend,'color',[.4 .5 .3]);
x_axis3=0.5;
 y_axis3=-2.8;
 for num_modifications=1:14
     format_modifications=text(.5+x_axis3,y_axis3+1,Modifications(num_modifications));
     set(format_modifications,'FontSize',9.5);
     format_symbols=text(0+x_axis3,y_axis3+1.2,symbols(num_modifications));
     set(format_symbols,'FontSize',12);
     set(format_symbols,'color','r');
     x_axis3=x_axis3+5.5;
     if num_modifications==4 ||num_modifications==8||num_modifications==12      
         y_axis3=y_axis3-1.5;
         x_axis3=0.5;
     end
 end
blu=text(17.2,-5.8,'\bullet');
set(blu,'color','b');
set(blu,'FontSize',18);
text(17.6,-6,'Match');
blu=text(11.5,-5.8,'\bullet');
set(blu,'FontSize',18);
text(12,-6,'Miss-match');
% null=text(.5,-7.5,'\phi');
% set(null,'FontSize',14);
% set(null,'color',[0,.5,0]);
% text(1,-7.5,'NULL');
varargout{1} = handles.output;
