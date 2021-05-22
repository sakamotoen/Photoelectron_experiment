%光电子综合实验第四次实验的拟合程序



clc;
close all;
clear;
%% 程序开始
%泵浦功率6个（增大）
x1 = [70 100 150 200 250 500];

%输出功率（泵浦增大）
Pout1 = [16.2 77.1 175.3 309 417 991];

%泵浦功率12个（减小）
x2 = [70 80 90 100 150 200 250 300 350 400 450 500];

%输出功率（泵浦减小）
Pout2 = [16.05 43.7 59.9 76.3 194.7 318 446 544 695 791 890 991];


%光谱数据
spec_100_con = csvread('100mW连续光.csv',34,0);
WL_100_con = spec_100_con(:,1);
Pwr_100_con = spec_100_con(:,2);

spec_100_mode = csvread('100mW锁模.csv',34,0);
WL_100_mode = spec_100_mode(:,1);
Pwr_100_mode = spec_100_mode(:,2);

spec_200_arr = csvread('200mW脉冲序列.csv',6000,0);
WL_200_arr = spec_200_arr(:,4);
Pwr_200_arr = spec_200_arr(:,5);

spec_200_mode = csvread('200稳定锁模.csv',34,0);
WL_200_mode = spec_200_mode(:,1);
Pwr_200_mode = spec_200_mode(:,2);

%% 开始拟合
%最小二乘法拟合增大
p1 = polyfit(x1,Pout1,1);
y1 = p1(1)*x1+p1(2);                                                %列出最终多项式
%最小二乘法拟合减小
p2 = polyfit(x2,Pout2,1);
y2 = p2(1)*x2+p2(2);
%% 绘图
figure;
plot(x1,Pout1,'-s');
hold on;
plot(x2,Pout2,'-d');
xlabel('Pp(mW)','fontsize',14);
ylabel('输出功率(uW)','fontsize',14);
axis([0,600,-50,1200]);
legend('泵浦增大','泵浦减小');

figure;
plot(x1,y1,'-s');
hold on;
plot(x2,y2,'-d');
xlabel('Pp(mW)','fontsize',14);
ylabel('输出功率(uW)','fontsize',14);
axis([0,600,-50,1200]);
legend('泵浦增大','泵浦减小');

figure;
plot(WL_100_con,Pwr_100_con);
xlabel('WL(nm)','fontsize',14);
ylabel('Pwr','fontsize',14);

figure;
plot(WL_100_mode,Pwr_100_mode);
xlabel('WL(nm)','fontsize',14);
ylabel('Pwr','fontsize',14);

figure;
plot(WL_200_arr,Pwr_200_arr);
xlabel('WL(nm)','fontsize',14);
ylabel('Pwr','fontsize',14);

figure;
plot(WL_200_mode,Pwr_200_mode);
xlabel('WL(nm)','fontsize',14);
ylabel('Pwr','fontsize',14);