clc;
close all;
close all hidden;
close all force;
runQ = 'Yes';

while  strcmp(runQ,'Yes')
clc
close all;
close all hidden;
close all force;

[a,b]=uigetfile({'*.jpg;*.jpeg''JPEG File';'*.png''PNG File'},'Select image','D:\Work\ปี 3 เทอม 2\สัมมนา\Programming\Test MedianFilter\img\');

im_full = imread([b,a]);

Iori = imcrop(im_full);
im_ori = Iori;

%Input age 

prompt = {'Input age  :'};
dlg_title = 'Input value';
num_lines = 1;
age = inputdlg(prompt,dlg_title,num_lines);



Iori = histeq(Iori);

stdBlur = 4;

if checkWhite(im_ori) > 48000
    stdBlur = 3;
end

q = 'Yes';
while strcmp(q,'Yes')
clc
close all;
prompt = {'Enter Blur level :','Enter filter Iteration:','Enter light value :'};
dlg_title = 'Input value';
num_lines = 1;
defaultans = {int2str(stdBlur),'1',int2str(checkWhite(im_ori))};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);

blurLV = str2double(cell2mat(answer(1,1)));
Iter = str2double(cell2mat(answer(2,1)));

I = Iori;
Iori = wiener2(Iori);
figure,imshow(I);


Icrop = I;
figure,imshow(Icrop);
%------------------filter blur------------------------------%
Iblur = imgaussfilt(Icrop,blurLV);

%-----------------------------------------------------------%
figure,imshow(Iblur);
Iedge = edge(Iblur,'canny');
figure,imshow(Iedge);



se90 = strel('line', 3,90);
se0 = strel('line', 3, 0);
BWsdil = imdilate(Iedge, [se90 se0]);
figure, imshow(BWsdil), title('dilated gradient mask');

BWdfill = imfill(BWsdil, 'holes');
figure, imshow(BWdfill);
title('binary image with filled holes');

BWnobord = imclearborder(BWdfill, 4);
figure, imshow(BWnobord), title('cleared border image');

seD = strel('diamond',1);
BWfinal = imerode(BWnobord,seD);
BWfinal = imerode(BWfinal,seD);
figure, imshow(BWfinal), title('segmented image');


h = fspecial('gaussian', 16,16); 
I2 = imfilter(BWfinal, h); 

for i = 1 : Iter
    I2 = imfilter(I2,h);
end

figure,imshow(I2);
title('Binary Image After Filtering'); 
%--- count object in binary image --------------%
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
%end




BWoutline = bwperim(I2);
Segout = im_ori;
Segout(BWoutline) = 255;

im_draw = cat(3,Segout,Segout,Segout);
Ired =  markRed(im_draw);

%mark center point
ImCenter = markRedCenter(Ired,point,numberOfObject);
figure,imshow(ImCenter);

figure, imshow(Ired), title({strcat('outlined original image    ',a)}),xlabel(strcat('   Number of bone = ',int2str(numberOfObject)));
q = questdlg('Do you want setting blur level and filter value again');
end



runQ = questdlg('Do you want to runing again');
end
whitePix = 0;
binaryArea = 0;
circum = 0;
distance = 0;



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

%U distance
[mp,np] = size(point);
for i=1:mp-1
   distance = distance+sqrt(((point(i,1)-point(i+1,1))^2)+((point(i,2)-point(i+1,2))^2));
   if(i==(mp-1))
       distance = distance+sqrt(((point(1,1)-point(2,1))^2)+((point(1,2)-point(2,2))^2));
   end
end


prompt = {'Area of bone :','Circumference','Number of bone :','Distance :'};
dlg_title = 'Do you save to Data Train ';
num_lines = 1;
defaultans = {int2str(binaryArea),int2str(circum),int2str(numberOfObject),int2str(circum)};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);

%read data
dataTest = [int32(binaryArea(1))  int32(circum(1))  int32(numberOfObject(1)) int32(distance)  0];
dataSet = xlsread('DataTrain.xlsx');
dataTrain = dataSet(:,2:end);       
 class = Distance(dataTest,dataTrain);      

 age_value = str2double(cell2mat(age(1,1)));
 if class == age_value 
     result = 'ปกติ';
 else
     result = 'ผิดปกติ';    
 end

figure,
imshow(imresize(im_full,0.5)),
title(strcat('ชื่อภาพ  : ',a));

%show result

sz = [200 100]; % figure size
screensize = get(0,'ScreenSize');
xpos = ceil((screensize(3)/2)); % center the figure on the
ypos = ceil((screensize(4)/2)); % center the figure on the


h=msgbox({strcat('อายุ :' ,int2str(age_value),' ปี'),strcat('อายุกระดูก :' ,int2str(class),' ปี'),strcat('ผลการวินิจฉัย :' ,result)},'Result');
set(h, 'position', [xpos ypos 200 100]);
ah = get( h, 'CurrentAxes' );
ch = get( ah, 'Children' );
set( ch, 'FontSize', 14 );





