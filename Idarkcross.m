function Jdark = Idarkcross( I )
opts.tol = 1e-6; 
    opts.max_iter = 1000;
    opts.rho = 1.2;
    opts.mu = 1e-3;
    opts.max_mu = 1e10;
    opts.DEBUG = 0;
    gamma=0.5;
    k=80;
    [p1,p2,~]=size(I);
    %% Image expansion
    Ir=I(:,:,1);Ig=I(:,:,2);Ib=I(:,:,3);
    Irr=zeros(p1+2,p2+2);Igg=zeros(p1+2,p2+2);Ibb=zeros(p1+2,p2+2);
    Irr(2:p1+1,2:p2+1)=Ir;Igg(2:p1+1,2:p2+1)=Ig;Ibb(2:p1+1,2:p2+1)=Ib;
    %% Remove p pixels
    p =ceil( 0.3* p1* p2 );
    [H L col omega] = myRandsample(p1, p2, p);
    I=zeros(p1,p2);
    for i=1:p
            a=H(i);b=L(i);
            Rmin=min(min(min(min(Irr(a+1,b+1),Irr(a,b+1)),Irr(a+2,b+1)),Irr(a+1,b)),Irr(a+1,b+2));
            Gmin=min(min(min(min(Igg(a+1,b+1),Igg(a,b+1)),Igg(a+2,b+1)),Igg(a+1,b)),Igg(a+1,b+2));
            Bmin=min(min(min(min(Ibb(a+1,b+1),Ibb(a,b+1)),Ibb(a+2,b+1)),Ibb(a+1,b)),Ibb(a+1,b+2));
            I(a,b) = min(min(Rmin,Gmin),Bmin);
    end
    %figure(3); imshow(I);
    [Jdark,obj,err,iter] = lrmc(I,omega, opts);

end