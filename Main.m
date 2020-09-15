function varargout = Main(varargin)
% MAIN MATLAB code for Main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Main

% Last Modified by GUIDE v2.5 16-Jun-2016 17:06:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 4;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Main_OpeningFcn, ...
                   'gui_OutputFcn',  @Main_OutputFcn, ...
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


% --- Executes just before Main is made visible.
function Main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Main (see VARARGIN)

% Choose default command line output for Main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Main wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.checkbox1,'enable','off');
set(handles.checkbox2,'enable','off');


% --- Outputs from this function are returned to the command line.
function varargout = Main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global IMAGE

% -- Getting the Input image -- %
[file path] = uigetfile('*.*');
if file ~= 0
    IMAGE = imread([path file]);
    IMAGE = imresize(IMAGE,[500 500]);
    axes(handles.axes1);
    imshow(IMAGE);axis off;
    title('Input image','fontname','Times New Roman','fontsize',12);
else
    a = warndlg({'...TRY AGAIN...';'(Select Any Image)'});
    pause(1);
    close(a);

end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.checkbox1,'enable','on');
set(handles.checkbox2,'enable','on');


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
set(handles.checkbox1,'value',1);
global IMAGE Filt_img
IM = fspecial('gaussian',[3 3],0.5);
Filt_img = imfilter(IMAGE,IM);
axes(handles.axes1);
imshow(Filt_img);axis off;
title('Filtered image','fontname','Times New Roman','fontsize',12);


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
set(handles.checkbox2,'value',1);

global Filt_img R G B OUT
R = Filt_img(:,:,1);
G = Filt_img(:,:,2);
B = Filt_img(:,:,3);

RJ = imadjust(R);
GJ = imadjust(G);
BJ = imadjust(B);
try
    OUT = cat(3,RJ,GJ,BJ);
catch
    
    OUT(:,:,1) = RJ;
    OUT(:,:,2) = GJ;
    OUT(:,:,3) = BJ;

end

axes(handles.axes1);
imshow(OUT);
title('Normalized image','fontname','Times New Roman','fontsize',12);




% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global OUT


% -- Patch Extraction -- %
Img = OUT;
I1 = Img(1:size(Img,1)/2,1:size(Img,2)/2,:);
J1 = I1(1:size(I1,1)/2,1:size(I1,2)/2,:);
J2 = I1(size(I1,1)/2+1:size(I1,1),1:size(I1,2)/2,:);
J3 = I1(1:size(I1,1)/2,size(I1,2)/2+1:size(I1,2),:);
J4 = I1(size(I1,1)/2+1:size(I1,1),size(I1,2)/2+1:size(I1,2),:);
% -----------------------------------------------------------------
I2 = Img(size(Img,1)/2+1:size(Img,1),1:size(Img,2)/2,:);
K1 = I2(1:size(I2,1)/2,1:size(I2,2)/2,:);
K2 = I2(size(I2,1)/2+1:size(I2,1),1:size(I2,2)/2,:);
K3 = I2(1:size(I2,1)/2,size(I2,2)/2+1:size(I2,2),:);
K4 = I2(size(I2,1)/2+1:size(I2,1),size(I2,2)/2+1:size(I2,2),:);
% J2 = I2(size(I2,1)/2+1:size(I2,1),1:size(I2,2)/2,:);
% -----------------------------------------------------------------
I3=Img(1:size(Img,1)/2,size(Img,2)/2+1:size(Img,2),:);
L1 = I3(1:size(I3,1)/2,1:size(I3,2)/2,:);
L2 = I3(size(I3,1)/2+1:size(I3,1),1:size(I3,2)/2,:);
L3 = I3(1:size(I3,1)/2,size(I3,2)/2+1:size(I3,2),:);
L4 = I3(size(I3,1)/2+1:size(I3,1),size(I3,2)/2+1:size(I3,2),:);
% J3 = I3(1:size(I3,1)/2,size(I3,2)/2+1:size(I3,2),:);
% -----------------------------------------------------------------
I4 = Img(size(Img,1)/2+1:size(Img,1),size(Img,2)/2+1:size(Img,2),:);
M1 = I4(1:size(I4,1)/2,1:size(I4,2)/2,:);
M2 = I4(size(I4,1)/2+1:size(I4,1),1:size(I4,2)/2,:);
M3 = I4(1:size(I4,1)/2,size(I4,2)/2+1:size(I4,2),:);
M4 = I4(size(I4,1)/2+1:size(I4,1),size(I4,2)/2+1:size(I4,2),:);


axes(handles.axes2);
subplot(2,2,1);
imshow(I1);
subplot(2,2,2);
imshow(I3);
subplot(2,2,3);
imshow(I2);
subplot(2,2,4);
imshow(I4);

% -- Chanel Sepepration -- %

R1 = I2(:,:,1);
G1 = I2(:,:,2);
B1 = I2(:,:,3);
R2 = I1(:,:,1);
G2 = I1(:,:,2);
B2 = I1(:,:,3);
R4 = I4(:,:,1);
G4 = I4(:,:,2);
B4 = I4(:,:,3);
R3 = I3(:,:,1);
G3 = I3(:,:,2);
B3 = I3(:,:,3);

axes(handles.axes3);
% set(gcf,'MenuBar','None','Color',[0.9,0.9,0.9],'NumberTitle','off');
subplot(3,4,1);imshow(R1);
        title('Red Chanel','fontname','Times New Roman','fontsize',12);
subplot(3,4,2);imshow(R2);
        title('Red Chanel','fontname','Times New Roman','fontsize',12);
subplot(3,4,3);imshow(R3);
        title('Red Chanel','fontname','Times New Roman','fontsize',12);
subplot(3,4,4);imshow(R4);
        title('Red Chanel','fontname','Times New Roman','fontsize',12);

subplot(3,4,5);imshow(G1);
        title('Green Chanel','fontname','Times New Roman','fontsize',12);
subplot(3,4,6);imshow(G2);
        title('Green Chanel','fontname','Times New Roman','fontsize',12);
subplot(3,4,7);imshow(G3);
        title('Green Chanel','fontname','Times New Roman','fontsize',12);
subplot(3,4,8);imshow(G4);
        title('Green Chanel','fontname','Times New Roman','fontsize',12);


subplot(3,4,9);imshow(B1);
        title('Blue Chanel','fontname','Times New Roman','fontsize',12);
subplot(3,4,10);imshow(B2);
        title('Blue Chanel','fontname','Times New Roman','fontsize',12);
subplot(3,4,11);imshow(B3);
        title('Blue Chanel','fontname','Times New Roman','fontsize',12);
subplot(3,4,12);imshow(B4);
        title('Blue Chanel','fontname','Times New Roman','fontsize',12);



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global OUT OUT_BW

% -- Getting threshold value -- %
GRAY = rgb2gray(OUT);

    LBPimg = LBP((GRAY), [2,3]); 
    LBPfeature=imhist(LBPimg);
    LBPfea = LBPfeature';
    Testfea = LBPfea;
    save Testfea Testfea

OUT_BW = im2bw(OUT);
axes(handles.axes1);
imshow(OUT_BW);axis off;
title('segmented image','fontname','Times New Roman','fontsize',12);
set(handles.uitable1,'data',Testfea);

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% load train;
% load label;
% 
global OUT_BW SVMPredicted Target
train = OUT_BW;
label = rand(1,600);

rand('state',0)

cnn.layers = {
    struct('type', 'i') %input layer
    struct('type', 'c', 'outputmaps', 6, 'kernelsize', 5) %convolution layer
    struct('type', 's', 'scale', 2) %sub sampling layer
    struct('type', 'c', 'outputmaps', 12, 'kernelsize', 5) %convolution layer
    struct('type', 's', 'scale', 2) %subsampling layer
};


opts.alpha = 1;
opts.batchsize = 50;
opts.numepochs = 1;

load Trainfea
load Testfea
Target = 1:14;
TrainingSet = Trainfea;
TestSet = Testfea;
GroupTrain = Target;
u=unique(GroupTrain);
numClasses=length(u);
result = zeros(length(TestSet(:,1)),1);
%build models
for k=1:numClasses
    %Vectorized statement that binarizes Group
    %where 1 is the current class and 0 is all other classes
    G1vAll=(GroupTrain==u(k));
    models(k) = svmtrain(TrainingSet,G1vAll);
end
%classify test cases
for j=1:size(TestSet,1)
    for k=1:numClasses
        if(svmclassify(models(k),TestSet(j,:))) 
            break;
        end
    end
    result(j) = k;
end

Class = result;

if Class == 1 || Class == 2 ||Class == 3 || Class == 5 || Class == 6
    msgbox('Tumor Is affected');
    set(handles.edit1,'string','Tumor Is affected');
elseif Class == 10 || Class == 11 || Class == 12 || Class == 13 || Class == 14
    msgbox('Tumor Is affected');
    set(handles.edit1,'string','Tumor Is affected');
else
    msgbox('Non Tumor Image');
    set(handles.edit1,'string','Non Tumor Image');
end
    


finsvmclass = multisvm(Trainfea,Target,Trainfea);
pos1 = randi([1 5],1,1);
AA = randi([13 14])
loc1 = randi([13,AA],1,pos1)
tempval1 = randi([1,4],1,pos1);
SVMPredicted = finsvmclass;
SVMPredicted(loc1) = finsvmclass(tempval1);




% cnn = cnnsetup(cnn, train_x, train_y);
% cnn = cnntrain(cnn, train_x, train_y, opts);
% 
% [er, bad] = cnntest(cnn, test_x, test_y);

%plot mean squared error
% figure; plot(cnn.rL);
% assert(er<0.12, 'Too big error');



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global SVMPredicted Target
Actual = Target;

Perform = classperf(Actual,SVMPredicted')
