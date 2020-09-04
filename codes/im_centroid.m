function [f, g, gtr_x, gtr_y] = im_centroid(stru)
    tot_Area = 0;
    acY_Area = 0;
    acX_Area = 0;
    gtr_x = 0;
    gtr_y = 0;
    for i=1:1:length(stru)
       Ai = stru(i).Area;
       a = stru(i).Centroid;
       bound = stru(i).BoundingBox;
       if bound(1) > gtr_x
           gtr_x = uint64(bound(1));
       end
       if bound(4) > gtr_y
           gtr_y = uint64(bound(4));
       end
       xi = a(1);
       yi = a(2);
       tot_Area = tot_Area + Ai;
       X_Area = xi * Ai;
       Y_Area = yi * Ai;
       acX_Area = acX_Area + X_Area;
       acY_Area = acY_Area + Y_Area;
    end
    xc = acX_Area/tot_Area;
    yc = acY_Area/tot_Area;
    f = uint64(xc);
    g = uint64(yc);
end