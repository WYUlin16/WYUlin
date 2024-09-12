function [deta]=lpD(s,p,lambda)

theta=lambda;

if p==1/2
   a=54^(1/3)/4;
   b=(2*theta).^(2/3);
   Fai=a.*b;
   l=length(s);
   for i=1:l
       if s(i)>Fai
           s(i)=s(i);
           c=theta./4;
           fai=acos(c.*(s(i)./3).^(-1.5));
           d=1+cos((2*pi)/3-(2*fai)/3);
           s(i)=(2/3).*s(i).*d; 
       else
           s(i)=0;
       end
   end
 deta=s;  
   
   
elseif  p==2/3
   Fai=(2/3)*(3*(2*theta).^3).^(1/4);
   [sigma]=compare(s,Fai);
   a=(27*(sigma.^2))./16;
   b=acosh(a.*(2.*theta).^(-1.5));
   w=(2/sqrt(3))*(2*theta).^(1/4).*cosh(b./3).^(0.5);
   c=((2*sigma)./w)-w.^2;
   c=(w+sqrt(c))./2;
   deta=c.^3;
   
    
end
    
end