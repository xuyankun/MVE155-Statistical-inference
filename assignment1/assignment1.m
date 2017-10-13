%% Clean Environment
clc
clear
close all

%% load dataset
txt = importdata('families.txt');  
data = txt.data;

%% initial setting 
pop = length(data(:,1));
size = 500;
sample = 5;

male_prop = zeros(5,1);
std_male = zeros(5,1);

%% question a-i

for i = 1:sample
    sample_male = randsample(data(:,1),size);
    num = length(find(sample_male == 2));
    male_prop(i) = (num / size)*100; % change unit to precentage(*100%)
end
[male_est_std ,CI_male_neg, CI_male_pos ]= calculate(male_prop, sample);

fprintf('estmated standard error is: %.3f\n',male_est_std);
fprintf('0.95CI for male-headed family prop is: (%.2f%% , %.2f%%)\n\n',...
        CI_male_neg, CI_male_pos);
    
 %% question a-ii
 ave_num = zeros(5,1);
 for i = 1: sample
     sample_famnum = randsample(data(:,2),size);
     ave_num(i) = mean(sample_famnum);
 end
 
[ave_est_std ,CI_ave_neg, CI_ave_pos ]= calculate(ave_num, sample);
fprintf('estmated standard error is: %.3f\n',ave_est_std);
fprintf('0.95CI for average family number is: (%.2f , %.2f)\n\n',...
        CI_ave_neg, CI_ave_pos);
    
 %% question a-iii
 edu_prop = zeros(5,1);
 for i = 1: sample
     sample_edu = randsample(data(:,6),size);
     edu_ba = length(find(sample_edu >=43 ));
     edu_prop(i) = (edu_ba/size)*100;
 end
    [edu_est_std ,CI_edu_neg, CI_edu_pos ]= calculate(edu_prop, sample);
fprintf('estmated standard error is: %.3f\n',edu_est_std);
fprintf('0.95CI for housholds receive at least BS edu prop is:(%.2f%% , %.2f%%)\n\n',...
        CI_edu_neg, CI_edu_pos);
    
 %% question b i
 sample_b = 100;
 size_b = 400;
 ave_edu = zeros(sample_b,1);
 std_edu = zeros(sample_b,1);
 sample_aedu = zeros(sample_b,400);
 for i = 1:sample_b
     sample_aedu(i,:) = randsample(data(:,6),size_b);
     ave_edu(i) = mean(sample_aedu(i,1:400));
     std_edu(i) = std(sample_aedu(i,:));
 end
  
 %% question b ii
 mean_ave_edu = mean(ave_edu);
 std_ave_edu = std(ave_edu);
 fprintf('400sample-edu: the average is %.2f , standard deviation is %.2f\n',...
     mean_ave_edu, std_ave_edu);
 figure(1)
 hist(ave_edu,7);
 hold on
 
 %% question b iii
 
figure(2)
yyaxis left
hist(ave_edu,7);
ylim([0 35])
ylabel('Numbers');

yyaxis right
normplot(ave_edu);
ylim([-3 3]);
    
 %% question b iv
 sample_mean = zeros(100,1);
 sample_std = zeros(100,1);
 est_std = zeros(100,1);
 for i = 1:100
    sample_mean(i) = mean(sample_aedu(i,:));
    sample_std(i) = sqrt((size_b/(size_b-1))*(mean(sample_aedu(i,:).^2)...
        -sample_mean(i)^2));
    est_std(i) = sqrt(((sample_std(i)^2)/size_b)*(1-size_b/pop));
 end
 
%  pop_std = std_edu;
 CI_pop_neg = zeros(sample_b,1);
 CI_pop_pos = zeros(sample_b,1);
 for i= 1 : sample_b
     CI_pop_neg(i) =  sample_mean(i) - 1.96 * est_std(i);
     CI_pop_pos(i) =  sample_mean(i) + 1.96 * est_std(i);
 end
 CI_pop = [ CI_pop_neg CI_pop_pos]; 
 
 %% question b v
 size_b2 = 100;
 ave_edu2 = zeros(sample_b,1);
 std_edu2 = zeros(sample_b,1);
 for i = 1:sample_b
     sample_aedu2 = randsample(data(:,6),size_b2);
     ave_edu2(i) = mean(sample_aedu2);
     std_edu2(i) = std(sample_aedu2);
 end
 mean_ave_edu2 = mean(ave_edu2);
 std_ave_edu2 = std(ave_edu2);
 fprintf('100sample-edu: the average is %.2f , standard deviation is %.2f\n\n',...
     mean_ave_edu2, std_ave_edu2);
 
 figure(3)
%  yyaxis left
%  hist(ave_edu,7);
%  ylim([0 35])
%  yyaxis right
 hist(ave_edu2,7);
 ylim([0 35])
 
 %% question c i
 sample_c = 1;
 size_c = 400;
 
 index_nor = find(data(:,5) == 1);
 in_north1 = randsample(data(index_nor,4),size_c);
 
 index_east = find(data(:,5) == 2);
 in_east2 = randsample(data(index_east,4),size_c);
 
 index_sou = find(data(:,5) == 3);
 in_south3 = randsample(data(index_sou,4),size_c);
 
 index_west = find(data(:,5) == 4);
 in_west4 = randsample(data(index_west,4),size_c);
 
 figure(4)
 boxplot([in_north1,in_east2,in_south3,in_west4] )
 title('Incomes of four regions')
 xlabel('Region')
 ylabel('Incomes') 
 
 %% question c ii
 size_c2 = 300;
 inc = randsample(data(:,4),size_c2);
 ave_inc = mean(inc);
 std_inc = std(inc);
 CI_inc_neg = round(ave_inc - 1.96 * std_inc);
 CI_inc_pos = round(ave_inc + 1.96 * std_inc);
 CI_inc = [CI_inc_neg CI_inc_pos];
 fprintf('300sample-inc: the average is %.2f , standard deviation is %.2f\n\n',...
     ave_inc, std_inc);
 fprintf('95%%CI for average incomes is:(%d , %d)\n\n',...
        CI_inc_neg, CI_inc_pos);
 
 %% proportion allocation
 
 w = zeros(3,1);
 n_prop = zeros(3,1);
 n_opt = zeros(3,1);
 mean_prop = zeros(3,1);
 mean_opt = zeros(3,1);
 std_prop = zeros(3,1);
 std_opt = zeros(3,1);
 std_opt_new = zeros(3,1);
 
 for i = 1:3
     find_index = find(data(:,1) == i );
     w(i) = length(find_index) / pop;
     n_prop(i) = round(size_c2 * w(i));
     sample_prop = randsample(data(find_index,4),n_prop(i));
     mean_prop(i) = mean(sample_prop);
     std_prop(i) = std(sample_prop);
     
     std_opt(i) = std(data(find_index,4));
 end
  
 mean_str_prop = sum(w.*mean_prop);
 est_std_prop = sqrt(sum(w.*std_prop.^2)/size_c2);
 
 CI_prop_neg = round(mean_str_prop - 1.96* est_std_prop);
 CI_prop_pos = round(mean_str_prop + 1.96* est_std_prop);
 CI_prop = [ CI_prop_neg  CI_prop_pos]; 
 
 fprintf('propotional allocation:standard error is %d\n95%%CI is:(%d , %d)\n\n',...
     round(est_std_prop), CI_prop(1,1),CI_prop(1,2) );
 %% optimal allocation
 std_bar = sum(w.* std_opt);
     
 for j = 1:3
        find_index = find(data(:,1) == j );
        n_opt(j) = round( size_c2 * w(j) * std_opt(j) / std_bar);
        sample_opt = randsample(data(find_index,4),n_prop(j));
        mean_opt(j) = mean(sample_opt);
        std_opt_new(j) = std(sample_opt);
 end  
 
 mean_str_opt = sum(w.*mean_opt);
 est_std_opt = sqrt((sum(w.*std_opt_new))^2/size_c2 );
 
 CI_opt_neg = round(mean_str_opt - 1.96* est_std_opt);
 CI_opt_pos = round(mean_str_opt + 1.96* est_std_opt);
 
 CI_opt = [ CI_opt_neg  CI_opt_pos];
 fprintf('optimal allocation:standard error is %d\n95%%CI is:(%d , %d)\n\n',...
     round(est_std_opt), CI_opt(1,1),CI_opt(1,2) );
 
 
    