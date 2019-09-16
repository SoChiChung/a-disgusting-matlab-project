function [bestins,E_max] = main()
%MAIN 多次循环递归函数
% bestins 每次最优解的集合 E_max 对应的期望值
tic;
var0=0.001:0.001:0.005;%风险
[~,col]=size(var0);
for i=1:col
    fprintf(1,'正在进行var0为 %f 的求解 请稍等......\n',var0(i));
    start=tic;
    [bestin]=mode(var0(i));
    E_max(i,:)=E(bestin);
    bestins(i,:)=bestin;
    fprintf(1,'i为%d 的投资比例为：\n',i);
    fprintf(1,'%.4f  %.4f  %.4f  %.4f\n',bestin);
    END=toc(start);
    fprintf(1,'本次用时 %f \n',END);
end

plot(var0,E_max);
fprintf(1,'time:%f\n',toc);
end

