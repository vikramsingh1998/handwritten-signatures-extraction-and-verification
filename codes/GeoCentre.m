function Geo1 = GeoCentre(I)
% GEOCENTRE Find the geometrical centre where the number of black piels are
% half.

% B = GeoCentre(A) gives the coordinates of the geometrical centres in the
% three parts of the image divides in horizontal and vertical splitting.

% Find the indexes where there are black pixles
[p r] = find(I == 0);

% Find the point where number of black pixels are rough
Median_x = median(r);
Median_y = median(p);

Geo1 = [Median_x Median_y];

end