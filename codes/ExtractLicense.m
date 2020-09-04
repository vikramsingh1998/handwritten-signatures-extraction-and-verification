    function r = ExtractLicense(main_dir)
    % EXTRACTLICENSE Extracts the license image from the original image and save
    % the output in the lic_img directory (located in the main directory)

    % B = ExtractLicense(A) extracts the license image from all the images present
    % in the directory A.
    try
        %main_dir = 'Database/';
        lic_dir = 'Lic_img';
        % Verifies if the 'Lic_img' dir exists
        if ~exist(strcat(main_dir, '\', lic_dir), 'dir')
            mkdir(strcat(main_dir, '\', lic_dir))
        end
        % Saves a variable 'files' with all the names of .jpg files
        files = dir(fullfile(main_dir, '\', '*.JPG'));
        % Gets the number of files
        no_files = size(files, 1);
        mt = waitbar(0,'1', 'Name', 'Getting licences', ...
            'CreateCancelBtn', ...
            'setappdata(gcbf,''canceling'', 1)');
        setappdata(mt, 'canceling', 0)
        cancel = 0;
        cont = 0;
        for n=1:1:no_files

            %Variable with name of file
            nam = char(files(n).name);
            % Trims the extention of the file name
            ln_nm = size(nam, 2)-4;
            nam = nam(1, 1:ln_nm);
            x = cont / no_files;
            msg = strcat('Processing...', nam);
            waitbar(x, mt, msg);
            % Open image
            img1 = imread(strcat(main_dir, '\', nam, '.jpg'));
            img1 = img1(:, 80:end, :);
            % Convert image to rgb and filter
            imgg = rgb2gray(img1);
            % Convert image to black and white
            imbw1 = logical(im2bw(imgg, 0.90));
            %%imbw1 = imbw1(1:a-10, 10:b);
            se = strel('disk',7);
            % Aplying morfological transform 'close'
            imbw1 = imclose(imbw1,se);
            % Function to get limits to cut image vertically
            [inf, sup] = lic_coor(imbw1);
            % New resulting image
            lc = imgg(:, inf:sup);
            %%figure, imshow(BW2)
            %%figure, imshow(lc)
            % Binarization and transformation of datatype image
            imbw2 = logical(im2bw(lc, 0.90));
            %%figure, imshow(imbw2)
            % Sum of the rows in negative image
            S = sum(~imbw2,2);
            % Gets width of image
            w = uint32(size(imbw2, 1));
            % Set limits to cut image horizontaly
            liminf= w*0.1;
            limsup= w*0.4;
            %%figure, plot(S)
            cut = 1;
            % Number of elements in S
            lens = size(S, 1);
            for k=1:1:lens
                % When the amount of pixels gets smaller than the inferior limit,
                % sets the point to cut
                if S(k, 1) < liminf
                    cut = k;
                    break
                end
            end
            for k=cut:1:lens
                % When the amount of pixels gets greater than the superior limit,
                % sets the point to cut
                if S(k, 1) > limsup
                    cut = k;
                    break
                end
            end
            % The partial cut point is set when the variation from liminf to limsup
            % gets place
            %%hold on;
            % Empirically added 75 units to cut
            cut = cut + 75;
            %%plot([cut], [S(cut, 1)], 'r*')
            %%lc = lc(cut:size(lc, 1), :);
            %%figure, imshow(lc)
            % Rebinarization and close of the image
            nw_lc = im2bw(lc, 0.95);
            nw_lc = imclose(nw_lc,se);
            %%figure, imshow(nw_lc)
            % Gets the inferior point to cut the image
            ls = crp_inf(nw_lc);
            msg = strcat('Saving...', nam);
            %%figure, imshow(img1(cut:ls, inf:sup, :))
            % Saves the final image with th '_lic' sufix
            imwrite(img1(cut:ls, inf:sup, :), strcat(main_dir, '\', lic_dir, '\', '\', nam, '_lic', '.png'));
            waitbar(x, mt, msg);
            if getappdata(mt, 'canceling')
                msg = 'Canceling...';
                cancel = 1;
                waitbar(x, mt, msg);
                break
            end
            cont = cont + 1;

        end
        waitbar(1);
        delete(mt)
        r = ~cancel;
    catch
        r = 0;
    end
    delete(mt)
    end