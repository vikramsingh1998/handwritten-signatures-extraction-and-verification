function r = get_all_feat(main_dir)
try
    %main_dir = 'Database/';
    % Verifies if Skel_img dir exists
    if exist(strcat(main_dir, '\', 'Skel_img/'), 'dir')
        % Saves a variable 'files' with all the names of .png files
        files = dir(fullfile(strcat(main_dir, '\', 'Skel_img/'), '*.png'));
        % Gets number of files
        no_files = size(files, 1);
%         a = 0;
        x = 1;
        for n=1:1:no_files
            % Gets file name
            nam = char(files(n).name);
            %%nam = 'Q106_recto_lic.png';
            % Open image
            img1 = imread(strcat(main_dir, '\', 'Skel_img/', nam));
            
            % Calculate horizontal splitted features
            horiz_feat = HorizontalFeat(img1);
            
            % Calculate vertically splitted features
            vert_feat = VerticalFeat(img1);
            
            % Make the feature datase
            Y(x:(61 + x),:) = [vert_feat; horiz_feat];
            
%             Z(x:(61 + x), :) = a;
%             
%             a = a + 1;
%             
            x = x + 62;         
            
        end
%         Y(:,3) = Z;
    end
end
r = Y;
end
