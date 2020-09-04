function r = get_all_sig(main_dir)
% GET_ALL_SIG Extracts the signature from the license card extracted and
% save it in the Sig_img directory.#

% B = get_all_sig(A) extracts the license image from all the images present
% in the directory A.
try
    %main_dir = 'Database/';
    % Verifies if Lic_img dir exists
    if exist(strcat(main_dir, '\', 'Lic_img/'), 'dir')
        % Saves a variable 'files' with all the names of .png files
        files = dir(fullfile(strcat(main_dir, '\', 'Lic_img/'), '*.png'));
        % Gets number of files
        no_files = size(files, 1);
        % Sets the directory to save the images of signatures
        sig_dir = 'Sig_img';
        % If does not exists, creates it
        if ~exist(strcat(main_dir, '\', sig_dir), 'dir')
            mkdir(strcat(main_dir, '\', sig_dir))
        end
        mt = waitbar(0,'1', 'Name', 'Getting Signatures', ...
            'CreateCancelBtn', ...
            'setappdata(gcbf,''canceling'', 1)');
        setappdata(mt, 'canceling', 0)
        cancel = 0;
        cont = 0;
        for n=1:1:no_files
            % Gets file name
            nam = char(files(n).name);
            %%nam = 'Q106_recto_lic.png';
            % Open image
            img1 = imread(strcat(main_dir, '\', 'Lic_img/', nam));
            % Delete file extention
            ln_nm = size(nam, 2)-4;
            nam = nam(1, 1:ln_nm);
            x = cont / no_files;
            msg = strcat('Processing...', nam);
            waitbar(x, mt, msg)  
            
            [q, v] =  size(img1);
            
            % Caluculate the average proportion to cut the license images
            % upto the photo of the person
            y1 = round((0.4116*v)/100);
            y2 = round((11.2*v)/100);
            
            I_vert = img1(round(0.7*q):end,y1:y2);
            
            % Increase the contrast of the signature
            I_vert = imadjust(I_vert);
            [p, r] = size(I_vert);
            I_binarize = imbinarize(I_vert,'adaptive', 'ForegroundPolarity','dark','Sensitivity',0.4);
            I_binarize = filter_im(I_binarize);
            b = 1;
            Y = [];
            
            % Find the point where there is only white pixels below the
            % photo
            for i = p:-1:0.2*p
                
                if sum(I_binarize(i,:)) ~= r
                    
                    Y(1,b) = i;
                    b = b + 1;
                    
                end
            end
            
            
            diff_Y = diff(Y);
            
            diff_index = find(diff_Y ~= -1);
            
            new_img = I_binarize(Y(max(diff_index)):Y(1),:);
            
            if  numel(find(new_img==0)) < 6500
                
                new_img = new_img;
                
            else
                
                se = strel('disk',1);
                new_img = imdilate(new_img,se);
                
            end
            
            output_img = minsqr(new_img);
            
            
            %imshow(output_img)
            
            if ~isnan(output_img)
                %%figure, imshow(tr_sqr)
                % Saves the signature image
                msg = strcat('Saving...', nam);
                imwrite(output_img, strcat(main_dir, '\', 'Sig_img/', nam, '_s.png'));
                
            else
                % In case an error ocurred in image processing
                msg = strcat('Could not process image', nam);
            end
            waitbar(x, mt, msg);
            if getappdata(mt, 'canceling')
                msg = 'Canceling...';
                cancel = 1;
                waitbar(x, mt, msg);
                break
            end
            cont = cont + 1;
        end
        r = ~cancel;
        waitbar(1);
    else
        answer = questdlg('Not Licences directory available', ...
            'Invalid dir', ...
            'Create', 'Cancel','Create');
        % Handle responsenot
        switch answer
            case 'Create'
                r = get_lic_img(main_dir);
            case 'Cancel'
                r = 0;
        end
        if r
            r = get_all_sig(main_dir);
        end
    end
catch
    r = 0;
end
try
    delete(mt)
catch
end
end


