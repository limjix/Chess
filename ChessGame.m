function varargout = ChessGame(varargin)
% CHESSGAME MATLAB code for ChessGame.fig
%      CHESSGAME, by itself, creates a new CHESSGAME or raises the existing
%      singleton*.
%
%      H = CHESSGAME returns the handle to a new CHESSGAME or the handle to
%      the existing singleton*.
%
%      CHESSGAME('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CHESSGAME.M with the given input arguments.
%
%      CHESSGAME('Property','Value',...) creates a new CHESSGAME or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ChessGame_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ChessGame_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ChessGame

% Last Modified by GUIDE v2.5 26-Nov-2014 10:36:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ChessGame_OpeningFcn, ...
                   'gui_OutputFcn',  @ChessGame_OutputFcn, ...
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


% --- Executes just before ChessGame is made visible.
function ChessGame_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ChessGame (see VARARGIN)

% Choose default command line output for ChessGame
handles.output = hObject;

%-------------------- Creates the Background -----------------------------
% create an axes that spans the whole gui
ah = axes('unit', 'normalized', 'position', [0 0 1 1]);
% import the background image and show it on the axes
bg = imread('WoodText.jpg'); imagesc(bg);
% prevent plotting over the background and turn the axis off
set(ah,'handlevisibility','off','visible','off')
% making sure the background is behind all the other uicontrols
uistack(ah, 'bottom');
%-------------------------------------------------------------------------

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ChessGame wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ChessGame_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in startbutton.
function startbutton_Callback(hObject, eventdata, handles)
% hObject    handle to startbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% create main figure window

mdp_chessboard(handles)



function gameconsole_Callback(hObject, eventdata, handles)
% hObject    handle to gameconsole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gameconsole as text
%        str2double(get(hObject,'String')) returns contents of gameconsole as a double


% --- Executes during object creation, after setting all properties.
function gameconsole_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gameconsole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Queen.
function Queen_Callback(hObject, eventdata, handles)
% hObject    handle to Queen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Bishop.
function Bishop_Callback(hObject, eventdata, handles)
% hObject    handle to Bishop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Knight.
function Knight_Callback(hObject, eventdata, handles)
% hObject    handle to Knight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Rook.
function Rook_Callback(hObject, eventdata, handles)
% hObject    handle to Rook (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in hintbutton.
function hintbutton_Callback(hObject, eventdata, handles)
% hObject    handle to hintbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.gameconsole,'String','test')



function UPS_Callback(hObject, eventdata, handles)
% hObject    handle to UPS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of UPS as text
%        str2double(get(hObject,'String')) returns contents of UPS as a double


% --- Executes during object creation, after setting all properties.
function UPS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to UPS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function APS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to UPS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function APS_Callback(hObject, eventdata, handles)
% hObject    handle to tex1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tex1 as text
%        str2double(get(hObject,'String')) returns contents of tex1 as a double


% --- Executes during object creation, after setting all properties.
function tex1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tex1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function depth_Callback(hObject, eventdata, handles)
% hObject    handle to depth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of depth as text
%        str2double(get(hObject,'String')) returns contents of depth as a double


% --- Executes during object creation, after setting all properties.
function depth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to depth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Nodescore_Callback(hObject, eventdata, handles)
% hObject    handle to Nodescore (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Nodescore as text
%        str2double(get(hObject,'String')) returns contents of Nodescore as a double


% --- Executes during object creation, after setting all properties.
function Nodescore_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Nodescore (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Freemove.
function Freemove_Callback(hObject, eventdata, handles)
% hObject    handle to Freemove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function AIMsgs_Callback(hObject, eventdata, handles)
% hObject    handle to AIMsgs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AIMsgs as text
%        str2double(get(hObject,'String')) returns contents of AIMsgs as a double


% --- Executes during object creation, after setting all properties.
function AIMsgs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AIMsgs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
