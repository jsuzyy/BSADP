clc
clear all
Para.NIoT    = 100;
Para.NSP     = Para.NIoT;
Para.Xmin    = 0;
Para.Xmax    = 1000;
Para.Ymin    = 0;
Para.Ymax    = 1000;
Para.p       = 0.1;
Para.K       = 10;
Para.rho     = 1e-6;
Para.sigma   = 1e-28;
Para.B       = 1e6;
Para.ph      = 1000;
Para.evaluations = 0;
Para.maxEvaluations = 100000;
Para.EFlag=0;%If Para.EFlag==0, ECF-I; otherwise, ECF-II.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for n=1:1% height
    Para.Hmin    = 100*n;
    Para.Hmax    = 100*n;
    for k=1:7
        Para.NIoT    = 100*k;
        Para.NSP     = Para.NIoT;
        Para.D       = load(['D_',num2str(Para.NIoT),'.dat']);
        for i=1:30
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%555
            C = 1;
            IoTPosition = load(['IoTPosition_',num2str(Para.NIoT),'.dat']);
            while C~=0
                UAVPosition = [Para.Xmin+(Para.Xmax-Para.Xmin)*rand(Para.NSP,1),Para.Ymin+(Para.Ymax-Para.Ymin)*rand(Para.NSP,1),Para.Hmin+(Para.Hmax-Para.Hmin)*rand(Para.NSP,1)];
                if Para.EFlag==0
                  [Fbest,C] = Fitness(UAVPosition,IoTPosition,Para);
                else
                  [Fbest,C] = Fitness2(UAVPosition,IoTPosition,Para);
                end
            end
            old=UAVPosition;
            old=old(randperm(size(old,1)),:);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            [EBSA_BestCost,EBSA_BestValue(k,i,n)]=EBSA_ALG(UAVPosition,old,Para);
            disp(['Iteration_BSA: ',num2str(n),num2str(k),num2str(i),'   EBSA_Fmin= ',num2str(mean(EBSA_BestValue(k,:,n)),15)]);
        end
    end
end
