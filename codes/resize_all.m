function r = resize_all(main_dir)
% RESIZE_ALL Makes all the signatures in the Sig_img directory of equal
% sizes and store it in Sig_resimg directory

% B = resize_all(A) makes the signature of equal sizes in the Sig_resimg
% directory
try
    %main_dir = 'Database/';
    % Verifies if Sig_img dir exists
    if exist(strcat(main_dir, '\', 'Sig_img/'), 'dir')
        % Saves a variable 'files' with all the names of .png files
        files = dir(fullfile(strcat(main_dir, '\', 'Sig_img/'), '*.png'));
        % Gets number of files
        no_files = size(files, 1);
        %         a = 0;
        sig_resdir = 'Sig_resimg';
        % If does not exists, creates it
        if ~exist(strcat(main_dir, '\', sig_resdir), 'dir')
            mkdir(strcat(main_dir, '\', sig_resdir))
        end
        x = 1;
        for n=1:1:no_files
            % Gets file name
            nam = char(files(n).name);
            %%nam = 'Q106_recto_lic_s.png';
            % Open image
            img1 = imread(strcat(main_dir, '\', 'Sig_img/', nam));
            % Delete file extention
            ln_nm = size(nam, 2)-4;
            nam = nam(1, 1:ln_nm);
            
            % Resize all images
            newim = imresize(img1,[165, 500]);
            
            imwrite(newim, strcat(main_dir, '\', 'Sig_resimg/', nam, '_res.png'));
            
        end
    end
end
r = 1;
end
