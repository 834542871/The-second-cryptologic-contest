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
    [y,fs]=wavread(y1,[6980000,6996347]);%64ͼƬ��С������Ƶ,16384
    sound(y,fs);%��ȡ��ԭʼ����Ƶ
elseif N==128
    [y,fs]=wavread(y1,[6980000,7045535]);%128ͼƬ��С������Ƶ,65536
    sound(y,fs);%��ȡ��ԭʼ����Ƶ
elseif N==256
    [y,fs]=wavread(y1,[6980000,7242143]);%256ͼƬ��С������Ƶ,262144
    sound(y,fs);%��ȡ��ԭʼ����Ƶ
elseif N==512
    [y,fs]=wavread(y1,[6980000,8028575]);%512ͼƬ��С������Ƶ,1048576
    sound(y,fs);%��ȡ��ԭʼ����Ƶ
elseif N==1024
    [y,fs]=wavread(y1,[3000000,7194303]);%1024ͼƬ��С������Ƶ,4194304
% [y,fs]=wavread(y1,[3000000,6999999]);%1024ͼƬ��С������Ƶ,4194304
    sound(y,fs);%��ȡ��ԭʼ����Ƶ
else 
    [y,fs]=wavread(y1,[6980000,7242143]);%256ͼƬ��С������Ƶ,262144
    sound(y,fs);%��ȡ��ԭʼ����Ƶ
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
    [y,fs]=wavread(y1,[6980000,6996383]);%64ͼƬ��С������Ƶ,16384
    sample = calsample(y,fs);%��˫������̵���������Ƶ�ʱ�Ϊ���11025
    fs=fs/(fs/11025);
    z1=reshape(sample,N,N);%���512*512ͼƬ�Ĵ�С
    maxz=max(max(abs(z1)));
    z2=z1./maxz;
    % ��һ��
    z3=(z2+1.0)/2;
    axes(handles.axes1);
    imshow(z1);title('-1-1��ƵͼƬ');%��ʾԭʼ��ƵͼƬ
    % axes(handles.axes1);
    % imshow(z3);title('0-1��ƵͼƬ');%��ʾ��ƵͼƬ
    imwrite(z3,'YPP1.bmp','bmp');%��ͼƬ����Ϊbmp��ʽ
elseif N==128
    [y,fs]=wavread(y1,[6980000,7045535]);%128ͼƬ��С������Ƶ,1048576
    sample = calsample(y,fs);
    fs=fs/(fs/11025);
    z1=reshape(sample,N,N);
    maxz=max(max(abs(z1)));
    z2=z1./maxz;
    % ��һ��
    z3=(z2+1.0)/2;
    axes(handles.axes1);
    imshow(z1);title('-1-1��ƵͼƬ');
    imwrite(z3,'YPP1.bmp','bmp');
elseif N==256
    [y,fs]=wavread(y1,[6980000,7242143]);%256ͼƬ��С������Ƶ,1048576
    sample = calsample(y,fs);
    fs=fs/(fs/11025);
    z1=reshape(sample,N,N);
    maxz=max(max(abs(z1)));
    z2=z1./maxz;
    % ��һ��
    z3=(z2+1.0)/2;
    axes(handles.axes1);
    imshow(z1);title('-1-1��ƵͼƬ');
    imwrite(z3,'YPP1.bmp','bmp');
elseif N==512
    [y,fs]=wavread(y1,[6980000,8028575]);%512ͼƬ��С������Ƶ,1048576
    sample = calsample(y,fs);
    fs=fs/(fs/11025);
    z1=reshape(sample,N,N);
    maxz=max(max(abs(z1)));
    z2=z1./maxz;
    % ��һ��
    z3=(z2+1.0)/2;
    axes(handles.axes1);
    imshow(z1);title('-1-1��ƵͼƬ');
    imwrite(z3,'YPP1.bmp','bmp');
elseif N==1024
    [y,fs]=wavread(y1,[3000000,7194303]);%1024ͼƬ��С������Ƶ,4194304
% [y,fs]=wavread(y1,[3000000,6999999]);%512ͼƬ��С������Ƶ,1048576
    sample = calsample(y,fs);
    fs=fs/(fs/11025);
    z1=reshape(sample,N,N);
    maxz=max(max(abs(z1)));
    z2=z1./maxz;
    % ��һ��
    z3=(z2+1.0)/2;
    axes(handles.axes1);
    imshow(z1);title('-1-1��ƵͼƬ');
    imwrite(z3,'YPP1.bmp','bmp');
else 
    N=256;
end
    
function Select_Picture_Callback(hObject, eventdata, handles)
global X0;
global filename;

%% ��ȡͼƬ
[filename pathname filter] = uigetfile({'*.bmp';'*.jpg';'*.png'},'ѡ��ͼƬ');
if  filter ~= 0
    XRGB= imread([pathname,filename]);  
end
axes(handles.axes2);
imshow(XRGB);title('ԭͼ');%ͼ1��RGBͼ��ԭͼ
X0=rgb2gray(XRGB);%��RGBͼ��ת��Ϊ�Ҷ�ͼ��


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
%% ������СʹͼƬ��Ϊ�����δ�С
[M0,N0]=size(X0);
N1=min(M0,N0);
X1=zeros(N1,N1);
X1(1:N1,1:N1)=X0(1:N1,1:N1);

%% ������С��ΪN*N
% N=512;          %�趨ȡ����
pix=0.00465;      %�趨CCD���ؼ��
L=N*pix;         %CCD��� L=4.76;
X1=imresize(X1,N/N1);%��X1��N1*N1�޸�ΪN*N���ͼ��
 
z0=1000;         % ������� mm(���Ը�����Ҫ�޸�)
h=0.532e-3;       %�Ⲩ�� mm(���Ը�����Ҫ�޸�)�ɼ���Ĳ�����Χ780��390nm������=�ٶ�/Ƶ��
k=2*pi/h;         %����
L0=sqrt(h*z0*N); %FFT����ʱͬʱ�����������λȡ����������ⳡ���
 
Y=double(X1);
bb=rand(N,N)*pi*2;
X=Y.*exp(i.*bb);%���������λ����ģ��ɢ������
U0=double(X); 
Uh=[0:N-1]-N/2;Vh=[0:N-1]-N/2;   
[mh,nh]=meshgrid(Uh,Vh);
T=L0/N;        % ��ⳡ���ؼ�� mm;
figstr=strcat('��ƽ����=',num2str(L0),'mm');
% figure(3),imagesc(Uh*T,Vh*T,abs(X));colormap(gray); xlabel(figstr);title('��ƽ��ͼ��');
%% ----------�����������D-FFT������ʼ
n=1:N;
x=-L0/2+L0/N*(n-1);                     
y=x;
[yy,xx] = meshgrid(y,x); 
Fresnel=exp(i*k/2/z0*(xx.^2+yy.^2))*exp(i*k*z0)/(i*h*z0);
Hf=fft2(Fresnel,N,N);
Hf=fftshift(Hf);
Uf=fft2(U0,N,N);
Uf=fftshift(Uf);%��ⳡƵ��
Uf=Uf.*Hf;
Uf=ifft2(Uf,N,N);
Uf=Uf*T*T;      %��ά��ɢ�任��ֵ����
%---------------�����������D-FFT�������
%% ---------------4�������γ�4��ȫϢͼ
Ar=mean(mean(abs(Uf)));%�����䳡���ƽ��ֵ��Ϊ�ο������
figstr1=strcat('ȫϢͼ���=',num2str(L),'mm');
%---------------------------------0����
Ur=Ar;%�ο���
Uh=Ur+Uf;%���Ͳο���������
Ih=Uh.*conj(Uh);%�����Ͳο������ͼǿ�ȷֲ�������������ȫϢͼ
Imax=max(max(Ih));
I1=uint8(Ih./Imax*255);%�任Ϊ����ֵ255��������
imwrite(I1,'I1.bmp','bmp'); 
axes(handles.axes2);
imshow(I1,[]);colormap(gray);xlabel(figstr1);axis equal;axis tight;title('ȫϢͼ');
%---------------------------------pi/2����
Ur=Ar*exp(i*pi/2);
Uh=Ur+Uf;
Ih=Uh.*conj(Uh);%����������ȫϢͼ
Imax=max(max(Ih));
I2=uint8(Ih./Imax*255);%�任Ϊ����ֵ255��������
imwrite(I2,'I2.bmp','bmp'); 
%---------------------------------pi����
Ur=Ar*exp(i*pi);
Uh=Ur+Uf;
Ih=Uh.*conj(Uh);%����������ȫϢͼ
Imax=max(max(Ih));
I3=uint8(Ih./Imax*255);%�任Ϊ����ֵ255��������
imwrite(I3,'I3.bmp','bmp'); 
%---------------------------------3*pi/2����
Ur=Ar*exp(i*3*pi/2);
Uh=Ur+Uf;
Ih=Uh.*conj(Uh);%����������ȫϢͼ
Imax=max(max(Ih));
I4=uint8(Ih./Imax*255);%�任Ϊ����ֵ255��������
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
Yuantu=imread('YPP1.bmp');%����һ������ͼ��
I1=imread('I1.bmp');%����һ������ͼ��256λ��
Hyt=imresize(Yuantu,N/N);%������ͼ��Ĵ�С����������Ƕ���ͼ��һ����С������Ƕ������
            Hyt1=fft2(Hyt,N,N);
            I11=fft2(I1,N,N);
            I11=fftshift(I11);%��ⳡƵ��
            WaterPic=I11*0.1+Hyt1;%��Ƕ���ȫϢͼ*ϵ�������������أ���Ӱ���������ʾ
            WaterPic0=ifft2(WaterPic,N,N);
            WaterPic1=uint8(WaterPic0);
            psnr1=psnr(Hyt,WaterPic1,N,N)
axes(handles.axes3);imshow(WaterPic1,[]);title('��ˮӡ����ͼ')
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
% wm; %ע�����a����û�С�;���ţ��������
delete VS.txt;
fout=f(i+1:i+4096);
fout=reshape(fout,64,64);
% dlmwrite('WaterData.txt',fout);
fout=fout';
csvwrite('WaterData.txt',fout);
% fwrite(fid,fout,'int');
system('C:\Users\����\Desktop\����ȫϢ����Ƶͼ������֤ϵͳ\SM464.exe');
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
imshow(ZL,[]),title('��������ȫϢˮӡ��Ƶ��Ϣͼ');
toc
