clear all;close all;clc;
[y,fs]=wavread('ImportantWord.wav',[6980000,8028575]);%512ͼƬ��С������Ƶ,1048576
% [y,fs]=wavread('ImportantWord.wav',[100000,362143]);%256ͼƬ��С������Ƶ
sound(y,fs);%���Ž�ȡ��ԭʼ����Ƶ
global maxz;
sample = calsample(y,fs);%��˫������̵���������Ƶ�ʱ�Ϊ���11025,wav��Ͳ���Ƶ��Ϊ11025HZ
fs=fs/(fs/11025);
z1=reshape(sample,512,512);%���512*512ͼƬ�Ĵ�С
% z1=reshape(sample,256,256);%���256*256ͼƬ�Ĵ�С
maxz=max(max(abs(z1)));
z2=z1/maxz;
% ��һ��
z3=(z2+1.0)/2;
figure (1),imshow(z1);title('-1-1��ƵͼƬ');%��ʾԭʼ��ƵͼƬ
figure (2),imshow(z3);title('0-1��ƵͼƬ');%��ʾ��ƵͼƬ
imwrite(z3,'YPP1.bmp','bmp');%��ͼƬ����Ϊbmp��ʽ
% imwrite(z1,'YPP2.bmp','bmp');%��ͼƬ����Ϊbmp��ʽ��z1�Աȣ�Ϊ�˿�-1��0֮���������ô����
%%��֤�ָ�������Ч��
% z4=(z3*2-1.0)*maxz;%Ϊ����֤�ܲ��ָܻ�����
% sample1=z3(:);%��ͼƬת��Ϊ����
% sound(sample1,fs);%����ͼƬ��Ƶ
