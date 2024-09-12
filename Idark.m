function Jdark = Idark( I )
% output： Jdark = min(min(r),min(g),min(b));
Wnd = 30;
Ir = I(:,:,1);
Ig = I(:,:,2);
Ib = I(:,:,3);
[p1,p2,~]=size(I);
    opts.tol = 1e-6; 
    opts.max_iter = 1000;
    opts.rho = 1.2;
    opts.mu = 1e-3;
    opts.max_mu = 1e10;
    opts.DEBUG = 0;
    gamma=0.5;
    k=80;
%去除p个像素点
    p =ceil( 0.5* p1* p2 );
    [H L col omega] = myRandsample(p1, p2, p);
    I=zeros(p1,p2);
    

%% 图像拓展
[m,n,~] = size(I);
Irr = zeros(m+Wnd-1, n+Wnd-1); 
Irr((Wnd-1)/2 : m+(Wnd-1)/2-1 , (Wnd-1)/2 : n+(Wnd-1)/2-1 ) = Ir;
Igg = zeros(m+Wnd-1, n+Wnd-1); 
Igg((Wnd-1)/2 : m+(Wnd-1)/2-1 , (Wnd-1)/2 : n+(Wnd-1)/2-1 ) = Ig;
Ibb = zeros(m+Wnd-1, n+Wnd-1); 
Ibb((Wnd-1)/2 : m+(Wnd-1)/2-1, (Wnd-1)/2 : n+(Wnd-1)/2-1 ) = Ib;
%% 暗通道
for i=1:p
        a=H(i);b=L(i);
        Rmin = min(min ( Irr(a:a+Wnd-1, b:b+Wnd-1) ));
        Gmin = min(min ( Igg(a:a+Wnd-1, b:b+Wnd-1) ));
        Bmin = min(min ( Ibb(a:a+Wnd-1, b:b+Wnd-1) ));
        Jdark(a,b) = min(min(Rmin,Gmin),Bmin);
    
end

 [Jdark,obj,err,iter] = lrmc(Jdark,omega, opts);
%  [Jdark,obj,err,iter] = lrmc11(Jdark,omega, k, gamma);
%  [Jdark,obj,err,iter] = lrmc_Tspn(Jdark,omega, k, gamma);
end