%% Clean Environment
clc
clear
close all

%% load dataset
data = importdata('ears.txt'); 
data = (data.data);
%% a
figure
boxplot([data(:,1),data(:,2)],{'breast-fed','bottle-fed'})

figure
h1 = qqplot(data(:,1));
set(h1(2),'Visible','off')
set(h1(3),'Visible','off')
set(h1(1),'Color','g')
hold on
h2 = qqplot(data(:,2));
set(h2(2),'Visible','off')
set(h2(3),'Visible','off')
set(h2(1),'linestyle','--','LineWidth',1.5)

figure 
plot(sort(data(:,1)) ,sort(data(:,2)),'.','LineWidth',2)
xlabel('breast-fed')
ylabel('bottle-fed')
%% b
% signrank
[p2,h2] = signrank(data(:,1),data(:,2)) % 2-sided P-value



