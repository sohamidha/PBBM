function score=PBBM_matching(PBBM,lbp_test)
lengthPBBM=size(PBBM,1);
index=PBBM(:,1);
PMap=PBBM(:,2);
xored=xor(PMap(:),lbp_test(index));
xorsum=sum(sum(xored));
score=1-(xorsum/lengthPBBM);
end
