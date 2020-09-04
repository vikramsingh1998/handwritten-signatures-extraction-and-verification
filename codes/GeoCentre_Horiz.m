function [Geo1 Geo2 Geo3] = GeoCentre_Horiz(I)
% GEOCENTRE_HORIZ Gives the geometric centre in the horizontal splitting of
% the skeletonized image.

% B = Geo_Centre_Horiz(A) gives the geometric centre coordinates of
% different parts of the image
Geo1 = GeoCentre(I);

I1 = I(1:floor(Geo1(2)),:);
Geo2 = GeoCentre(I1);

I2 = I(floor(Geo1(2)):end,:);
G3 = GeoCentre(I2);
Geo3 = [G3(1), G3(2) + Geo1(2)];

end