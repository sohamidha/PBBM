function [Smm,S] =calcSimilarity(A,B)
y= size(A,1);
x=size(B,2);

for k=1:y
    for l=1:8
        m0=0;
        m1=0;
        if A(k,l)==0
            m0=m0+1;
        else
            m1=m1+1;
        end
        if B(k,l)==0
            m0=m0+1;
        else
            m1=m1+1;
        end
        S(k,l)=abs(m0-m1)/(m1+m0);
       
    end
end
 Smm=sum(sum(S(k,l)));
end