function [bestins,E_max] = main()
%MAIN ���ѭ���ݹ麯��
% bestins ÿ�����Ž�ļ��� E_max ��Ӧ������ֵ
tic;
var0=0.001:0.001:0.005;%����
[~,col]=size(var0);
for i=1:col
    fprintf(1,'���ڽ���var0Ϊ %f ����� ���Ե�......\n',var0(i));
    start=tic;
    [bestin]=mode(var0(i));
    E_max(i,:)=E(bestin);
    bestins(i,:)=bestin;
    fprintf(1,'iΪ%d ��Ͷ�ʱ���Ϊ��\n',i);
    fprintf(1,'%.4f  %.4f  %.4f  %.4f\n',bestin);
    END=toc(start);
    fprintf(1,'������ʱ %f \n',END);
end

plot(var0,E_max);
fprintf(1,'time:%f\n',toc);
end
