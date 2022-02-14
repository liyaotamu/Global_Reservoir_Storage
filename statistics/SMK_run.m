% This code is used for calculate the seasonal trend by MK method.
% author: Yao Li
% last updated: 01/01/2022


clc;
clear;
addpath('D:\Documents\Communication\LiYao\MK');
%% data importing 
data=readtable('D:\Documents\Communication\LiYao\data\GRS_1999-2018_v1.2_NS.xlsx');
stationID = data.Properties.VariableNames;
data_total = data{:,:};

%% input data includes 3 columns, the 1st column is Year, the 2nd column is Month, 
% the 3rd coulumn is your interest (i.e., water storeage)
datain(:,1:2)=data_total(:,1:2);% for sktt

for i=3:size(data_total,2) % for sktt
    datain(:,3)=data_total(:,i); % for sktt
%
[taubsea tausea Sens h sig sigAdj Zs Zmod Ss Sigmas CIlower CIupper] = sktt(datain, 0.05, 0,1);
dpsktt(1,i)=h(1,1); %% If it is zero- insignificant trend, if it is 1-- significant trend
dpsktt(2,i)=Sens(1,1); %% tHis will give slope
dpsktt(3,i)=sig(1,1); %% it will give you p-value
dpsktt(4,i)=CIlower(1,1);%% it will give you lower confidence interval for sen's slope 
dpsktt(5,i)=CIupper(1,1);%% it will give you upper confidence interval for sen's slope 


%
close all
end