function U = threeDL1(FV,lambda,gamma,nu,MaxIter,thresh)

    
    U=FV;
    C = getC(U);
    [D,Dt]  = defDDt;
    
    Lxi1   = zeros(size(U)); % Lagrangian multiplier: xi (pronunce as zai or sai) 
    Lxi2   = zeros(size(U));
    Lxi3   = zeros(size(U));
    
    % diff
    [D1U,D2U,D3U]   = D(U);
    
    cont = 1;
    k    = 0;
    while cont
        k = k + 1;
        % X-subproblem
        Xterm1 = D1U + Lxi1./gamma;
        Xterm2 = D2U + Lxi2./gamma;
        Xterm3 = D3U + Lxi3./gamma;
        Xterm  = sqrt(Xterm1.^2 + Xterm2.^2 + Xterm3.^2);
        %     Xterm(Xterm == 0) = 1;
        %         W = exp(-gamma * (D1I.^2 + D2I.^2));
        Xterm  = max(Xterm - lambda/gamma, 0) ./ (Xterm + eps);
        Xmg1   = Xterm1 .* Xterm;
        Xmg2   = Xterm2 .* Xterm;
        Xmg3   = Xterm3 .* Xterm;
        
        % U-subproblem
        Unum = fftn(FV) + gamma * fftn(Dt(Xmg1-Lxi1/gamma,Xmg2-Lxi2/gamma,Xmg3-Lxi3/gamma));
        Udenom = 1 + gamma * C.eigsDtD;
        Unew = real(ifftn(Unum./(Udenom + eps)));
        [D1U,D2U,D3U] = D(Unew);
        
        Lxi1 = Lxi1 - nu * gamma * (Xmg1 - D1U);
        Lxi2 = Lxi2 - nu * gamma * (Xmg2 - D2U);
        Lxi3 = Lxi3 - nu * gamma * (Xmg3 - D3U);
        
        re = norm(Unew(:) - U(:),'fro') / norm(U(:),'fro');
        U  = Unew;
        cont  = (k < MaxIter) && (re > thresh);
    end
end


function C = getC(U)
    %
    sizeU     = size(U);
    % psf2otf ——computes the Fast Fourier Transform (FFT) of the point-spread function (PSF)
    C.eigsD1  = psf2otf([1,-1], sizeU);  %▽x
    C.eigsD2  = psf2otf([1;-1], sizeU);  %▽y
    C.eigsD3  = psf2otf(cat(3,1,-1), sizeU);  %▽z
    C.eigsDtD = abs(C.eigsD1).^2 + abs(C.eigsD2).^2 + abs(C.eigsD3).^2; %▽t*▽ : Laplacian, \nabla = (▽x)^2+(▽y)^2+(▽z)^2
    
    %
end
%
function [D,Dt] = defDDt
    % defines finite difference operator D
    % and its transpose operator
    % referring to FTVD code
    D = @(U) ForwardD(U);
    Dt = @(X,Y,Z) Dive(X,Y,Z);
end

function [Dux,Duy,Duz] = ForwardD(U) %diff
    % Forward finite difference operator
    Dux = [diff(U,1,2), U(:,1,:) - U(:,end,:)];
    Duy = [diff(U,1,1); U(1,:,:) - U(end,:,:)];
    Duz = cat(3,diff(U,1,3), U(:,:,1) - U(:,:,end));
end
%
function DtXYZ = Dive(X,Y,Z) %Dt=-div
    % Transpose of the forward finite difference operator
    DtXYZ = [X(:,end,:) - X(:,1,:), -diff(X,1,2)]; % ▽x(Fx)
    DtXYZ = DtXYZ + [Y(end,:,:) - Y(1,:,:); -diff(Y,1,1)]; % ▽x(Fx)+▽y(Fy)
    DtXYZ = DtXYZ + cat(3,Z(:,:,end) - Z(:,:,1),-diff(Z,1,3)); % ▽x(Fx)+▽y(Fy)+▽z(Fz) : Divergence
end
