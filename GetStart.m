function [ B0 ] = GetStart( p, x, y )

    r=10;
    pts=100000;
    
    %all test betas
%     B=normrnd(0,r,[pts, p]);
    B=random('unif',-r,r,pts,p);
%     B(:,p)= mean(y);

    E=zeros(pts,1);
    for i=1:pts
        E(i)=Error_Function(x, y, B(i,:));
    end
    
    MinE = find( E==min(E) ); MinE=MinE(1);
    
    B0 = B(MinE,:);
    
end

