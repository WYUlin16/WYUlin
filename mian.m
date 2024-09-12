% Author£ºYulin Wang
% institution: Dalian Maritime university
% Time:2024/01/01
% Article title£º Dark Channel Low-Rank Prior: Toward Single Underwater Image Restoration

clc
clear 
close all

%% Read image data
J = imread('Example.png');
J = double(J);
I = J ./255 ;
figure(1); imshow(I); 

tic
%% Color correction preprocessing
Ic=mean(mean(I));
[l P1]=max(Ic);Ic(P1)=0;
[m P2]=max(Ic);Ic(P2)=0;delta1=(l-m);
[s P3]=max(Ic);delta2=(l-s);
I(:,:,P1)=min(I(:,:,P1),1);
I(:,:,P2)=min(I(:,:,P2)+delta1,1);  
I(:,:,P3)=min(I(:,:,P3)+delta2,1);
[gx gy]=gradient(I);
I=I+abs(gx)+abs(gy);
figure(2); imshow(I);
%% Solving for dark channels via MC
[p1,p2,~]=size(I);
Jdark=Idarkcross(I); 
figure(4); imshow(Jdark);
%% Separation background selected atmospheric light Ac
J=Jdark;
[gx gy]=gradient(J);
J=J+abs(gx)+abs(gy);
JTS=threshold(J);
figure(5);imshow(JTS);

[a b xa yb] = decomp(JTS);
AA=JTS;
AA(a:a+xa,b:b+yb)=1;
figure(6);imshow(AA);

AcR=mean(mean(I(a:a+xa,b:b+yb,1)));
AcG=mean(mean(I(a:a+xa,b:b+yb,2)));
AcB=mean(mean(I(a:a+xa,b:b+yb,3)));
Ac = [AcR, AcG, AcB];

%% Solving for the transmission Jt
w = 0.95;     % Retention factor of fog     
Jt = 1 - w*Jdark; 
figure(7); imshow(Jt,[]);
%% Solving for clear images is based on J = I*t + A*(1-t)   I = (J-A)/Jt + A
Iorg = zeros(p1,p2,3);
for k = 1:1:3
    Iorg(:,:,k) = (I(:,:,k)-Ac(k)) ./ Jt(:,:) + Ac(k);
end
figure(8); imshow(Iorg,[]);
toc