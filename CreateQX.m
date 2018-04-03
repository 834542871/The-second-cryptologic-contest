%--1. ��D��FFT�ķ�������ȫϢͼ������--%
%--2.�����ɵ��ĸ�ȫϢͼ������һ��������ͼ�����������ȡ--%
%--3��ͨ��ͬ��4�����Ʒ�����ȥȫϢͼ���ع������а���D-FFT�������㣻--%

clear all;close all;clc;
global N;
global pix;
global z0;


%% ��ȡͼƬ
chemin='C:\Users\Administrator\Desktop\����ȫϢ����Ƶͼ������֤ϵͳ\';
[nom,chemin]=uigetfile([chemin,'*.*'],'����ģ������ͼ��');%nom:ѡ��ͼƬ�����ּ���ʽ��chemin��·��,on����ǰλ�ã����ָ����·�������ʡ�ԣ�[x,y]ֻ����Unix��ʹ�á�
[XRGB,MAP]=imread([chemin,nom]);
figure(1),imshow(XRGB);title('ԭͼ');%ͼ1��RGBͼ��ԭͼ
X0=rgb2gray(XRGB);%��RGBͼ��ת��Ϊ�Ҷ�ͼ��
figure(2),imshow(X0,[]);title('�Ҷ�ͼ');%ͼ2

%% ������СʹͼƬ��Ϊ�����δ�С
[M0,N0]=size(X0);
N1=min(M0,N0);
X1=zeros(N1,N1);
X1(1:N1,1:N1)=X0(1:N1,1:N1);

%% ������С��ΪN*N
N=512;          %�趨ȡ����
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
% figure(4);imagesc(Uh*T,Vh*T,abs(Uf));colormap(gray);axis equal;axis tight;title('����CCD����ⳡ���');
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
figure(5);imshow(I1,[]);colormap(gray);xlabel(figstr1);axis equal;axis tight;title('ȫϢͼ');
% figure(5);imshow(I1,[]);colormap(gray);xlabel(figstr1);axis equal;axis tight;title('ȫϢͼI1');
%---------------------------------pi/2����
Ur=Ar*exp(i*pi/2);
Uh=Ur+Uf;
Ih=Uh.*conj(Uh);%����������ȫϢͼ
Imax=max(max(Ih));
I2=uint8(Ih./Imax*255);%�任Ϊ����ֵ255��������
imwrite(I2,'I2.bmp','bmp'); 
%   I2=imread('waterTest2.bmp'); 
% figure(6);imshow(I2,[]);colormap(gray);xlabel(figstr1);axis equal;axis tight;title('ȫϢͼI2');
%---------------------------------pi����
Ur=Ar*exp(i*pi);
Uh=Ur+Uf;
Ih=Uh.*conj(Uh);%����������ȫϢͼ
Imax=max(max(Ih));
I3=uint8(Ih./Imax*255);%�任Ϊ����ֵ255��������
imwrite(I3,'I3.bmp','bmp'); 
%  I3=imread('waterTest3.bmp');
% figure(7);imshow(I3,[]);colormap(gray);xlabel(figstr1);axis equal;axis tight;title('ȫϢͼI3');
%---------------------------------3*pi/2����
Ur=Ar*exp(i*3*pi/2);
Uh=Ur+Uf;
Ih=Uh.*conj(Uh);%����������ȫϢͼ
Imax=max(max(Ih));
I4=uint8(Ih./Imax*255);%�任Ϊ����ֵ255��������
imwrite(I4,'I4.bmp','bmp'); 
%   I4=imread('waterTest4.jpg');
% figure(8);imshow(I4,[]);colormap(gray);xlabel(figstr1);axis equal;axis tight;title('ȫϢͼI4');