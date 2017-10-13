%% Clean Environment
clc
clear
close all

%% load data
data = importdata('barium.txt'); 
temp = data.data(:,1);
pres = data.data(:,2);
n = length(temp);
x = 1./temp;
y = log(pres);
x_bar = mean(x);
y_bar = mean(y);
sum_dx = 0;
sum_dy = 0;
sum_dxy = 0;

 for i = 1:n
     sum_dx = sum_dx + (x(i) - x_bar)^2 ;
     sum_dy = sum_dy + (y(i) - y_bar)^2 ;
     sum_dxy = sum_dxy + (x(i) - x_bar)*(y(i) - y_bar);
 end
 
s_x = sqrt(sum_dx/(n-1));
s_y = sqrt(sum_dy/(n-1));
s_xy = sum_dxy/(n-1);
r = s_xy/(s_x * s_y);

%% calculate A B
B = r * s_y / s_x
A = y_bar - B * x_bar

SSE = (n-1) * s_y^2 * (1 - r^2);
s = sqrt(SSE/(n-2));
%% calculate s_A s_B
s_A = (s*(sqrt(sum(x.^2)))) / (s_x*(sqrt(n*(n-1))))
s_B = s/(s_x * sqrt(n-1))

%% 95%CI
CI_A_neg = A - 2.042 * s_A;
CI_A_pos = A + 2.042 * s_A;
CI_A = [CI_A_neg CI_A_pos];

CI_B_neg = B - 2.042 * s_B;
CI_B_pos = B + 2.042 * s_B;
CI_B = [CI_B_neg CI_B_pos];

%% residuals
% est_y = zeros(32,1);
est_y = A + B.* x;
e = est_y - y;
figure 
plot(1./x,e,'.')
xlabel('Temperature')
ylabel('Residuals')

figure
 qqplot(e)
% normplot(e)