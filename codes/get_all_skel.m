function r = get_all_skel(main_dir)
% GET_ALL_SKEL Extracts the skeleton from the equally sized signatures and
% save it in the Skel_img directory.#

% B = get_all_skel(A) extracts the skeleton from all the images present
% in the directory A.
try
    %main_dir = 'Database/';
    % Verifies if Sig_resimg dir exists
    if exist(strcat(main_dir, '\', 'Sig_resimg/'), 'dir')
        % Saves a variable 'files' with all the names of .png files
        files = dir(fullfile(strcat(main_dir, '\', 'Sig_resimg/'), '*.png'));
        % Gets number of files
        no_files = size(files, 1);
        % Sets the directory to save the images of signatures
        skel_dir = 'Skel_img';
        % If does not exists, creates it
        if ~exist(strcat(main_dir, '\', skel_dir), 'dir')
            mkdir(strcat(main_dir, '\', skel_dir))
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
            %%nam = 'Q106_recto_lic_s_res.png';
            % Open image
            img1 = imread(strcat(main_dir, '\', 'Sig_resimg/', nam));
            % Delete file extention
            ln_nm = size(nam, 2)-4;
            nam = nam(1, 1:ln_nm);
            x = cont / no_files;
            msg = strcat('Processing...', nam);
            waitbar(x, mt, msg)
            
            % Remove noise using dwt
            decom_img = wav_decom(img1);
            
            compl_img = imcomplement(decom_img);
            
%             compl_img = imcomplement(im2uint8(img1));
%             
%             logical_img = imbinarize(compl_img);
            
            logical_img = imbinarize(compl_img);
            
            % Gets the skeleton using bwskel
            skeleton_img = bwskel(logical_img,'MinBranchLength',0);
            
            output_img = imcomplement(skeleton_img);
            
            output_img = minsqr(output_img);
            
            if ~isnan(output_img)
                %%figure, imshow(tr_sqr)
                % Saves the signature image
                msg = strcat('Saving...', nam);
                imwrite(output_img, strcat(main_dir, '\', 'Skel_img/', nam, '_skel.png'));
                
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
                r = get_all_sig(main_dir);
            case 'Cancel'
                r = 0;
        end
        if r
            r = get_all_skel(main_dir);
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


