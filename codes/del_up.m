% This function deletes uper noise in image 
function f = del_up(img)
    %S = sum(~img,2);
    %figure, plot(S)
    h = size(img, 1);
    %w = size(img, 2);
    cont = 0;
    for i=1:1:h
        if all(img(i, :))
            lim = i;
            cont = 1;
            break
        end
    end
    if cont == 0
        lim = 1;
    end
    f = img(lim:h, :);        
end