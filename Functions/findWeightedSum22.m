function weightedSum= findWeightedSum22(sgW,uW)
    [cVol,~]=size(uW); % cVol: counting of volumes
    [X,Y,Z]=size(sgW{1});
    weightedSum=zeros(X,Y,Z);
    
    for i=1:cVol
        weightedSum = weightedSum + (sgW{i} .* uW{i});
    end
    
end