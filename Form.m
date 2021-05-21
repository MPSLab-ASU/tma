%https://tinevez.github.io/matlab-tree/index.html
% global signalAddress;

function varargout = Form(varargin)
% FORM MATLAB code for Form.fig
%      FORM, by itself, creates a new FORM or raises the existing
%      singleton*.
%
%      H = FORM returns the handle to a new FORM or the handle to
%      the existing singleton*.
%
%      FORM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FORM.M with the given input arguments.
%
%      FORM('Property','Value',...) creates a new FORM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Form_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Form_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Form

% Last Modified by GUIDE v2.5 08-Feb-2018 00:09:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Form_OpeningFcn, ...
                   'gui_OutputFcn',  @Form_OutputFcn, ...
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


% --- Executes just before Form is made visible.
function Form_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Form (see VARARGIN)

% Choose default command line output for Form
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Form wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Form_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function signalFileAddress_Callback(hObject, eventdata, handles)
% hObject    handle to signalFileAddress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of signalFileAddress as text
%        str2double(get(hObject,'String')) returns contents of signalFileAddress as a double


% --- Executes during object creation, after setting all properties.
function signalFileAddress_CreateFcn(hObject, eventdata, handles)
% hObject    handle to signalFileAddress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.




if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in runButton.
function runButton_Callback(hObject, eventdata, handles)
% hObject    handle to runButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
systemSamplingTime = 0.02;
signalAddress = get(handles.signalFileAddress,'String');

timingContstraintContent = get(handles.timingConstraint,'String');

signalList = get(handles.signalListAddress,'String');

testing(signalAddress,signalList,timingContstraintContent,systemSamplingTime);



function timingConstraint_Callback(hObject, eventdata, handles)
% hObject    handle to timingConstraint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of timingConstraint as text
%        str2double(get(hObject,'String')) returns contents of timingConstraint as a double


% --- Executes during object creation, after setting all properties.
function timingConstraint_CreateFcn(hObject, eventdata, handles)
% hObject    handle to timingConstraint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function signalListAddress_Callback(hObject, eventdata, handles)
% hObject    handle to signalListAddress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of signalListAddress as text
%        str2double(get(hObject,'String')) returns contents of signalListAddress as a double


% --- Executes during object creation, after setting all properties.
function signalListAddress_CreateFcn(hObject, eventdata, handles)
% hObject    handle to signalListAddress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
