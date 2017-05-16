function [ BETA ] = Genetic_Fitter_Lin( x, y )
    rng shuffle; 
    
    x=x(:);  y=y(:);  n=length(x);
    
    Children=10;
    MaxIts=1000;
    Radius=100;

%     BETA=normrnd(0,100,[1,2]);
    p=2;
    BETA=GetStart(p,x,y);
    
    
    A=ones(n,p);
    for Col=2:p
        A(:,Col) = x.^(Col-1);
    end
    
    ERROR(1) = Error_Function(x,y,BETA);
    
    figure(1);set(gcf, 'Position', get(0,'Screensize'))
    subplot(1,3,1);
    scatter(BETA(1),BETA(2),'k.'); hold on
    subplot(1,3,2);
    scatter(x,y,'k.');hold on;
    plot(x,A*BETA','r');hold off
    subplot(1,3,3);
    plot(ERROR,'k');hold on

    for It=1:MaxIts %Begin Genetic Iterations

        B(1,:)=BETA; E(1)=Error_Function(x,y,BETA);
        for j=2:Children
%             B(j,:) = BETA + normrnd(0,Radius,[1 p]);
            B(j,:) = BETA + random('unif',-Radius,Radius, 1, p);
%             
%                 subplot(1,3,1)
%                 scatter(B(j,1),B(j,2),'r.')
%                 
            E(j) = Error_Function(x,y,B(j,:));
        end
        
        LocBest = find( E==min(E) ); LocBest=LocBest(1);
        BETA = B(LocBest,:);
        ERROR(It+1)=E(LocBest);
        
        if abs(ERROR(It+1)-ERROR(It))<=10^-6
            Radius = Radius/2;
        else
            Radius = 1.5*Radius;
        end
        
        subplot(1,3,1);
            title('Parameter Estimates')
            xlabel('B_0'); ylabel('B_1')
            scatter(BETA(1),BETA(2),'k.'); 
        subplot(1,3,2);
            scatter(x,y,'k.');hold on;
            plot(x,A*BETA','r');hold off
            title('Data + Best Fit')
            xlabel('x'); ylabel('y')
        subplot(1,3,3);
            title('Error by Iteration')
            plot(ERROR,'k');
            xlabel('Iteration'); ylabel('Log(MSE)')
        pause(0.01)
        
        if Radius<=10^-9
            break
        end
        
    end %End Genetic Iterations
    
end

