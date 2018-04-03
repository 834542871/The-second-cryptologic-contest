
%% ---------------------------------图像隐藏开始
N=512;
Yuantu=imread('YPP1.bmp');%读入一个载体图像，256位的
figure(1); imshow(Yuantu,[]);title('载体图');
I1=imread('I1.bmp');%读入一个载体图像，256位的
figure(2); imshow(I1,[]);title('水印图');
Hyt=imresize(Yuantu,N/512);%将载体图像的大小，调整到和嵌入的图像一样大小，便于嵌入隐藏
            Hyt1=fft2(Hyt,N,N);
            I11=fft2(I1,N,N);
            I11=fftshift(I11);%物光场频谱
            WaterPic=I11*0.01+Hyt1;%将嵌入的全息图*系数，有利于隐藏，不影响载体的显示
            WaterPic1=ifft2(WaterPic,N,N);
            WaterPic1=uint8(WaterPic1);
%             psnr=psnr(Hyt,WaterPic1,N,N);
figure(3);imshow(WaterPic1,[]);title('含水印载体图')
imwrite(WaterPic1,'WaterPic.bmp','bmp'); 
%---------------------------------图像隐藏结束
%% 置乱
ZL=arnold('WaterPic.bmp',4,0);
imwrite(ZL,'ZLT.bmp','bmp');
figure (4),imshow(ZL);title('置乱后的含水印载体图');
%% 恢复置乱
HFT=arnold('ZLT.bmp',4,1);
imwrite(HFT,'HFT.bmp','bmp');
figure (5),imshow(HFT);title('恢复置乱后的含水印载体图');
%% ---------------------------图像的提取开始
HFT1=fft2(HFT);
Hyt12=HFT1-I11*0.01;
Hyt12=fftshift(Hyt12);
Hyt12=ifft2(Hyt12,N,N);
Hyt121=Hyt12;
Hyt121=uint8(abs(Hyt121));
imwrite(Hyt121,'Hyt1.bmp','bmp');
figure(6); imshow(Hyt121,[]);title('提取的音频图');
I1=(HFT1-Hyt1)/0.01;
I12=fftshift(I1);
I12=ifft2(I12,N,N);
I12=uint8(I12);
imwrite(I12,'I11.bmp','bmp');
figure(7); imshow(I12,[]);title('提取的水印图');

%---------------------------------图像提取结束
%% 恢复出音频
Y2=double(WaterPic1);
sample1=Y2(:);
maxs=max(sample1);
sample2=sample1/maxs;
% sample3=mapminmax(sample2);
maxz=0.9194;
sample3=(sample2*2.0-1.0)*maxz;
sound(sample3,11025);
Y3=reshape(sample3,N,N);
figure (8),imshow(Y3);title('恢复-1-1音频图片');%显示原始音频图片