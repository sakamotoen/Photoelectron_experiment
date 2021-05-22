%%
clear;
close all;
clc;

%% 自动弹出提示框读取图像
[filename filepath] = uigetfile('.jpg', '输入一个需要识别的图像');
file = strcat(filepath, filename);
img = imread(file);
filename = filename(3:4);
figure;
imshow(img);
title('原图像');
%% 灰度处理
img1 = rgb2gray(img);    % RGB图像转灰度图像
figure;
subplot(1, 2, 1);
imshow(img1);
title('灰度图像');
subplot(1, 2, 2);
imhist(img1);
title('灰度处理后的灰度直方图');
c = [7.13,6.35,5.66,5.04,4.49];

%散射不加小孔
if filename == '不加'
    a0(1) = spec(img1,400,537,70,229,6);% 条纹2-6
    a0(2) = spec(img1,392,537,230,409,5);% 条纹2-6
    a0(3) = spec(img1,380,537,410,609,4);% 条纹2-4
    a0(4) = spec(img1,360,537,610,814,3);% 条纹2-3.
    a0(5) = spec(img1,330,537,815,1039,2);% 条纹2-2
    figure;
    plot(c,a0);
    grid on;
    xlabel('线对数(C/mm)');ylabel('对比度');
    title('对比度--线对数');
else
%散射加小孔
    a1(1) = spec(img1,400,537,70,229,-6);% 条纹2-6
    a1(2) = spec(img1,392,537,230,399,-5);% 条纹2-5
    a1(3) = spec(img1,380,537,400,589,-4);% 条纹2-4
    a1(4) = spec(img1,360,537,590,804,-3);% 条纹2-3
    a1(5) = spec(img1,330,537,805,1039,-2);% 条纹2-2
    figure;
    plot(c,a1);
    grid on;
    xlabel('线对数(C/mm)');ylabel('对比度');
    title('对比度--线对数');
end


%% 获取条纹
function[a] = spec(img1,i,j,m,n,z)
A = img1 (i:j,m:n);
% figure;
% imshow(A);
l = n-m+1;
for k = 1:l
    A_k(k) = sum(A(:,k))/l;
end
figure;
A_k = smoothdata(A_k);
plot(1:l,A_k,'LineWidth',1.5);
xlabel('空间横坐标');ylabel('列光强均值');
if z==6
    title('散射不加小孔条纹2-6的光谱图');
    elseif z==5
        title('散射不加小孔条纹2-5的光谱图');
        elseif z==4
            title('散射不加小孔条纹2-4的光谱图');
            elseif z==3
                title('散射不加小孔条纹2-3的光谱图');
                elseif z==2
                    title('散射不加小孔条纹2-2的光谱图');
                    elseif z==-6
                        title('散射加小孔条纹2-6的光谱图');
                        elseif z==-5
                            title('散射加小孔条纹2-5的光谱图');
                            elseif z==-4
                                title('散射加小孔条纹2-4的光谱图');
                                elseif z==-3
                                    title('散射加小孔条纹2-3的光谱图');
                                    elseif z==-2
                                        title('散射加小孔条纹2-2的光谱图');
end
%对比度
a = (max(A_k)-min(A_k))/(max(A_k)+min(A_k));
end