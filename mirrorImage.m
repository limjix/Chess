function Y = mirrorImage(X)
% mirrorImage  do X upside down.
% reverses the direction of the given image
%
% Inputs:
% * X ... uint8 nxm matrix (n,m>1)
%
% Outputs:
% * Y ... uint8 nxm matrix up side down
%
% Example
% Given is an uint8 image matrix (which was loaded with imread), with 
% |Y = mirrorImage(X)| you get the image upside down.
%
% See also: fliplr, image, imread
%
%% Signature
% Author: W.Garn
% E-Mail: wgarn@yahoo.com
% Date: 2006/03/23 12:00:00 
% 
% Copyright 2006 W.Garn
%
dim = size(X);
if length(dim)>2
    Y = zeros(dim);
    for k=1:dim(3)
        Y(:,:,k) = (fliplr(X(:,:,k)'))';
    end
    Y = uint8(Y);
else
    Y = uint8((fliplr(X'))');
end