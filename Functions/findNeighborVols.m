function nVol = findNeighborVols (Vol,nei) % it gives 6,18 or 26 neighboring volumes
    
    %Abbreviations
    % [up: u], [down: d], [right: r], [left: l], [out: o], [in: i]
    % [n: neighbors]
    
    P=padarray(Vol,[1,1,1],'replicate');
    
    if nei < 3
        %         nVol = cell(6,1); % neighborhood volumes
        % normal 6 neighbors in 3D
        nVol{1,1}=P(1:end-2,2:end-1,2:end-1);  %u=P(1:end-2,2:end-1,2:end-1);
        nVol{2,1}=P(3:end,2:end-1,2:end-1); % d
        nVol{3,1}=P(2:end-1,3:end,2:end-1); % r
        nVol{4,1}=P(2:end-1,1:end-2,2:end-1); % l
        nVol{5,1}=P(2:end-1,2:end-1,1:end-2); % o
        nVol{6,1}=P(2:end-1,2:end-1,3:end); % i
        
        if (nei==1) || (nei==2)
            % neighbors which can be reached via moving in 2 directions
            nVol{7,1}=P(1:end-2,3:end,2:end-1);  %ur
            nVol{8,1}=P(1:end-2,1:end-2,2:end-1); % ul
            nVol{9,1}=P(3:end,3:end,2:end-1);  % dr
            nVol{10,1}=P(3:end,1:end-2,2:end-1); % dl
            nVol{11,1}=P(1:end-2,2:end-1,1:end-2); % uo
            nVol{12,1}=P(2:end-1,1:end-2,1:end-2); % lo
            nVol{13,1}=P(3:end,2:end-1,1:end-2); % do
            nVol{14,1}=P(2:end-1,3:end,1:end-2); % ro
            nVol{15,1}=P(1:end-2,2:end-1,3:end); % ui
            nVol{16,1}=P(2:end-1,1:end-2,3:end); % li
            nVol{17,1}=P(3:end,2:end-1,3:end); % di
            nVol{18,1}=P(2:end-1,3:end,3:end); % ri
            if nei==2
                % neighbors which can be reached via moving in 3 directions
                nVol{19,1}=P(1:end-2,3:end,1:end-2); % uro
                nVol{20,1}=P(1:end-2,1:end-2,1:end-2); % ulo
                nVol{21,1}=P(3:end,1:end-2,1:end-2); % dlo
                nVol{22,1}=P(3:end,3:end,1:end-2); % dro
                nVol{23,1}=P(1:end-2,3:end,3:end); % uri
                nVol{24,1}=P(1:end-2,1:end-2,3:end); % uli
                nVol{25,1}=P(3:end,1:end-2,3:end); % dli
                nVol{26,1}=P(3:end,3:end,3:end); % dri
            end
        end
    end
end