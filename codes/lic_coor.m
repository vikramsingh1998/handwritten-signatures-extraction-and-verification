function [inf, sup] = lic_coor(imbw1)
  
    h = size(imbw1, 1);
    w = size(imbw1, 2);
    inf = w;
    %For all the pixels in image
    for i=1:1:h
        %For each row
        for j=1:1:w
            if imbw1(i, j) == 0
                if j < inf
                    inf = j;
                end
                break   
            end
        end
    end
    %inf = min(h);
    sup = 1;
    for i=h:-1:h-30
        for j=1:1:w
            if imbw1(i, j) == 0
                if j > sup
                    sup = j;
                end
                break   
            end
        end
    end
    sup = sup-1;
    %f = imbw1(:,inf:sup);
end