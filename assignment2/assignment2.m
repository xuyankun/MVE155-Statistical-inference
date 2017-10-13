%% Clean Environment
clc
clear
close all

%% load dataset
data = importdata('whales.txt');  
size = length(data);
%% question a 
figure
hist(data);% Gamma distribution is reasonable
%% question b
X_bar = mean(data);
X_std = std(data);
lamda1 = X_bar / X_std^2;
alpha1 = lamda1 * X_bar;

%% question c
max_li = gamfit(data);

t2 = prod(data);
f_para1 = log(t2)/size - log(X_bar);
fun1 = @(x) log(x) + f_para1 - psi(x);
alpha2 = fzero(fun1, [0.5 3]);
lamda2 = alpha2 / X_bar;
%% question d

x = sort(data);
y1 = gampdf(x, alpha1, 1/lamda1);
y2 = gampdf(x, alpha2, 1/lamda2);

figure 
yyaxis left
hist(data);

yyaxis right
plot(x,y1,'-',x,y2,'--')
legend( 'Histogram of data','Method of moment','Method of max likelihood') 
%% e

sample = 1000;
size_n = 210;
boot1 = gamrnd(alpha1 * ones(sample,size_n), 1/lamda1 * ones(sample,size_n));

x_mean1 = zeros(sample,1);
x_std1 = zeros(sample,1);
alpha_boot1 = zeros(sample,1);
lamda_boot1 = zeros(sample,1);
for i = 1:sample
   x_mean1(i) = mean(boot1(i,:));
   x_std1(i) = std(boot1(i,:));
   alpha_boot1(i) = x_mean1(i)^2 / x_std1(i)^2;
   lamda_boot1(i) = alpha_boot1(i) / x_mean1(i);
end



alpha_bar1 = mean(alpha_boot1);
alpha_std1 = (1/(sample-1)) * sum((alpha_boot1 - alpha_bar1).^2);
lamda_bar1 = mean(lamda_boot1);
lamda_std1 = (1/(sample-1)) * sum((lamda_boot1 - lamda_bar1).^2);

%% f
boot2 = gamrnd( alpha2 * ones(sample,size_n), 1/lamda2 * ones(sample,size_n));

t2f = zeros(sample,1);
x_mean2 = zeros(sample,1);
f_para2 = zeros(sample,1);
alpha_boot2 = zeros(sample,1);
lamda_boot2 = zeros(sample,1);

for i = 1:sample
   t2f(i) = prod(boot2(i,:));
   x_mean2(i) = mean(boot2(i,:));
   f_para2(i) = log(t2f(i))/size_n - log(x_mean2(i));
   fun2 = @(x) log(x) + f_para2(i) - psi(x);
   alpha_boot2(i) = fzero(fun2, [0.1 5]);
   lamda_boot2(i) = alpha_boot2(i) / x_mean2(i);
end

alpha_bar2 = mean(alpha_boot2);
alpha_std2 = (1/(sample-1)) * sum((alpha_boot2 - alpha_bar2).^2);
lamda_bar2 = mean(lamda_boot2);
lamda_std2 = (1/(sample-1)) * sum((lamda_boot2 - lamda_bar2).^2);


figure 
histfit(alpha_boot1)
figure
histfit(alpha_boot2)


figure 
histfit(lamda_boot1)
figure
histfit(lamda_boot2)
%% g
c1_alpha = prctile(alpha_boot2, 2.5);
c2_alpha = prctile(alpha_boot2, 97.5);

CI_left_a = 2 * mean(alpha_boot2) - c2_alpha;
CI_right_a = 2 * mean(alpha_boot2) - c1_alpha;

c1_lamda = prctile(lamda_boot2, 2.5);
c2_lamda = prctile(lamda_boot2, 97.5);

CI_left_l = 2 * mean(lamda_boot2) - c2_lamda;
CI_right_l = 2 * mean(lamda_boot2) - c1_lamda;




