function [C] = jpd(P,seq,para,rt)
    %%rt>=2
    [h,w]=size(P);
    assert(h==w);
    %assert(rt>=2);
    F = 256;
    if max(P(:))==1
       F = 2;
    end
    C=zeros(h,w);
    for di=1:rt
        ep=0;
        sp=ep+1;ep=sp+w-1; r1=seq(sp:ep);    
        [sd1,si1]=sort(r1);

        sp=ep+1;ep=sp+w-1; r2=seq(sp:ep);
        [sd2,si2]=sort(r2);

        sp=ep+1;ep=sp+w-1; r3=seq(sp:ep);    
        [sd3,si3]=sort(r3);

        sp=ep+1;ep=sp+w-1; r4=seq(sp:ep);
        [sd4,si4]=sort(r4);

        sp=ep+1;ep=sp+w*w-1; r5=seq(sp:ep);      
        M=reshape(mod(floor((r5-floor(r5))*2^32),F),[h,w]);

        I = zeros(w,w);
        T = I;
        for i = 1:h
            for j = 1:w
                m = mod(i+si2(j)-1,w) + 1;
                I(i,j) = si1(m);
                n = mod(i+si4(j)-1,w) + 1;
                T(i,j) = si3(n);
            end
        end

        switch upper(para)
            case 'EN'
                %%encryption:joint permutation and diffusion
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
                    end
                end

            case 'DE'
                for i=h:-1:1
                    for j=w:-1:1
                        if j==1
                            if i==1
                                C(T(j,I(i,j)),I(i,j))=mod(bitxor(M(i,j),P(I(i,j),j))-C(I(h,w),w),F);
                            else
                                C(T(j,I(i,j)),I(i,j))=mod(bitxor(M(i,j),P(I(i,j),j))-P(I(i-1,w),w),F);
                            end
                        else    
                            C(T(j,I(i,j)),I(i,j))=mod(bitxor(M(i,j), P(I(i,j),j))-P(I(i,j-1),j-1),F);
                        end
                    end
                end
        end
        P=C;
    end
end

