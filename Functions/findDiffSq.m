function nD = findDiffSq (U,nU)
    
    [cVol,~]=size(nU); % cVol: counting of volumes
    nD=cell(cVol,1);
    for i=1:cVol
        nD{i}=(U-nU{i}).^2;
    end
    
    % find maximum of all neighbor-differing volumes
    Mx=max(max(max(cell2mat(nD))));
    
    % divide for normalization in range [0 1]
    for i=1:cVol
        nD{i}=nD{i}/Mx;
    end
end
