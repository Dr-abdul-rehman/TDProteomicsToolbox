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
function varargout = WholeProteinMWEstimator(varargin)
% FIGURE_WHOLEPROTEINMWESTIMATOR M-file for figure_WholeProteinMWEstimator.fig
%      FIGURE_WHOLEPROTEINMWESTIMATOR, by itself, creates a new FIGURE_WHOLEPROTEINMWESTIMATOR or raises the existing
%      singleton*.
%
%      H = FIGURE_WHOLEPROTEINMWESTIMATOR returns the handle to a new FIGURE_WHOLEPROTEINMWESTIMATOR or the handle to
%      the existing singleton*.
%
%      FIGURE_WHOLEPROTEINMWESTIMATOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIGURE_WHOLEPROTEINMWESTIMATOR.M with the given input arguments.
%
%      FIGURE_WHOLEPROTEINMWESTIMATOR('Property','Value',...) creates a new FIGURE_WHOLEPROTEINMWESTIMATOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before WholeProteinMWEstimator_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to WholeProteinMWEstimator_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help figure_WholeProteinMWEstimator

% Last Modified by GUIDE v2.5 28-May-2015 12:31:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @WholeProteinMWEstimator_OpeningFcn, ...
    'gui_OutputFcn',  @WholeProteinMWEstimator_OutputFcn, ...
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


function WholeProteinMWEstimator_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LUMSProT (see VARARGIN)
    % Choose default command line output for LUMSProT   
    % Sets x and y coordinates labels
    % try
    xLabel = 'Molecular Weights (Da)';
    xlabel(xLabel,'FontName','MS Sans Serif');
    xlabel(xLabel,'FontUnits','pixels');
    xlabel(xLabel,'FontWeight','normal');
    xlabel(xLabel,'FontSize',10);
    
    yLabel = 'Frequency';
    ylabel(yLabel,'FontName','MS Sans Serif');
    ylabel(yLabel,'FontUnits','pixels');
    ylabel(yLabel,'FontWeight','normal');
    ylabel(yLabel,'FontSize',10);
    
    % Check on all the checkboxes by default
    set(handles.checkbox_FragmentSums,'Value',1)
    setappdata(handles.figure_WholeProteinMWEstimator,'SumsofFragmentMasses',get(handles.checkbox_FragmentSums,'Value'))
    set(handles.checkbox_FragmentFrequencies,'Value',1)
    setappdata(handles.figure_WholeProteinMWEstimator,'FragmentFrequency',get(handles.checkbox_FragmentFrequencies,'Value'));
    set(handles.checkbox_IntensityFrequencies,'Value',1)
    setappdata(handles.figure_WholeProteinMWEstimator,'IntensityFrequencies',get(handles.checkbox_IntensityFrequencies,'Value'));
    set(handles.checkbox_Peak_wiseIntensity,'Value',1)
    setappdata(handles.figure_WholeProteinMWEstimator,'Peak_wiseIntensity',get(handles.checkbox_Peak_wiseIntensity,'Value'));
    
    handles.output = hObject;
    % Clear_at_start(handles); % to reset all fields when gui loads
    % Update handles structure
    % Calls slider_Tolerance_Callback to generate event when the window open for the first time
    induce_slider_Tolerance_Callback (hObject, eventdata, handles);
    %     catch exception
    %         errordlg(getReport(exception,'basic','hyperlinks','off'));
    %     end
    
    guidata(hObject, handles);
    
    % UIWAIT makes LUMSProT wait for user response (see UIRESUME)
    uiwait(handles.figure_WholeProteinMWEstimator);
    
% --- Outputs from this function are returned to the command line.
function varargout = WholeProteinMWEstimator_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargout{1} = output;  
 % Get default command line output from handles structure

% --- Executes during object creation, after setting all properties.
function edit_WholeProtPPMTolerance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_WholeProtPPMTolerance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


function edit_TunedMass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_TunedMass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_TunedMass as text
%        str2double(get(hObject,'String')) returns contents of edit_TunedMass as a double


% --- Executes during object creation, after setting all properties.
function edit_TunedMass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_TunedMass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    
    set(hObject,'String','0.0') % Default value of Protien Tuned Mass 

% --- Executes during object creation, after setting all properties.
function edit_ExperimentalMass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ExperimentalMass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

% --- Executes on button press in checkbox_FragmentSums.
function checkbox_FragmentSums_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_FragmentSums (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hint: get(hObject,'Value') returns toggle state of checkbox_FragmentSums
    setappdata(handles.figure_WholeProteinMWEstimator,'SumsofFragmentMasses',get(hObject,'Value'));

% --- Executes on button press in checkbox_FragmentFrequencies.
function checkbox_FragmentFrequencies_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_FragmentFrequencies (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hint: get(hObject,'Value') returns toggle state of checkbox_FragmentFrequencies
    setappdata(handles.figure_WholeProteinMWEstimator,'FragmentFrequency',get(hObject,'Value'));

% --- Executes on button press in checkbox_IntensityFrequencies.
function checkbox_IntensityFrequencies_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_IntensityFrequencies (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hint: get(hObject,'Value') returns toggle state of checkbox_IntensityFrequencies
    setappdata(handles.figure_WholeProteinMWEstimator,'IntensityFrequencies',get(hObject,'Value'));

% --- Executes on button press in checkbox_Peak_wiseIntensity.
function checkbox_Peak_wiseIntensity_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_Peak_wiseIntensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hint: get(hObject,'Value') returns toggle state of checkbox_Peak_wiseIntensity
    setappdata(handles.figure_WholeProteinMWEstimator,'Peak_wiseIntensity',get(hObject,'Value'));

% --- Executes during object creation, after setting all properties.
function checkbox_Peak_wiseIntensity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to checkbox_Peak_wiseIntensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    set(hObject, 'Value', 1);

% --- Executes during object creation, after setting all properties.
function checkbox_IntensityFrequencies_CreateFcn(hObject, eventdata, handles)
% hObject    handle to checkbox_IntensityFrequencies (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    set(hObject, 'Value', 1);


% --- Executes during object creation, after setting all properties.
function checkbox_FragmentFrequencies_CreateFcn(hObject, eventdata, handles)
% hObject    handle to checkbox_FragmentFrequencies (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    set(hObject, 'Value', 1);


% --- Executes during object creation, after setting all properties.
function checkbox_FragmentSums_CreateFcn(hObject, eventdata, handles)
% hObject    handle to checkbox_FragmentSums (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    set(hObject, 'Value', 1);

% --- Executes on button press in pushbutton_Next.
function pushbutton_Next_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    Tuned_Mass=get(handles.edit_TunedMass,'String');
    setappdata(0,'Tuned_Mass',Tuned_Mass);
    uiresume();
    close(gcf);
    setappdata(0,'WindowClosed',false);

%     
% --- Executes on slider movement.
function slider_Tolerance_Callback(hObject, eventdata, handles)
% hObject    handle to slider_Tolerance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
induce_slider_Tolerance_Callback (hObject, eventdata, handles);

function induce_slider_Tolerance_Callback (hObject, eventdata, handles)
   % try
        %Fetch value from the slider (current control)
        Slider_Value = get (handles.slider_Tolerance, 'Val');
      

        %Update the edit_WholeProtPPMTolerance text box with the new value of Tolerance
        set (handles.edit_WholeProtPPMTolerance, 'String', Slider_Value);
        Experimental_Protein_Mass = getappdata(0,'Experimental_Protein_Mass');
        %[Fragments_SumofMolWt,Fragments_MaxIntensity,Fragments_Selected_SumofIntensity,x,y,Tuned_MolWt] = FilterProteinMWs(Slider_Value);
        [Tuned_MolWt,Fragments_SumofMolWt,Fragments_MaxIntensity ,Fragments_SumofIntensity, Histc_Unique_Fragments_MolWt,Unique_Fragments_Occurrences] =  FilterProteinMWs(Slider_Value,Experimental_Protein_Mass);
        %set (handles.edit_ExperimentalMass,'String', ProtMW);

        
        set(handles.edit_ExperimentalMass,'String',Experimental_Protein_Mass);
        set (handles.edit_TunedMass,'String', Tuned_MolWt);

        %Update the plot with the new conjugated whole protein MW
        SumsofFragmentMasses = getappdata(handles.figure_WholeProteinMWEstimator,'SumsofFragmentMasses');
        FragmentFrequency = getappdata(handles.figure_WholeProteinMWEstimator,'FragmentFrequency');
        IntensityFrequencies = getappdata(handles.figure_WholeProteinMWEstimator,'IntensityFrequencies');
        Peak_wiseIntensity = getappdata(handles.figure_WholeProteinMWEstimator,'Peak_wiseIntensity');

        hold on
        cla
        %global variables SumsofFragmentMasses,FragmentFrequency,IntensityFrequencies,Peak_wiseIntensity when contain the value 1 the
        %respective intensity or frequency is plotted

        if SumsofFragmentMasses ==1
            line([Fragments_SumofMolWt Fragments_SumofMolWt],[1 0]);
        end
        if FragmentFrequency == 1
            plot(Histc_Unique_Fragments_MolWt,Unique_Fragments_Occurrences, 'k','LineWidth',2);
        end
        if (IntensityFrequencies == 1)
            plot(Fragments_MaxIntensity(:,1),Fragments_SumofIntensity, 'r','LineWidth',2);
        end
        if Peak_wiseIntensity == 1
            plot(Fragments_MaxIntensity(:,1),Fragments_MaxIntensity(:,2), '*');
        end
 
%     catch exception
%         errordlg('error in induce_slider_Tolerance_Callback');
%     end


    guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function slider_Tolerance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_Tolerance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end
    
    set(hObject,'Min',0,'Max',2000,'Value',150.5);

% --- Executes during object creation, after setting all properties.
function figure_WholeProteinMWEstimator_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure_WholeProteinMWEstimator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over edit_TunedMass.
function edit_TunedMass_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to edit_TunedMass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function edit_WholeProtPPMTolerance_Callback(hObject, eventdata, handles)
% hObject    handle to edit_WholeProtPPMTolerance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_WholeProtPPMTolerance as text
%        str2double(get(hObject,'String')) returns contents of edit_WholeProtPPMTolerance as a double

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over edit_WholeProtPPMTolerance.
function edit_WholeProtPPMTolerance_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to edit_WholeProtPPMTolerance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function text_TolerancePPM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_TolerancePPM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function text_ExperimentalMass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_ExperimentalMass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


function edit_ExperimentalMass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ExperimentalMass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ExperimentalMass as text
%        str2double(get(hObject,'String')) returns contents of edit_ExperimentalMass as a double

% --- For setting LUMSProT version read from the file 'LUMSProT_Version.txt'
function text_ToolboxVersion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_ToolboxVersion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    version = fopen('LUMSProT_Version.txt');
    set(hObject,'String',fgetl(version));

% --- Executes when user attempts to close figure_WholeProteinMWEstimator.
function figure_WholeProteinMWEstimator_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure_WholeProteinMWEstimator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
    delete(hObject);


% --- Executes during object deletion, before destroying properties.
function figure_WholeProteinMWEstimator_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure_WholeProteinMWEstimator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    setappdata(0,'WindowClosed',true);
