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

% Last Modified by GUIDE v2.5 27-Oct-2014 15:01:49

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

mdp_chessboard(handles.boardtop)
