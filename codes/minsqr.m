% Minimun square image
% This script sets the minimum rounding rectangle wich contains the
% signature
function f = minsqr(img)
    cont = 0;
    while cont < 2
        try
            %% Filter
            %trim_img = filter_im(img);
            %% Centroid
            trim_img = img;
            %figure, imshow(img)
            props = regionprops(not(trim_img), 'Centroid', 'Area', 'BoundingBox');
            [xc, yc, gtr_x, gtr_y] = im_centroid(props);
            %centroids = cat(1, props.Centroid);
            %plot(centroids(:,1),centroids(:,2), 'b*');
            ntrim = ~logical(trim_img);

            %figure, imshow(trim_img), title('Minsqr')
            %hold on
            %plot(xc, yc, 'r*')
            %hold off
            %% Horizontal mapping
            dim = size(trim_img);
            %Lower horizontal
            for i=yc:1:dim(1)
               if sum(ntrim(i, :)) == 0
                   h_dn = i-1;
                   break
               else
                   h_dn = dim(1);
               end
            end
            %Upper horizontal
            for i=yc:-1:1
                if sum(ntrim(i, :)) == 0
                    h_up = i+1;
                    break
                else
                    h_up = 1;
                end          
            end
            new_img = trim_img(h_up:h_dn,:);
            %figure, imshow(new_img)
            %Right vertical
            dim = size(new_img);
            stop = 0;
            for j=dim(2):-1:xc
               for i=1:1:dim(1)
                   v_rg = j;
                   if not(new_img(i, j))
                       stop = 1;
                       break
                   end
               end
               if stop
                    break
                end
            end
            %Left vertical
            stop = 0;
            for j=1:1:xc
                dim(1);
                for i=1:1:dim(1)
                    i;
                    v_lf = j;
                    if not(new_img(i, j))
                        stop = 1;
                        break
                    end       
                end
                if stop
                    break
                end
            end
            try
                v_lf;
            catch
                v_lf = 1;
            end
            sqr_im = new_img(:,v_lf:v_rg);
            %figure, imshow(sqr_im)
            f = sqr_im;
            cont = 2;
            %% Resize
            % f = sqr_im; %imresize(sqr_im,[750 1300]);
            % figure, imshow(f), title('Resized')
        catch ME
            errorMessage = sprintf('Error in function %s() at line %d.\n\nError Message:\n%s\nCoul not trim image', ...
            ME.stack(1).name, ME.stack(1).line, ME.message);
            fprintf(1, '%s\n', errorMessage);
            figure, imshow(trim_img), title(ME.message)
            if cont < 1
                trim_img = del_up(img);
            end
            cont = cont + 1;
            f = img;
        end
    end
end