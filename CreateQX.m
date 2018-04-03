%--1. 用D—FFT的方法进行全息图的生成--%
%--2.将生成的四个全息图的其中一个，进行图像的隐藏于提取--%
%--3。通过同轴4步相移法进行去全息图的重构，其中包括D-FFT的逆运算；--%

clear all;close all;clc;
global N;
global pix;
global z0;


%% 读取图片
chemin='C:\Users\Administrator\Desktop\基于全息的音频图像保密认证系统\';
[nom,chemin]=uigetfile([chemin,'*.*'],'调入模拟物体图像');%nom:选择图片的名字及格式，chemin是路径,on代表当前位置，如果指定了路径，这个省略，[x,y]只能在Unix下使用。
[XRGB,MAP]=imread([chemin,nom]);
figure(1),imshow(XRGB);title('原图');%图1，RGB图像，原图
X0=rgb2gray(XRGB);%将RGB图像转换为灰度图像
figure(2),imshow(X0,[]);title('灰度图');%图2

%% 调整大小使图片成为正方形大小
[M0,N0]=size(X0);
N1=min(M0,N0);
X1=zeros(N1,N1);
X1(1:N1,1:N1)=X0(1:N1,1:N1);

%% 调整大小成为N*N
N=512;          %设定取样数
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
% figure(4);imagesc(Uh*T,Vh*T,abs(Uf));colormap(gray);axis equal;axis tight;title('到达CCD的物光场振幅');
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
figure(5);imshow(I1,[]);colormap(gray);xlabel(figstr1);axis equal;axis tight;title('全息图');
% figure(5);imshow(I1,[]);colormap(gray);xlabel(figstr1);axis equal;axis tight;title('全息图I1');
%---------------------------------pi/2相移
Ur=Ar*exp(i*pi/2);
Uh=Ur+Uf;
Ih=Uh.*conj(Uh);%浮点型数字全息图
Imax=max(max(Ih));
I2=uint8(Ih./Imax*255);%变换为极大值255的整型数
imwrite(I2,'I2.bmp','bmp'); 
%   I2=imread('waterTest2.bmp'); 
% figure(6);imshow(I2,[]);colormap(gray);xlabel(figstr1);axis equal;axis tight;title('全息图I2');
%---------------------------------pi相移
Ur=Ar*exp(i*pi);
Uh=Ur+Uf;
Ih=Uh.*conj(Uh);%浮点型数字全息图
Imax=max(max(Ih));
I3=uint8(Ih./Imax*255);%变换为极大值255的整型数
imwrite(I3,'I3.bmp','bmp'); 
%  I3=imread('waterTest3.bmp');
% figure(7);imshow(I3,[]);colormap(gray);xlabel(figstr1);axis equal;axis tight;title('全息图I3');
%---------------------------------3*pi/2相移
Ur=Ar*exp(i*3*pi/2);
Uh=Ur+Uf;
Ih=Uh.*conj(Uh);%浮点型数字全息图
Imax=max(max(Ih));
I4=uint8(Ih./Imax*255);%变换为极大值255的整型数
imwrite(I4,'I4.bmp','bmp'); 
%   I4=imread('waterTest4.jpg');
% figure(8);imshow(I4,[]);colormap(gray);xlabel(figstr1);axis equal;axis tight;title('全息图I4');