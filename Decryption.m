function varargout = Decryption(varargin)
% DECRYPTION MATLAB code for Decryption.fig
%      DECRYPTION, by itself, creates a new DECRYPTION or raises the existing
%      singleton*.
%
%      H = DECRYPTION returns the handle to a new DECRYPTION or the handle to
%      the existing singleton*.
%
%      DECRYPTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DECRYPTION.M with the given input arguments.
%
%      DECRYPTION('Property','Value',...) creates a new DECRYPTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Decryption_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Decryption_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Decryption

% Last Modified by GUIDE v2.5 24-Dec-2016 20:14:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Decryption_OpeningFcn, ...
                   'gui_OutputFcn',  @Decryption_OutputFcn, ...
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


% --- Executes just before Decryption is made visible.
function Decryption_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Decryption (see VARARGIN)

% Choose default command line output for Decryption
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Decryption wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Decryption_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in SM4_Decryption.
function SM4_Decryption_Callback(hObject, eventdata, handles)
% hObject    handle to SM4_Decryption (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
% global HFT;
% HFT=arnold('ZLT.bmp',4,1);
% imwrite(HFT,'HFT.bmp','bmp');
% axes(handles.axes1);
% imshow(HFT);title('SM4解密后的含水印载体图');
global mx ny ex HFT;
ex=reshape(ex',1,[]); 
b1=reshape(ex',mx,ny);
% b1=uint8(b1);
HFT=b1';
HFT=uint8(HFT);
imwrite(HFT,'HFT.bmp');
axes(handles.axes1);
imshow(HFT);title('SM4解密后的含水印载体图');


% --- Executes on button press in Attack_test.
function Attack_test_Callback(hObject, eventdata, handles)
% hObject    handle to Attack_test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global att HFT;
global N;
%%%攻击测试
%% %%%%%%%%%%%% 进行攻击测试 %%%%%%%%%%%
disp('1-->加入白噪声');
disp('2-->剪切图像');
disp('3-->直接检测')
begin=input('请选择攻击（1-3）：');
switch begin
%%%%%%% 加入白噪声 %%%%%%%%
case 1
% HFT1=double(HFT);
% Aimage1=fft2(HFT1);

Aimage1=HFT;
Aimage1=double(Aimage1);
Wnoise=0.5*randn(size(Aimage1,2));
Aimage2=Aimage1+Wnoise;
% Hyt12=fftshift(Aimage2);
% Hyt12=ifft2(Hyt12,N,N);
% Hyt121=Hyt12;
% Hyt121=uint8(abs(Hyt121));
psnr2=psnr(Aimage2,HFT,N,N)
Aimage2=uint8(Aimage2);
axes(handles.axes1);
imshow(Aimage2,[]),title('加入噪声后的全息水印音频信息图');
att=Aimage2;
% imwrite(att,'chulihouimage.bmp');
%%%%%%%% 剪切攻击 %%%%%%%%
case 2
% HFT1=double(HFT);
% HFT1=fft2(HFT1);
Aimage3=HFT;
% Aimage3(1:64,1:64)=0;
Aimage3(32:96,32:96)=0;
% Hyt12=fftshift(Aimage3);
% Hyt12=ifft2(Hyt12,N,N);
% Hyt121=Hyt12;
% Hyt121=uint8(abs(Hyt121));
psnr2=psnr(Aimage3,HFT,N,N)
axes(handles.axes1);
imshow(Aimage3,[]),title('剪切后的全息水印音频信息图');
att=Aimage3;
% imwrite(att,'chulihouimage.bmp');
%%%%%%% 没有受到攻击 %%%%%%%
case 3
% imwrite(ZL,'ZLT.bmp','bmp');
att=HFT;
axes(handles.axes1);
imshow(att,[]),title('未受到攻击的全息水印音频信息图');
% imwrite(att,'chulihouimage.bmp');
end


% --- Executes on button press in TiquQXYP.
function TiquQXYP_Callback(hObject, eventdata, handles)
% hObject    handle to TiquQXYP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I11 att;
global N;
global Hyt1;
% Yuantu=imread('YPP1.bmp');%读入一个载体图像，256位的
% % sizeY=max(size(Yuantu));
% I1=imread('I1.bmp');%读入一个载体图像，256位的
% Hyt=imresize(Yuantu,N/N);%将载体图像的大小，调整到和嵌入的图像一样大小，便于嵌入隐藏
%             Hyt1=fft2(Hyt,N,N);
%             I11=fft2(I1,N,N);
%             I11=fftshift(I11);%物光场频谱
%             WaterPic=I11*0.1+Hyt1;%将嵌入的全息图*系数，有利于隐藏，不影响载体的显示
%             WaterPic1=ifft2(WaterPic,N,N);
%             WaterPic1=uint8(WaterPic1);
% %             psnr=psnr(Hyt,WaterPic1,N,N);
% imwrite(WaterPic1,'WaterPic.bmp','bmp'); 
%---------------------------------图像隐藏结束
% att1=double(att);
HFT1=fft2(att,N,N);
Hyt12=HFT1-I11*0.1;
Hyt121=fftshift(Hyt12);
Hyt121=ifft2(Hyt121,N,N);
Hyt121=uint8(abs(Hyt121));
imwrite(Hyt121,'Hyt1.bmp','bmp');
axes(handles.axes1); imshow(Hyt121,[]);title('提取的音频图');
I1=(HFT1-Hyt1)/0.1;
% I1=HFT1-Hyt1;
I12=fftshift(I1);
I12=ifft2(I12,N,N);
I12=uint8(abs(I12));
imwrite(I12,'I11.bmp','bmp');
axes(handles.axes2); imshow(I12,[]);title('提取的水印图');

function Recover_Audio_Callback(hObject, eventdata, handles)
% hObject    handle to Recover_Audio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global N;
% N=512;
Yuantu=imread('YPP1.bmp');%读入一个载体图像，512位的
I1=imread('I1.bmp');%读入一个载体图像，512位的
Hyt=imresize(Yuantu,N/N);%将载体图像的大小，调整到和嵌入的图像一样大小，便于嵌入隐藏
            Hyt1=fft2(Hyt,N,N);
            I11=fft2(I1,N,N);
            I11=fftshift(I11);%物光场频谱
            WaterPic=I11*0.01+Hyt1;%将嵌入的全息图*系数，有利于隐藏，不影响载体的显示
            WaterPic1=ifft2(WaterPic,N,N);
            WaterPic1=uint8(WaterPic1);
%             psnr=psnr(Hyt,WaterPic1,N,N);
imwrite(WaterPic1,'WaterPic.bmp','bmp'); 
Y2=double(WaterPic1);
sample1=Y2(:);
maxs=max(sample1);
sample2=sample1/maxs;
% sample3=mapminmax(sample2);
maxz=0.9194;
sample3=(sample2*2.0-1.0)*maxz;
sound(sample3,11025);
Y3=reshape(sample3,N,N);
axes(handles.axes3); 
imshow(Y3);title('恢复-1-1音频图片');%显示原始音频图片


% --- Executes on button press in RecoverQX.
function RecoverQX_Callback(hObject, eventdata, handles)
% hObject    handle to RecoverQX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filename;
if  strcmp(filename,'DH.bmp')==1;%比较两个字符串相等
    TT2=RecoverLTQX();
else
    TT2=RecoverPTQX();
end
    axes(handles.axes4);
    imshow(TT2);title('重建物平面图像');
toc  
