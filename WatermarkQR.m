
%% ---------------------------------ͼ�����ؿ�ʼ
N=512;
Yuantu=imread('YPP1.bmp');%����һ������ͼ��256λ��
figure(1); imshow(Yuantu,[]);title('����ͼ');
I1=imread('I1.bmp');%����һ������ͼ��256λ��
figure(2); imshow(I1,[]);title('ˮӡͼ');
Hyt=imresize(Yuantu,N/512);%������ͼ��Ĵ�С����������Ƕ���ͼ��һ����С������Ƕ������
            Hyt1=fft2(Hyt,N,N);
            I11=fft2(I1,N,N);
            I11=fftshift(I11);%��ⳡƵ��
            WaterPic=I11*0.01+Hyt1;%��Ƕ���ȫϢͼ*ϵ�������������أ���Ӱ���������ʾ
            WaterPic1=ifft2(WaterPic,N,N);
            WaterPic1=uint8(WaterPic1);
%             psnr=psnr(Hyt,WaterPic1,N,N);
figure(3);imshow(WaterPic1,[]);title('��ˮӡ����ͼ')
imwrite(WaterPic1,'WaterPic.bmp','bmp'); 
%---------------------------------ͼ�����ؽ���
%% ����
ZL=arnold('WaterPic.bmp',4,0);
imwrite(ZL,'ZLT.bmp','bmp');
figure (4),imshow(ZL);title('���Һ�ĺ�ˮӡ����ͼ');
%% �ָ�����
HFT=arnold('ZLT.bmp',4,1);
imwrite(HFT,'HFT.bmp','bmp');
figure (5),imshow(HFT);title('�ָ����Һ�ĺ�ˮӡ����ͼ');
%% ---------------------------ͼ�����ȡ��ʼ
HFT1=fft2(HFT);
Hyt12=HFT1-I11*0.01;
Hyt12=fftshift(Hyt12);
Hyt12=ifft2(Hyt12,N,N);
Hyt121=Hyt12;
Hyt121=uint8(abs(Hyt121));
imwrite(Hyt121,'Hyt1.bmp','bmp');
figure(6); imshow(Hyt121,[]);title('��ȡ����Ƶͼ');
I1=(HFT1-Hyt1)/0.01;
I12=fftshift(I1);
I12=ifft2(I12,N,N);
I12=uint8(I12);
imwrite(I12,'I11.bmp','bmp');
figure(7); imshow(I12,[]);title('��ȡ��ˮӡͼ');

%---------------------------------ͼ����ȡ����
%% �ָ�����Ƶ
Y2=double(WaterPic1);
sample1=Y2(:);
maxs=max(sample1);
sample2=sample1/maxs;
% sample3=mapminmax(sample2);
maxz=0.9194;
sample3=(sample2*2.0-1.0)*maxz;
sound(sample3,11025);
Y3=reshape(sample3,N,N);
figure (8),imshow(Y3);title('�ָ�-1-1��ƵͼƬ');%��ʾԭʼ��ƵͼƬ