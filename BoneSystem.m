function varargout = BoneSystem(varargin)
% BONESYSTEM MATLAB code for BoneSystem.fig
%      BONESYSTEM, by itself, creates a new BONESYSTEM or raises the existing
%      singleton*.
%
%      H = BONESYSTEM returns the handle to a new BONESYSTEM or the handle to
%      the existing singleton*.
%
%      BONESYSTEM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BONESYSTEM.M with the given input arguments.
%
%      BONESYSTEM('Property','Value',...) creates a new BONESYSTEM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BoneSystem_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BoneSystem_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu1.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BoneSystem

% Last Modified by GUIDE v2.5 18-Jan-2018 11:54:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BoneSystem_OpeningFcn, ...
                   'gui_OutputFcn',  @BoneSystem_OutputFcn, ...
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


% --- Executes just before BoneSystem is made visible.
function BoneSystem_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BoneSystem (see VARARGIN)

% Choose default command line output for BoneSystem
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BoneSystem wait for user response (see UIRESUME)
% uiwait(handles.figure1);
[x,map]=imread('NSC2.png');
axes(handles.axes1)
imshow(x,map)


% --- Outputs from this function are returned to the command line.
function varargout = BoneSystem_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
pos_siza = get(handles.figure1,'Position');
user_response = questdlg('ต้องการปิดโปรแกรม ใช่ หรือ ไม่','Confirm Close');
switch user_response
%     case{'No'}
    case'Yes'
        delete(handles.figure1)
end
% delete(hObject);


% --------------------------------------------------------------------
function menu1_Callback(hObject, eventdata, handles)
% hObject    handle to menu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% delete(handles.figure1);
% i=imshow(t2);
% imshow(t2)


% --------------------------------------------------------------------
function menu2_Callback(hObject, eventdata, handles)
% hObject    handle to menu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(handles.figure1);
% t3:show;
Bone
