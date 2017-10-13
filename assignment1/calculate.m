function [est_std , CI_neg , CI_pos ] = calculate(sample_value, sample)

sample_mean = mean(sample_value); % Xbar
sample_std = sqrt((sample/(sample-1))*(mean(sample_value.^2)-sample_mean^2));
est_std = sqrt((sample_std^2)/sample);

CI_neg = sample_mean - 1.96 * est_std;
CI_pos = sample_mean + 1.96 * est_std;

end