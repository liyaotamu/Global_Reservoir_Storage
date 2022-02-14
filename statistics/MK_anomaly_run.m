% This code is used for calculate the trend by MK method.
% author: Yao Li
% last updated: 01/01/2022


clc;
clear;
addpath('D:\Documents\Communication\LiYao\MK');
%% data importing 
data=readtable('D:\Documents\Communication\LiYao\data\GRS_1999-2018_v1.2_NS.xlsx');
stationID = data.Properties.VariableNames;
data_total = data{:,:};

%% calc the muti-year average of data
data_main = data_total(:,2:end);
[total_months,samples] = size(data_main);
nyears = total_months/12;
data_main_3D = reshape(data_main,12,nyears,samples);
data_main_CMG = squeeze(nanmean(data_main_3D,2));
data_main_mean = repmat(data_main_CMG,nyears,1,1);
data_anomaly = data_main-data_main_mean;

%% calc the trend with MK method

for i=1:size(data_anomaly,2) % for ktaub anomaly
    
%   15 month moving average of anomaly, abondon the first and end 7 months   
    data_ano_mov = [data_total(:,1) movmean(data_anomaly(:,i),15)];
    data_ano_mov(1:7,:)=[];
    data_ano_mov(end-6:end,:)=[];
%   output the moving averaged anomaly data    
    data_anomaly_mov(:,1)= data_ano_mov(:,1);
    data_anomaly_mov(:,i+1)= data_ano_mov(:,2);
%   input data includes 2 columns-- 1 is time(i.e., 2010.0833) and 2nd is value of your interest (i.e., storage values)
    datain = data_ano_mov;

% % 
[taub tau h sig Z S sigma sen n senplot CIlower CIupper D Dall C3 nsigma] =ktaub(datain, 0.05,0);
% 
dp(1,i)=h(1,1); %% If it is zero- insignificant trend, if it is 1-- significant trend
dp(2,i)=sen(1,1); %% tHis will give slope
% dp(1,3)=sen(1,1)*no of years; %% This will give total change
dp(3,i)=sig(1,1); %% it will give you p-value
dp(4,i)=CIlower(1,1);%% it will give you lower confidence interval for sen's slope 
dp(5,i)=CIupper(1,1);%% it will give you upper confidence interval for sen's slope 
%
close all
end