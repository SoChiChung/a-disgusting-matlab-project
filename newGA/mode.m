function [bestin,bestfit]=mode(r0)
%main program
%runing program



data=getData();
%setting the parameters of GA

popsize = 50; %popzize of the population
cl = 9;  %chromosome length 染色体长度
pc = 0.9; %crossover probability 交叉概率
pm = 0.1; %mutation probability
Gmax = 500  ; %maximum generation
m=6;

%Initialization of the population 生成 popsize cl的随机种群
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
    newpop=signx(newpop,m);
    RP = newpop*data.asset;
    p1x=p1(newpop);
    M = (RP(:,1)+RP(:,2))/2+(RP(:,4)-RP(:,3))/6;
    p2x=p2(M);
%     p3x=p3_Emax(newpop,var0);
    p3x=E(newpop)-(newpop*data.ci')-r0;
    %     objective value
    obj = exp(p3x-VarLowRp2(newpop)-100000*(p1x+p2x));
    
    %    saving the best solution
    [bestfit,bestin] = elite(newpop,obj,bestfit,bestin);
    
    %selection
    pop = selection(obj,newpop,popsize);
% popsize=popsize*2;
end
fprintf(1,'optimal solution:\n');
fprintf(1,'%.4f  %.4f  %.4f  %.4f\n',bestin);
