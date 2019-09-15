function [bestin,bestfit]=mode()
%main program
%runing program

tic
load DATA;
data=getData();
%setting the parameters of GA

popsize = 50; %popzize of the population
cl = 9;  %chromosome length Ⱦɫ�峤��
pc = 0.9; %crossover probability �������
pm = 0.1; %mutation probability
Gmax = 100  ; %maximum generation
m=6;

%Initialization of the population ���� popsize cl�������Ⱥ
% fprintf(1,'pop = rand(popsize,cl):\n');
pop = rand(popsize,cl);%
pop=signx(pop,m);
% fprintf(1,'pop./repmat(sum(pop,2),1,cl)');
pop = pop./repmat(sum(pop,2),1,cl);

bestfit = 0;  
bestin = [];

for g=1:Gmax
    
    %crossover
% %     fprintf(1,'pop_cross = crossover(pop,popsize,pc):\n');

    pop_cross = crossover(pop,popsize,pc);
    
    %mutation
%     fprintf(1,'pop_mutation = mutation(pop,pm,popsize,cl);:\n');
    pop_mutation = mutation(pop,pm,popsize,cl);
    
%     %return and risk for the individuals
%     fprintf(1,'newpop:\n');
    %    newpop = [pop;pop_cross;pop_mutation]
    %
    %        RP = newpop*fuzzyret;
    %        M = (RP(:,1)+RP(:,2))/2+(RP(:,4)-RP(:,3))/6;
    %        V = ((RP(:,2)-RP(:,1))/2+(RP(:,3)+RP(:,4))/6).^2+1/18*RP(:,3).^2;
    %
    %        %objective value
    %        obj = exp(0.5*M+0.5*V)
    
    newpop = [pop;pop_cross;pop_mutation];
    RP = newpop*data.asset;
    p1x=p1(newpop);
    M = (RP(:,1)+RP(:,2))/2+(RP(:,4)-RP(:,3))/6;
    p2x=p2(M);
    p3x=p3_Emax(newpop);
    %     objective value
    obj = exp(ERn(newpop)-100000*p1x+p2x-p3x);
    %    saving the best solution
    [bestfit,bestin] = elite(newpop,obj,bestfit,bestin);
    
    %selection
    pop = selection(obj,newpop,popsize);
%     popsize=popsize*2;
    fprintf(1,'��:%d �����\n',g);
    fprintf(1,'time:%f\n',toc);
end
fprintf(1,'optimal solution:\n');
fprintf(1,'%.4f  %.4f  %.4f  %.4f\n',bestin);
fprintf(1,'objective value: %f\n',log(bestfit));
fprintf(1,'time:%f\n',toc);