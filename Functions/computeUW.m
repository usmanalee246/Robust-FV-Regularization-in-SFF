function uW = computeUW(sig3,ndU)
    
    [cVol,~]=size(ndU); % cVol: counting of volumes
    uW=cell(cVol,1);
    
    for i=1:cVol
        uW{i}=sig3 * (1-(tanh(sig3*ndU{i})).^2); % derivative of tanh(sig3*sqdiff): here ndU is squred difference
    end
    
end