% Demo code for "Robust focus volume regularization in shape from focus"

%% add path of folders
addpath('Data');
addpath('Functions');

%% load image sequence
load TownC; % colored image sequence
imgC=TownC;
load Town; % grayscale image sequence
img=Town;

%%parameters (typically, following values give good results)
nei=2;      % (nei=0) 6-connected; (nei=1) 18-connected; (nei=2) 26-connected
lambda=0.3;
alpha=0.1;
beta=1.5; 
gamma=2.5; 
itr=8;

%% compute Focus Volume, and find initial depth map
FV=SMLC(imgC);      % Eq. 1 in manuscript
FV=scale_volume(FV,[0 1]); % scale FV
[~,id]=max(FV,[],3);       % find initial depth map

[img,~]=scale_volume(img,[0 1]); % scale grayscale image sequence (to be used as guidance)

%% initialization
u0 = threeDL1(FV,0.1,0.3,1.618,5,5e-4); % initialization using Eq. 21 of manuscript

%% iterative regularization using MM algorithm
uPR=volumeRegularizer(img,u0,FV,nei,lambda,alpha,beta,gamma,itr);

%% find depth map (output) from regularized FV at 8th iteration
[~,dPR]=max(uPR{1,itr},[],3);   % Eq. 17 in manuscript

%% display result (initial depth map, and focus volume regularized depth map)
figure;
subplot(1,2,1); imshow(id(6:end-5,6:end-5),[]); title('Initial depth map','fontsize',20);
subplot(1,2,2); imshow(dPR(6:end-5,6:end-5),[]); title('Regularized depth map','fontsize',20); colormap parula;
