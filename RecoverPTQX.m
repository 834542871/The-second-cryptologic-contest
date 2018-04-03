function TT2=RecoverPTQX()
global N;
Ar=170.3963;
% N=512;          %设定取样数
pix=0.00465;      %设定CCD像素间隔
L=N*pix;         %CCD宽度 L=4.76;
z0=1000;         % 衍射距离 mm(可以根据需要修改)
h=0.532e-3;       %光波长 mm(可以根据需要修改)可见光的波长范围780～390nm，波长=速度/频率
k=2*pi/h;         %波数
L0=sqrt(h*z0*N); %FFT计算时同时满足振幅及相位取样条件的物光场宽度
I1=imread('I11.bmp'); 
I2=imread('I2.bmp'); 
I3=imread('I3.bmp'); 
I4=imread('I4.bmp'); 
%% 利用4幅全息图获取到达CCD的物光复振幅
I1=double(I1);
I2=double(I2);
I3=double(I3);
I4=double(I4);
% U=((I4)+i*(I1))/4/Ar;%测试缺少一个的情况下到达CCD的共轭物光复振幅
U=((I4-I2)+i*(I1-I3))/4/Ar;%到达CCD的共轭物光复振幅
% figure(10);imagesc(abs(U));colormap(gray);axis equal;axis tight;title('重建到达CCD的物光场振幅');

%% ---------------菲涅耳衍射的D-IFFT计算起始
n=1:N;
x=-L0/2+L0/N*(n-1);                     
y=x;
[yy,xx] = meshgrid(y,x); 
Fresnel=exp(i*k/2/z0*(xx.^2+yy.^2))*exp(i*k*z0)/(i*h*z0);
Hf= fft2(Fresnel,N,N);%衍射传递函数
Hf=fftshift(Hf);
U=fft2(U,N,N);
Uf=ifft2(U./Hf,N,N);
T=L/N;
Uf=Uf*T*T;      %二维离散变换量值补偿
Uh=[0:N-1]-N/2;Vh=[0:N-1]-N/2;   
[mh,nh]=meshgrid(Uh,Vh);
T=L0/N;        % 物光场像素间距 mm;
% figure(11),imshow(abs(Uf),[]);
diff=filter2(fspecial('average',3),abs(Uf));
aaa=abs(diff);
Imax=max(max(aaa));
Uf1=uint8(aaa./Imax*255);%变换为极大值255的整型数
imwrite(Uf1,'Uf2.bmp','bmp'); 
TT2=Uf1;
% TT2=Clearer1(Uf1);
imwrite(TT2,'PTY.bmp');
