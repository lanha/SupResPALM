function x = projsplx(y)
% If you cannot compile the mex code you can use this file instead of the 
% Pplusb.m function, but it will be slower.

% project an n-dim vector y to the simplex Dn
% Dn = { x : x n-dim, 1 >= x >= 0, sum(x) = 1}

% (c) Xiaojing Ye
% xyex19@gmail.com
%
% Algorithm is explained as in the linked document
% http://arxiv.org/abs/1101.6081
% or
% http://ufdc.ufl.edu/IR00000353/
%
% Jan. 14, 2011.
% 
% Edited on Aug. 17, 2016 by Charis Lanaras for the demo of "Hyperspectral 
% Super-Resolution by Coupled Spectral Unmixing", ICCV 2015.

m = size(y,1); bget = false;
x = zeros(size(y));

for jj=1:size(y,2)
    
    s = sort(y(:,jj),'descend'); tmpsum = 0;
    
    for ii = 1:m-1
        tmpsum = tmpsum + s(ii);
        tmax = (tmpsum - 1)/ii;
        if tmax >= s(ii+1)
            bget = true;
            break;
        end
    end
    
    if ~bget, tmax = (tmpsum + s(m) -1)/m; end;
    
    x(:,jj) = max(y(:,jj)-tmax,0);
end

return;