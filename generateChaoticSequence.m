function [y, K]=generateChaoticSequence(dyfun,len,discardn,y0,h)
dim = length(y0);
len2 = discardn+ceil(len/dim);
y=zeros(dim,len2);
y(:,1)=y0(:);
for n=1:len2-1
    k1=feval(dyfun,y(:,n));
    k2=feval(dyfun,y(:,n)+h/2*k1);
    k3=feval(dyfun,y(:,n)+h/2*k2);
    k4=feval(dyfun,y(:,n)+h*k3);
    y(:,n+1)=y(:,n)+h*(k1+2*k2+2*k3+k4)/6;
end
y(:,1:discardn)=[];
K=y(:)';
K=K(1:len);
K=uint8(mod(floor((abs(K)-floor(abs(K)))*10^15),256));

