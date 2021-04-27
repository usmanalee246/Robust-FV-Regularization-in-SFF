function weightedSum12= findWeightedSum12(sgW,uW,nU)
        [cVol,~]=size(nU); % cVol: counting of volumes
    [X,Y,Z]=size(sgW{1});
    weightedSum12=zeros(X,Y,Z);
    
    for i=1:cVol
        weightedSum12 = weightedSum12 + (sgW{i} .* uW{i} .* nU{i});
    end
    
end