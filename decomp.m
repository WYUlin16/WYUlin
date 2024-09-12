function [a b xa yb] = decomp( Jdark )
[m,n]=size(Jdark);
k=m*n*0.001;
xa=floor(m/2);yb=floor(n/2);
a=1;b=1; %所选择区域左上角的坐标
for i=1:10
    block1=Jdark(a:a+xa-1,b:b+yb-1);m1=length(find(block1==0));
    block2=Jdark(a+xa:a+2*xa-1,b:b+yb-1);m2=length(find(block2==0));
    block3=Jdark(a+xa:a+2*xa-1,b+yb:b+2*yb-1);m3=length(find(block3==0));
    block4=Jdark(a:a+xa-2,b+yb:b:b+2*yb-2);m4=length(find(block4==0));
    mnum=[m1,m2,m3,m4];
    [m,P]=max(mnum);
        
    %标记模块左上角坐标
    if P==1
        a=a;b=b;
    else if P==2
            a=a+xa;b=b;
        else if P==3
                a=a+xa;b=b+yb;
            else P==4
                a=a;b=b+yb;
            end
        end
    end
    xa=floor(xa/2);
    yb=floor(yb/2);
    
    if xa*yb <= k;
        break;
    end 
    i=i+1;
end
            


