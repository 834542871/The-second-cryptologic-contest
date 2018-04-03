clear all;close all;clc;
[y,fs]=wavread('ImportantWord.wav',[6980000,8028575]);%512图片大小所需音频,1048576
% [y,fs]=wavread('ImportantWord.wav',[100000,362143]);%256图片大小所需音频
sound(y,fs);%播放截取的原始的音频
global maxz;
sample = calsample(y,fs);%将双声道编程单声道并且频率变为最低11025,wav最低采样频率为11025HZ
fs=fs/(fs/11025);
z1=reshape(sample,512,512);%变成512*512图片的大小
% z1=reshape(sample,256,256);%变成256*256图片的大小
maxz=max(max(abs(z1)));
z2=z1/maxz;
% 归一化
z3=(z2+1.0)/2;
figure (1),imshow(z1);title('-1-1音频图片');%显示原始音频图片
figure (2),imshow(z3);title('0-1音频图片');%显示音频图片
imwrite(z3,'YPP1.bmp','bmp');%将图片保存为bmp格式
% imwrite(z1,'YPP2.bmp','bmp');%将图片保存为bmp格式和z1对比，为了看-1到0之间的数据怎么处理
%%验证恢复出来的效果
% z4=(z3*2-1.0)*maxz;%为了验证能不能恢复出来
% sample1=z3(:);%将图片转化为向量
% sound(sample1,fs);%播放图片音频
