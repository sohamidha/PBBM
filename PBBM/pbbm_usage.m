%%read image
tic;
I1=im2double(rgb2gray(imread('index_1.bmp')));
I1=imresize(I1,0.5);

I2=im2double(rgb2gray(imread('index_4.bmp')));
I2=imresize(I2,0.5);

I3=im2double(rgb2gray(imread('index_6.bmp')));
I3=imresize(I3,0.5);

I4=im2double(rgb2gray(imread('index_5.bmp')));
I4=imresize(I4,0.5);

%%ROI extraction using lee region
[fvr1,edges1]=lee_region(I1,4,20);
x=size(edges1,2);
%ROI1=imcrop(I1,[1 edges1(1,x) x-1 edges1(2,x)-edges1(1,x)]);
ROI1=imcrop(I1,[1 edges1(1,floor(x/2)) x-1 edges1(2,floor(x/2))-edges1(1,floor(x/2))]);

ROI1=imresize(ROI1,[64 96],'bilinear');

%%grayscale normalization
% imshow(ROI1);
% fmax=max(ROI1(:));
% fmin=min(ROI1(:));

%ROI1=(ROI1-fmin)/(fmax-fmin);
ROI1=imadjust(ROI1);
%imshow(ROI1);

%region 2
 [fvr2,edges2]=lee_region(I2,4,20);
 x=size(edges2,2);
ROI2=imcrop(I2,[1 edges2(1,floor(x/2)) x-1 edges2(2,floor(x/2))-edges2(1,floor(x/2))]);

 %ROI2=imcrop(I2,[1 edges2(1,x) x-1 edges2(2,1)-edges2(1,1)]);
 ROI2=imresize(I2,[64 96],'bilinear');
 ROI2=imadjust(ROI2);
 %region 3
 [fvr3,edges3]=lee_region(I3,4,20);
 x=size(edges3,2);
ROI3=imcrop(I3,[1 edges3(1,floor(x/2)) x-1 edges3(2,floor(x/2))-edges3(1,floor(x/2))]);

 %ROI3=imcrop(I3,[1 edges3(1,x) x-1 edges3(2,1)-edges3(1,1)]);
 ROI3=imresize(I3,[64 96],'bilinear');
 ROI3=imadjust(ROI3);
 %region 4
 [fvr4,edges4]=lee_region(I4,4,20);
 x=size(edges4,2);
ROI4=imcrop(I4,[1 edges4(1,floor(x/2)) x-1 edges4(2,floor(x/2))-edges4(1,floor(x/2))]);

 %ROI4=imcrop(I4,[1 edges4(1,x) x-1 edges4(2,1)-edges4(1,1)]);
 ROI4=imresize(I4,[64 96],'bilinear');
 ROI4=imadjust(ROI4);
 
 %% calculate LBP codes of all the samples
 lbp1=LBP(ROI1);
 lbp2=LBP(ROI2);
 lbp3=LBP(ROI3);
 lbp4=LBP(ROI4);
%  %% calculate BBM and subsets of LBPcodes with maximum similarity
%  step=1;
%  times=4;
%  [BBM]=calc_newLBP(ROI1,ROI2,lbp1,lbp2,step,times);

 %% now calculate the PBBM of a certain individual
 
PBBM=getPBBM(ROI1,ROI2,ROI3,ROI4,lbp1,lbp2,lbp3,lbp4);
 
 %% read the test input image for matching
 Itest=im2double(rgb2gray(imread('index_1.bmp')));
Itest=imresize(Itest,0.5);

%%ROI extraction using lee region
[fvrt,edgest]=lee_region(Itest,4,20);
x=size(edgest,2);
%ROIt=imcrop(Itest,[1 edgest(1,x) x-1 edgest(2,x)-edgest(1,x)]);
ROIt=imcrop(Itest,[1 edgest(1,floor(x/2)) x-1 edgest(2,floor(x/2))-edgest(1,floor(x/2))]);
ROIt=imresize(ROIt,[64 96],'bilinear');

%%grayscale normalization
ROIt=imadjust(ROIt);
 
%% calculate LBP of input test image
LBPtest=LBP(ROIt);

%% calculate match score 
match_score=PBBM_matching(PBBM,LBPtest);
disp(match_score); 
toc;
 
 