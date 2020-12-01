clear all;
clc;
F=256;
I=[4 2 1 3; 3 1 4 2; 2 4 3 1; 1 3 2 4];
T=[1 2 4 3; 3 1 2 4; 4 3 1 2; 2 4 3 1];

M=[48 95 180 211; 207 248 162 0; 210 117 91 169;223,36,117,19];
h=4;w=4;
P=reshape([1:16],[h,w])';
C=zeros(h,w);
fprintf('encrypting...\n');
for i=1:h
    for j=1:w
        if j==1
            if i==1
                C(I(i,j),j)=mod(bitxor(M(i,j),P(T(j,I(i,j)),I(i,j))+P(I(h,w),w)),F);
            else
                C(I(i,j),j)=mod(bitxor(M(i,j),P(T(j,I(i,j)),I(i,j))+C(I(i-1,w),w)),F);
            end
        else    
            C(I(i,j),j)=mod(bitxor(M(i,j),P(T(j,I(i,j)),I(i,j))+C(I(i,j-1),j-1)),F);
        end
        fprintf('(%d,%d)=>%d\n',I(i,j),j,C(I(i,j),j));
    end
end
CI=C;
P=C;
D=zeros(h,w);
fprintf('decrypting...\n');
for i=h:-1:1
    for j=w:-1:1
        if j==1
            if i==1
                D(T(j,I(i,j)),I(i,j))=mod(bitxor(M(i,j),C(I(i,j),j))-D(I(h,w),w),F);
            else
                D(T(j,I(i,j)),I(i,j))=mod(bitxor(M(i,j),C(I(i,j),j))-C(I(i-1,w),w),F);
            end
        else    
            D(T(j,I(i,j)),I(i,j))=mod(bitxor(M(i,j), C(I(i,j),j))-C(I(i,j-1),j-1),F);
        end
        fprintf('(%d,%d)=>%d\n',T(j,I(i,j)),I(i,j),D(T(j,I(i,j)),I(i,j)));
    end
    
end
