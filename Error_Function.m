function [ MSE ] = Error_Function( x, y, BETA )

    n=length(x); p=length(BETA);
    BETA=BETA(:);
    
    A=ones(n,p);
    
    for i=2:p
        A(:,i) = x.^(i-1);
    end

    MSE = log( (  norm( A*BETA-y)  )  );

%     MSE =  log(  norm( A*BETA-y ) + 10*norm(BETA,1) + 10*norm(BETA,2));
    
end
