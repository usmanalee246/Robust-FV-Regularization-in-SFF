function U = volumeRegularizer(G,U0,F,nei,lambda,sig1,sig2,sig3,itr)

U = cell(1,itr);
[X,Y,Z]=size(G);
ONES=ones(X,Y,Z);

nG = findNeighborVols(G,nei);     % neighboring volumes in Guidance
ndG =findDiffSq(G,nG);     % squared-differences with neighboring volumes of Guidance
sgW = computeSGW(sig1,sig2,ndG);   % spatial and guidance Weights

for i=1:itr
    nU = findNeighborVols(U0,nei);    % neighboring volumes in (output) target volume
    ndU=findDiffSq(U0,nU);  % squared-differences with neighboring volumes of (output) target volume
    uW = computeUW(sig3,ndU);  % Weights from dynamically updated (output) target volume
    
    wSum12= findWeightedSum12(sgW,uW,nU);
    wSum22= findWeightedSum22(sgW,uW);
    
    U0 = (F + lambda * wSum12)./(ONES + lambda * wSum22);
    U{1,i}=U0;
end

end