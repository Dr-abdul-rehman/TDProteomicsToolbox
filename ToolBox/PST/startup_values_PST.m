function startup_values_PST(hObject, eventdata, handles)

% ``````````````Pst_gui````````````````````````````%
% User_hop_tolerance
% Tolerance for each hop
jUHTol = findjobj(handles.edit_UserHopTolerance);
set(jUHTol, 'FocusGainedCallback', @(h,e)emptyField(handles.edit_UserHopTolerance,'0.1'));
set(jUHTol, 'FocusLostCallback', @(h,e)fillField(handles.edit_UserHopTolerance,'0.1'));

% User_tag_tolerance
% Tolerance for whole EST
jTTol = findjobj(handles.edit_UserTagTolerance);
set(jTTol, 'FocusGainedCallback', @(h,e)emptyField(handles.edit_UserTagTolerance,'0.45'));
set(jTTol, 'FocusLostCallback', @(h,e)fillField(handles.edit_UserTagTolerance,'0.45'));

%----------------***-------------------------------------------

function emptyField(Obj,Str)
if(strcmp(get(Obj,'String'),Str) && isequal(get(Obj,'ForegroundColor'),[0.6 0.6 0.6]))
    set(Obj,'String','');
end

function fillField(Obj,Str)
try
    
    if(isempty(get(Obj,'String')) && isequal(get(Obj,'ForegroundColor'),[0.6 0.6 0.6]))
        set(Obj,'String',Str);
    end
catch
    return
end



%-----------########---------------------------