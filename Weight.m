function w=Weight(U,V,S,p,m,n,r,lambda)
         A=U(:,1:r)';B=V(:,1:r)';
         %A=U(1:r,m);
         %B=V(1:r,n);
         W=B'*A;
        [u1 s1 v1]=svd(W);
        w=S.^(p-1);
        a=(1-diag(s1));
        w=lambda*p*a.*w;
end
