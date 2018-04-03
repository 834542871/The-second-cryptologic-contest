function TT2=RecoverPTQX()
global N;
Ar=170.3963;
% N=512;          %�趨ȡ����
pix=0.00465;      %�趨CCD���ؼ��
L=N*pix;         %CCD��� L=4.76;
z0=1000;         % ������� mm(���Ը�����Ҫ�޸�)
h=0.532e-3;       %�Ⲩ�� mm(���Ը�����Ҫ�޸�)�ɼ���Ĳ�����Χ780��390nm������=�ٶ�/Ƶ��
k=2*pi/h;         %����
L0=sqrt(h*z0*N); %FFT����ʱͬʱ�����������λȡ����������ⳡ���
I1=imread('I11.bmp'); 
I2=imread('I2.bmp'); 
I3=imread('I3.bmp'); 
I4=imread('I4.bmp'); 
%% ����4��ȫϢͼ��ȡ����CCD����⸴���
I1=double(I1);
I2=double(I2);
I3=double(I3);
I4=double(I4);
% U=((I4)+i*(I1))/4/Ar;%����ȱ��һ��������µ���CCD�Ĺ�����⸴���
U=((I4-I2)+i*(I1-I3))/4/Ar;%����CCD�Ĺ�����⸴���
% figure(10);imagesc(abs(U));colormap(gray);axis equal;axis tight;title('�ؽ�����CCD����ⳡ���');

%% ---------------�����������D-IFFT������ʼ
n=1:N;
x=-L0/2+L0/N*(n-1);                     
y=x;
[yy,xx] = meshgrid(y,x); 
Fresnel=exp(i*k/2/z0*(xx.^2+yy.^2))*exp(i*k*z0)/(i*h*z0);
Hf= fft2(Fresnel,N,N);%���䴫�ݺ���
Hf=fftshift(Hf);
U=fft2(U,N,N);
Uf=ifft2(U./Hf,N,N);
T=L/N;
Uf=Uf*T*T;      %��ά��ɢ�任��ֵ����
Uh=[0:N-1]-N/2;Vh=[0:N-1]-N/2;   
[mh,nh]=meshgrid(Uh,Vh);
T=L0/N;        % ��ⳡ���ؼ�� mm;
% figure(11),imshow(abs(Uf),[]);
diff=filter2(fspecial('average',3),abs(Uf));
aaa=abs(diff);
Imax=max(max(aaa));
Uf1=uint8(aaa./Imax*255);%�任Ϊ����ֵ255��������
imwrite(Uf1,'Uf2.bmp','bmp'); 
TT2=Uf1;
% TT2=Clearer1(Uf1);
imwrite(TT2,'PTY.bmp');
