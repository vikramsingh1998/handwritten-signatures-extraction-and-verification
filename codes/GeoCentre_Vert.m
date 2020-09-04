function [Med Geo1 Geo2 Geo3] = GeoCentre_Vert(I)
% GEOCENTRE_VERT Gives the geometric centre in the vertical splitting of
% the skeletonized image.

% B = Geo_Centre_Vert(A) gives the geometric centre coordinates of
% different parts of the image

[p r] = find(I == 0);

Geo1 = GeoCentre(I);

Median = median(1:size(p));
Median_r = ceil(Median-1);

Median_y1 = median(p(1:Median_r,1));
Median_x1 = median(r(1:Median_r,1));
Median_y2 = median(p(Median_r:end,1));
Median_x2 = median(r(Median_r:end,1));

Med =  Median;

Geo2 = [Median_x1 Median_y1];
Geo3 = [Median_x2 Median_y2];

end