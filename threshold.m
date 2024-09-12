function JTS=threshold(J)
[counts x11]=imhist(J);
[mm,nn]=size(J);
BW1=otsu(counts,mm*nn);
% T=graythresh(J)-std2(J);
 T=graythresh(J);
% sigma=std2(J);
% a=max(max(J));
% b=mean(mean(J));
% T=b+sigma;
J(J>T)=0;

JTS=J;

