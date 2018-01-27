function varargout = Bone(varargin)
% BONE MATLAB code for Bone.fig
%      BONE, by itself, creates a new BONE or raises the existing
%      singleton*.
%
%      H = BONE returns the handle to a new BONE or the handle to
%      the existing singleton*.
%
%      BONE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BONE.M with the given input arguments.
%
%      BONE('Property','Value',...) creates a new BONE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Bone_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Bone_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Bone

% Last Modified by GUIDE v2.5 18-Jan-2018 11:29:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Bone_OpeningFcn, ...
                   'gui_OutputFcn',  @Bone_OutputFcn, ...
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


% --- Executes just before Bone is made visible.
function Bone_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Bone (see VARARGIN)

% Choose default command line output for Bone
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Bone wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Bone_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when uipanel2 is resized.
function uipanel2_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to uipanel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

cla(handles.axes1);
cla(handles.axes2);
cla(handles.axes3);
cla(handles.axes4);
cla(handles.axes5);
cla(handles.axes6);
cla(handles.axes7);

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[a,b]=uigetfile({'*.jpg;*.jpeg''JPEG File';'*.png''PNG File'},'Select image','D:\GUI\img\');

im_full = imread([b,a]);

axes(handles.axes1);
Iori = imcrop(im_full);
im_ori = Iori;

% %Input age 
% 
% prompt = {'Input age  :'};
% dlg_title = 'Input value';
% num_lines = 1;
% age = inputdlg(prompt,dlg_title,num_lines);
% 
% %-------------------�ʴ������ŷ��˹�Ҩ�-----------
% set(handles.edit8,'string',age);


% Histrogram Equalization
Iori = histeq(Iori); 

stdBlur = 4;

if checkWhite(im_ori) > 48000
    stdBlur = 3;
end

q = 'Yes';
while strcmp(q,'Yes')

prompt = {'Enter Blur level :','Enter filter Iteration:','Enter light value :'};
dlg_title = 'Input value';
num_lines = 1;
defaultans = {int2str(stdBlur),'1',int2str(checkWhite(im_ori))};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);

blurLV = str2double(cell2mat(answer(1,1)));
Iter = str2double(cell2mat(answer(2,1)));

I = Iori;

% Iori = wiener2(Iori);

axes(handles.axes2); imshow(I);


Icrop = I;
% figure,imshow(Icrop);

%------------------filter blur------------------------------%
% Gaussian filter with standard deviation of 3

Iblur = imgaussfilt(Icrop,blurLV);

%-----------------------------------------------------------%

% Canny Edge
Iedge = edge(Iblur,'canny');
axes(handles.axes3);imshow(Iedge);



% dilation image
se90 = strel('line', 3,90);
se0 = strel('line', 3, 0);
BWsdil = imdilate(Iedge, [se90 se0]);
% figure, imshow(BWsdil), title('dilated gradient mask');

% Fill image regions and holes
BWdfill = imfill(BWsdil, 'holes');
% figure, imshow(BWdfill);
% title('binary image with filled holes');

% Clearing the Border 4 connectivity
BWnobord = imclearborder(BWdfill, 4);
% figure, imshow(BWnobord), title('cleared border image');

%Erosion
seD = strel('diamond',1);
BWfinal = imerode(BWnobord,seD);
BWfinal = imerode(BWfinal,seD);
% figure, imshow(BWfinal), title('segmented image');

% gaussian low pass
h = fspecial('gaussian', 16,16); 
I2 = imfilter(BWfinal, h); 

for i = 1 : Iter
    I2 = imfilter(I2,h);
end

axes(handles.axes4);imshow(I2);
title('Binary Image After Filtering'); 

%--- count object in binary image --------------%
% Connected component label
[labeledImage,numberOfObject] = bwlabel(I2);
%-----------------------------------------------%
[ml,nl] = size(labeledImage);

imgSub = zeros(ml,nl,numberOfObject);

% create sub bone image
for i=1:ml
    imgSub(:,:,i) = (labeledImage==i);
end

%end

%find center
point = zeros(numberOfObject,2);
for i=1:numberOfObject
   
   [px,py] = CenterPoint(imgSub(:,:,i));
   point(i,1) = int16(px);
   point(i,2) = int16(py);
end

% Find Perimeter
BWoutline = bwperim(I2);
Segout = im_ori;
Segout(BWoutline) = 255;

im_draw = cat(3,Segout,Segout,Segout);
Ired =  markRed(im_draw);

ImCenter = markRedCenter(Ired,point,numberOfObject);
axes(handles.axes5);imshow(ImCenter);
figure,imshow(ImCenter);


axes(handles.axes6);imshow(Ired), title({strcat('outlined original image    ',a)}),xlabel(strcat('   Number of bone = ',int2str(numberOfObject)));
q = questdlg('Do you want setting blur level and filter value again');
end



% runQ = questdlg('Do you want to runing again');

whitePix = 0;
binaryArea = 0;
circum = 0;
[m,n] = size(I2);


R_chanel = Ired(:,:,1);

for i=1:m
    
    for j=1:n
        if I2(i,j) == 1
            binaryArea = int32(binaryArea)+1;
        end
        
        if R_chanel(i,j)==255
           circum = circum+1; 
        end
        
    end
    
end


prompt = {'Area of bone :','Circumference','Number of bone :'};
dlg_title = 'Do you save to Data Train ';
num_lines = 1;
defaultans = {int2str(binaryArea),int2str(circum),int2str(numberOfObject)};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);

%-----------�ʴ�������㹪�ͧ---------------
set(handles.edit5,'string',binaryArea);
set(handles.edit6,'string',circum);
set(handles.edit7,'string',numberOfObject);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

prompt = {'Input age  :'};
dlg_title = 'Input value';
num_lines = 1;
age = inputdlg(prompt,dlg_title,num_lines);

%---------�ʴ������ŷ���ͧ˹�Ҩ�------------
set(handles.edit8,'string',age);

%-----------�֧�����ŷ���ͧ˹�Ҩ�-----------
binaryArea=get(handles.edit5,'String');
circum=get(handles.edit6,'String');
numberOfObject=get(handles.edit7,'String');

fprintf('\nbinaryArea =  %s \n',binaryArea);
fprintf('circum =  %s \n',circum);
fprintf('numberOfObject =  %s \n',numberOfObject);

%KNN
% %read data
dataTest = [str2num(binaryArea)  str2num(circum)  str2num(numberOfObject) 0 0];
dataSet = xlsread('DataTrain.xlsx');
dataTrain = dataSet(:,2:end);       
 class = Distance(dataTest,dataTrain);      

 age_value = str2double(cell2mat(age(1,1)));
 if class == age_value 
     result = '����';
 else
     result = '�Դ����';    
 end


%----------------------------------
set(handles.edit9,'string',class);
set(handles.edit10,'string',result);




function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double



% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(handles.figure1);
% t3:show;
BoneSystem
