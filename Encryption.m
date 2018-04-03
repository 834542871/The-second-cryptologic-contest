function varargout = Encryption(varargin)
% ENCRYPTION MATLAB code for Encryption.fig
%      ENCRYPTION, by itself, creates a new ENCRYPTION or raises the existing
%      singleton*.
%
%      H = ENCRYPTION returns the handle to a new ENCRYPTION or the handle to
%      the existing singleton*.
%
%      ENCRYPTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENCRYPTION.M with the given input arguments.
%
%      ENCRYPTION('Property','Value',...) creates a new ENCRYPTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Encryption_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Encryption_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Encryption

% Last Modified by GUIDE v2.5 30-Nov-2016 08:27:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Encryption_OpeningFcn, ...
                   'gui_OutputFcn',  @Encryption_OutputFcn, ...
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


% --- Executes just before Encryption is made visible.
function Encryption_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Encryption (see VARARGIN)

% Choose default command line output for Encryption
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Encryption wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Encryption_OutputFcn(hObject, eventdata, handles) 
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
% --- Executes on button press in Select_Audio.
function Select_Audio_Callback(hObject, eventdata, handles)
% hObject    handle to Select_Audio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
global y1;
[filename pathname filter] = uigetfile('*.wav');
if  filter ~= 0
    y1= fullfile(pathname,filename);  
end
% --- Executes on button press in Play_Audio.
function Play_Audio_Callback(hObject, eventdata, handles)
% hObject    handle to Play_Audio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
global y1;
global N;
if N==64
    [y,fs]=wavread(y1,[6980000,6996347]);%64图片大小所需音频,16384
    sound(y,fs);%截取的原始的音频
elseif N==128
    [y,fs]=wavread(y1,[6980000,7045535]);%128图片大小所需音频,65536
    sound(y,fs);%截取的原始的音频
elseif N==256
    [y,fs]=wavread(y1,[6980000,7242143]);%256图片大小所需音频,262144
    sound(y,fs);%截取的原始的音频
elseif N==512
    [y,fs]=wavread(y1,[6980000,8028575]);%512图片大小所需音频,1048576
    sound(y,fs);%截取的原始的音频
elseif N==1024
    [y,fs]=wavread(y1,[3000000,7194303]);%1024图片大小所需音频,4194304
% [y,fs]=wavread(y1,[3000000,6999999]);%1024图片大小所需音频,4194304
    sound(y,fs);%截取的原始的音频
else 
    [y,fs]=wavread(y1,[6980000,7242143]);%256图片大小所需音频,262144
    sound(y,fs);%截取的原始的音频
end
toc
% --- Executes on button press in Turn_Picture.
function Turn_Picture_Callback(hObject, eventdata, handles)
global maxz;
global y;
global fs;
global y1;
global N;

if N==64
    [y,fs]=wavread(y1,[6980000,6996383]);%64图片大小所需音频,16384
    sample = calsample(y,fs);%将双声道编程单声道并且频率变为最低11025
    fs=fs/(fs/11025);
    z1=reshape(sample,N,N);%变成512*512图片的大小
    maxz=max(max(abs(z1)));
    z2=z1./maxz;
    % 归一化
    z3=(z2+1.0)/2;
    axes(handles.axes1);
    imshow(z1);title('-1-1音频图片');%显示原始音频图片
    % axes(handles.axes1);
    % imshow(z3);title('0-1音频图片');%显示音频图片
    imwrite(z3,'YPP1.bmp','bmp');%将图片保存为bmp格式
elseif N==128
    [y,fs]=wavread(y1,[6980000,7045535]);%128图片大小所需音频,1048576
    sample = calsample(y,fs);
    fs=fs/(fs/11025);
    z1=reshape(sample,N,N);
    maxz=max(max(abs(z1)));
    z2=z1./maxz;
    % 归一化
    z3=(z2+1.0)/2;
    axes(handles.axes1);
    imshow(z1);title('-1-1音频图片');
    imwrite(z3,'YPP1.bmp','bmp');
elseif N==256
    [y,fs]=wavread(y1,[6980000,7242143]);%256图片大小所需音频,1048576
    sample = calsample(y,fs);
    fs=fs/(fs/11025);
    z1=reshape(sample,N,N);
    maxz=max(max(abs(z1)));
    z2=z1./maxz;
    % 归一化
    z3=(z2+1.0)/2;
    axes(handles.axes1);
    imshow(z1);title('-1-1音频图片');
    imwrite(z3,'YPP1.bmp','bmp');
elseif N==512
    [y,fs]=wavread(y1,[6980000,8028575]);%512图片大小所需音频,1048576
    sample = calsample(y,fs);
    fs=fs/(fs/11025);
    z1=reshape(sample,N,N);
    maxz=max(max(abs(z1)));
    z2=z1./maxz;
    % 归一化
    z3=(z2+1.0)/2;
    axes(handles.axes1);
    imshow(z1);title('-1-1音频图片');
    imwrite(z3,'YPP1.bmp','bmp');
elseif N==1024
    [y,fs]=wavread(y1,[3000000,7194303]);%1024图片大小所需音频,4194304
% [y,fs]=wavread(y1,[3000000,6999999]);%512图片大小所需音频,1048576
    sample = calsample(y,fs);
    fs=fs/(fs/11025);
    z1=reshape(sample,N,N);
    maxz=max(max(abs(z1)));
    z2=z1./maxz;
    % 归一化
    z3=(z2+1.0)/2;
    axes(handles.axes1);
    imshow(z1);title('-1-1音频图片');
    imwrite(z3,'YPP1.bmp','bmp');
else 
    N=256;
end
    
function Select_Picture_Callback(hObject, eventdata, handles)
global X0;
global filename;

%% 读取图片
[filename pathname filter] = uigetfile({'*.bmp';'*.jpg';'*.png'},'选择图片');
if  filter ~= 0
    XRGB= imread([pathname,filename]);  
end
axes(handles.axes2);
imshow(XRGB);title('原图');%图1，RGB图像，原图
X0=rgb2gray(XRGB);%将RGB图像转换为灰度图像


function CreateQX_Callback(hObject, eventdata, handles)
% hObject    handle to CreateQX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%%%%%%
global N;
global pix;
global z0;
global X0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 调整大小使图片成为正方形大小
[M0,N0]=size(X0);
N1=min(M0,N0);
X1=zeros(N1,N1);
X1(1:N1,1:N1)=X0(1:N1,1:N1);

%% 调整大小成为N*N
% N=512;          %设定取样数
pix=0.00465;      %设定CCD像素间隔
L=N*pix;         %CCD宽度 L=4.76;
X1=imresize(X1,N/N1);%将X1从N1*N1修改为N*N点的图像
 
z0=1000;         % 衍射距离 mm(可以根据需要修改)
h=0.532e-3;       %光波长 mm(可以根据需要修改)可见光的波长范围780～390nm，波长=速度/频率
k=2*pi/h;         %波数
L0=sqrt(h*z0*N); %FFT计算时同时满足振幅及相位取样条件的物光场宽度
 
Y=double(X1);
bb=rand(N,N)*pi*2;
X=Y.*exp(i.*bb);%叠加随机相位噪声模拟散射物体
U0=double(X); 
Uh=[0:N-1]-N/2;Vh=[0:N-1]-N/2;   
[mh,nh]=meshgrid(Uh,Vh);
T=L0/N;        % 物光场像素间距 mm;
figstr=strcat('物平面宽度=',num2str(L0),'mm');
% figure(3),imagesc(Uh*T,Vh*T,abs(X));colormap(gray); xlabel(figstr);title('物平面图像');
%% ----------菲涅耳衍射的D-FFT计算起始
n=1:N;
x=-L0/2+L0/N*(n-1);                     
y=x;
[yy,xx] = meshgrid(y,x); 
Fresnel=exp(i*k/2/z0*(xx.^2+yy.^2))*exp(i*k*z0)/(i*h*z0);
Hf=fft2(Fresnel,N,N);
Hf=fftshift(Hf);
Uf=fft2(U0,N,N);
Uf=fftshift(Uf);%物光场频谱
Uf=Uf.*Hf;
Uf=ifft2(Uf,N,N);
Uf=Uf*T*T;      %二维离散变换量值补偿
%---------------菲涅耳衍射的D-FFT计算结束
%% ---------------4步相移形成4幅全息图
Ar=mean(mean(abs(Uf)));%将衍射场振幅平均值设为参考光振幅
figstr1=strcat('全息图宽度=',num2str(L),'mm');
%---------------------------------0相移
Ur=Ar;%参考光
Uh=Ur+Uf;%物光和参考光叠加振幅
Ih=Uh.*conj(Uh);%（物光和参考光干涉图强度分布）浮点型数字全息图
Imax=max(max(Ih));
I1=uint8(Ih./Imax*255);%变换为极大值255的整型数
imwrite(I1,'I1.bmp','bmp'); 
axes(handles.axes2);
imshow(I1,[]);colormap(gray);xlabel(figstr1);axis equal;axis tight;title('全息图');
%---------------------------------pi/2相移
Ur=Ar*exp(i*pi/2);
Uh=Ur+Uf;
Ih=Uh.*conj(Uh);%浮点型数字全息图
Imax=max(max(Ih));
I2=uint8(Ih./Imax*255);%变换为极大值255的整型数
imwrite(I2,'I2.bmp','bmp'); 
%---------------------------------pi相移
Ur=Ar*exp(i*pi);
Uh=Ur+Uf;
Ih=Uh.*conj(Uh);%浮点型数字全息图
Imax=max(max(Ih));
I3=uint8(Ih./Imax*255);%变换为极大值255的整型数
imwrite(I3,'I3.bmp','bmp'); 
%---------------------------------3*pi/2相移
Ur=Ar*exp(i*3*pi/2);
Uh=Ur+Uf;
Ih=Uh.*conj(Uh);%浮点型数字全息图
Imax=max(max(Ih));
I4=uint8(Ih./Imax*255);%变换为极大值255的整型数
imwrite(I4,'I4.bmp','bmp'); 

% --- Executes on button press in WatermarkQR.
function WatermarkQR_Callback(hObject, eventdata, handles)
% hObject    handle to WatermarkQR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global  I11;
global N;
global WaterPic1;
global Hyt1;
% N=512;
Yuantu=imread('YPP1.bmp');%读入一个载体图像
I1=imread('I1.bmp');%读入一个载体图像，256位的
Hyt=imresize(Yuantu,N/N);%将载体图像的大小，调整到和嵌入的图像一样大小，便于嵌入隐藏
            Hyt1=fft2(Hyt,N,N);
            I11=fft2(I1,N,N);
            I11=fftshift(I11);%物光场频谱
            WaterPic=I11*0.1+Hyt1;%将嵌入的全息图*系数，有利于隐藏，不影响载体的显示
            WaterPic0=ifft2(WaterPic,N,N);
            WaterPic1=uint8(WaterPic0);
            psnr1=psnr(Hyt,WaterPic1,N,N)
axes(handles.axes3);imshow(WaterPic1,[]);title('含水印载体图')
imwrite(WaterPic1,'WaterPic.bmp','bmp'); 
% --- Executes on button press in PlayAudio_water.
function PlayAudio_water_Callback(hObject, eventdata, handles)
% hObject    handle to PlayAudio_water (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global maxz;
global WaterPic1;
Y2=double(WaterPic1);
sample1=Y2(:);
maxs=max(sample1);
sample2=sample1/maxs;
% sample3=mapminmax(sample2);
% maxz=0.9194;
sample3=(sample2*2.0-1.0)*maxz;
sound(sample3,11025);



function SM4_Encryption_Callback(hObject, eventdata, handles)
% hObject    handle to SM4_Encryption (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global mx ny ex;
f=imread('WaterPic.bmp');
% f=imread('PTY.bmp');
delete WaterData.txt;
delete JiaM.txt;
[mx,ny]=size(f);
f=reshape(f',1,[]); 
Sf=max(size(f));
i=0;
ex=[];
%fid=fopen('D:\StudyProjects\Debug\WaterData.txt','w');
while i<Sf
% wm; %注意变量a后面没有“;”号，即可输出
delete VS.txt;
fout=f(i+1:i+4096);
fout=reshape(fout,64,64);
% dlmwrite('WaterData.txt',fout);
fout=fout';
csvwrite('WaterData.txt',fout);
% fwrite(fid,fout,'int');
system('C:\Users\王丽\Desktop\基于全息的音频图像保密认证系统\SM464.exe');
i=i+4096;
ex1=load('VS.txt');
ex=[ex;ex1];
end
jiami=load('JiaM.txt');
jiami=jiami';
jiami=jiami(:);
b=reshape(jiami,mx*2,ny*2);
b=uint8(b);
ZL=b;
imwrite(ZL,'ZLT.bmp');
axes(handles.axes4);
imshow(ZL,[]),title('加密置乱全息水印音频信息图');
toc
