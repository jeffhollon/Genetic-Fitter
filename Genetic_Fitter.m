function [ BETA ] = Genetic_Fitter( x, y, Deg )
    rng shuffle; 
    
    p = Deg+1;
    
    x=x(:);  y=y(:);  n=length(x);
    
    Children=100;
    MaxIts=10000;
    Radius=100;
    
    BETA=GetStart(p,x,y);
    
    A=ones(n,p);
    for Col=2:p
        A(:,Col) = x.^(Col-1);
    end
    
    ERROR(1) = Error_Function(x,y,BETA);
    
    scatter(x,y,'k.');hold on;
    plot(x,A*BETA','r');hold off   
    
    while(1)%for It=1:MaxIts %Begin Genetic Iterations   
        B(1,:)=BETA; E(1)=Error_Function(x,y,BETA);
        for j=2:Children
%             B(j,:) = BETA + normrnd(0,Radius,size(BETA));
            B(j,:) = BETA + random('unif',-Radius,Radius, 1, p);
            
%                 subplot(1,3,1)
%                 scatter3(B(j,1),B(j,2),B(j,3),'r.')
                
            E(j) = Error_Function(x,y,B(j,:));
        end
        
        LocBest = find( E==min(E) ); LocBest=LocBest(1);
        BETA = B(LocBest,:)
        ERROR(2)=E(LocBest);
        
        if abs(ERROR(2)-ERROR(1))<=10^-5
            Radius = 0.99*Radius;
        else
            Radius = 1.01*Radius;
        end
                    ERROR(1)=ERROR(2);
       
            scatter(x,y,'k.');hold on;
            plot(x,A*BETA','r');hold off
            title('Data + Best Fit')
            xlabel('x'); ylabel('y')
       
        pause(0.01)
        
        
%         if Radius<=10^-3
%             break
%         end
        
    end %End Genetic Iterations
    
%     
% 
%     subplot(1,3,1);
%         title('Parameter Estimates')
%         xlabel('B_0'); ylabel('B_1'); zlabel('B_2')
%         scatter3(BETA(1),BETA(2),BETA(3),'k.'); 
%     subplot(1,3,2);
%         scatter(x,y,'k.');hold on;
%         plot(x,A*BETA','r');hold off
%         title('Data + Best Fit')
%         xlabel('x'); ylabel('y')
%     subplot(1,3,3);
%         title('Error by Iteration')
%         plot(ERROR,'k');
%         xlabel('Iteration'); ylabel('Log(MSE)')
    BETA
end

