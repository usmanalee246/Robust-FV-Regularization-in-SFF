function M = SMLC(imagesC) % compute focus measure for 3-channel (RGB) images i.e., M(i,j,k)=sum_{c=1}^{c=3} {focus value at (i,j,c)} 
    [width,height,FrameC]=size(imagesC);
    M = zeros(width,height,FrameC/3);
    
    for k=1:FrameC/3
        for i=2:width-1
            for j=2:height-1
                for frame=(k-1)*3+1:(k-1)*3+3
                    M(i,j,k) = M(i,j,k)+ abs(2*imagesC(i,j,frame)-imagesC(i-1,j,frame)-imagesC(i+1,j,frame))+...
                        abs(2*imagesC(i,j,frame)- imagesC(i,j-1,frame) - imagesC(i,j+1,frame));
                end
            end
        end
    end
end