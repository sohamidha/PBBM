function PBBM=getPBBM(R1,R2,R3,R4,L1,L2,L3,L4)
% INPUT: LBPCode1.....LBPCodem extracted from m samples captured by a certain individual. OUTPUT: PBBM of the certain individual.
% Algorithm:
% For n=1 to nCm do
% sampling two samples with non-replacement;
% get BBM(n) by invoking GetBBM_twosamples. endfor
% take these BBMs as new LBPCodes.
% use these new LBPCodes to generate PBBM according to Definition 1 and 2.
% Definition 1: If the si value of a certain bit is equal to 1, this bit is called Best Bit.
% Definition 2: All Best Bits of a certain individual make up his Best Bit Map (abbreviated as BBM).

times=4;
step=1;
BBM{1}=calc_newLBP(R1,R2,L1,L2,step,times);
% [~,S{1}]=calcSimilarity(L1,L2);
% t(1)=sum(sum(S{1}));
BBM{2}=calc_newLBP(R1,R3,L1,L3,step,times);
% [~,S{2}]=calcSimilarity(L1,L3);
% t(2)=sum(sum(S{2}));
BBM{3}=calc_newLBP(R1,R4,L1,L4,step,times);
% [~,S{3}]=calcSimilarity(L1,L4);
% t(3)=sum(sum(S{3}));
BBM{4}=calc_newLBP(R2,R3,L2,L3,step,times);
% [~,S{4}]=calcSimilarity(L2,L3);
% t(4)=sum(sum(S{4}));
BBM{5}=calc_newLBP(R2,R4,L2,L4,step,times);
% [~,S{5}]=calcSimilarity(L2,L4);
% t(5)=sum(sum(S{5}));
BBM{6}=calc_newLBP(R3,R4,L3,L4,step,times);
% [~,S{6}]=calcSimilarity(L3,L4);
% t(6)=sum(sum(S{6}));
% [~,i]=max(t);
% % [pBBIndex]=find(S{i}==1);%index location of bits with similarity 1
% % a=BBM{i}(:,2);
% % pBMap=a(pBBIndex);%bit values at pBBIndex
% % PBBM=[pBBIndex,pBMap];%BBM of two samples containing best bit location and value 0 or 1
%  PBBM=BBM{i};
PBBM=calcpbbmfor2(BBM{6},calcpbbmfor2(BBM{5},calcpbbmfor2(BBM{4},calcpbbmfor2(BBM{3},calcpbbmfor2(BBM{2},BBM{1})))));
end