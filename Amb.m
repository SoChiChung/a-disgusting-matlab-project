function Amb= Amb(X)
%不确定性
% X为模糊数 【a,b,alpha,beta】
a=X(1);
b=X(2);
alpha=X(3);
beta=X(4);

Amb=(b-a)/2+(alpha+beta)/6;
end

