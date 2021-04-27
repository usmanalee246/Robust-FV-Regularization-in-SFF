function sgW = computeSGW(sig1,sig2,ndG)
    
    [cVol,~]=size(ndG); % cVol: counting of volumes
    sgW=cell(cVol,1);
    % weighting parameters for spatial difference
    % sw1: spatial weight for direct neighbors: sqrt(1). Here 1 direction involved
    % sw2: spatial weight for diagonal neighbors in 2D: sqrt(2). Here 2 direction involved
    % sw: spatial weight for diagonal neighbors in 3D: sqrt(3). Here 3 direction involved
    
    sw1=1; 
    sw2=2;
    sw3=3;
    
    if (cVol==6) || (cVol==18) || (cVol==26)
        
        for i=1:6
            sgW{i}=exp(-sig1*sw1)*exp(-sig2*ndG{i});
        end
        
        if (cVol==18) || (cVol==26)
            
            for i=7:18
                sgW{i}=exp(-sig1*sw2)*exp(-sig2*ndG{i});
            end
            
            if (cVol==26)
                
                for i=19:26
                    sgW{i}=exp(-sig1*sw3)*exp(-sig2*ndG{i});
                end
            end
        end
    end
end