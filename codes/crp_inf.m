% This function gives the upper first black point in the lower left 
% quadrant of the image
function sup = crp_inf(imbw1)

    h = size(imbw1, 1);
    w = uint32(size(imbw1, 2)/2);
    sup = 1;
    %h = ones([a, 1]);
    for j=1:1:w
        for i=h:-1:1
            if imbw1(i, j) == 0
                if i > sup
                    sup = i;
                end
                break
            end
        end
    end
    
end