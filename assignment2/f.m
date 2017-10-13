function y = f(x)
double x;
%syms t;
%x = double(x);
y = log(x) - 0.345 - psi(x);%int( exp(-t)*t^(x-1)*log(t),t,0,inf)/...
    %int( exp(-t)*t^(x-1),t,0,inf);%gamma(x)' / gamma(x);
% y = double(y);
end
