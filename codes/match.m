function [r t] = match(main_dir)
% Test image
% clear;
% clc;
% main_dir = 'C:\Users\invite1\Documents\Vikram_Project\Project_MITACS_UQTR_2019\Database';
try
    if exist(strcat(main_dir, '\', 'Skel_img/'), 'dir')
        [filename,filepath] = uigetfile({'*.jpg'},'Select and image');
        I = imread(strcat(filepath, filename));
        [Skel_img, Sig_img, Lic_img] = process_test_license(I);
        horiz_feat = HorizontalFeat(Skel_img);
        vert_feat = VerticalFeat(Skel_img);
        Test_feat = [vert_feat; horiz_feat];
        
        Total_feat = get_all_feat(main_dir);
        
        files = dir(fullfile(strcat(main_dir, '\', 'Skel_img/'), '*.png'));
        no_files = size(files, 1);
        x = 1;
        match = struct;
        approx = struct;
        i = 1;
        j = 1;
        
        prompt = {'Enter minimum threshold:','Enter maximum threshold:'};
        dlgtitle = 'Input';
        dims = [1 35];
        definput = {'0.94','0.98'};
        answer = inputdlg(prompt,dlgtitle,dims,definput);
        
        for n = 1:1:no_files
            % Gets file name
            nam = char(files(n).name);
            % Delete file extention
            ln_nm = size(nam, 2)-15;
            nam = nam(1, 1:ln_nm);
            
            corr_x = corr(Test_feat(1:62, 1), Total_feat(x:(x+61), 1));
            corr_y = corr(Test_feat(1:62, 2), Total_feat(x:(x+61), 2));
            
            %             corr_v_x = corr(Test_feat(1:15, 1), Total_feat(x:(x+14), 1));
            %             corr_v_y = corr(Test_feat(1:15, 2), Total_feat(x:(x+14), 2));
            %             corr_h_x = corr(Test_feat(15:30, 1), Total_feat((x+14):(29+x), 1));
            %             corr_h_y = corr(Test_feat(15:30, 2), Total_feat((x+14):(29+x), 2));
            
            %             corr_mat = [corr_v_x, corr_v_y; corr_h_x, corr_h_y];
            corr_mat = [corr_x, corr_y];
                
            thresh_min = str2num(answer{1});
            thresh_max = str2num(answer{2});
            
            if corr_mat(:) >= thresh_max
            match.img{i} = strcat(main_dir, '\', 'Lic_img/', nam, '.png');
            match.corr{i} = mean(corr_mat(:));
            i = i + 1;
            end
            
            if  corr_mat(:) >= thresh_min & corr_mat(:) < thresh_max
                approx.img{j} = strcat(main_dir, '\', 'Lic_img/', nam, '.png');
                approx.corr{j} = mean(corr_mat(:));
                j = j + 1;
            end
            
            x = x + 62;
            
        end
        
        if ~isempty(fieldnames(match))
            [~, n] = size(match.img);
            for i = 1:n
                subplot(2,n,1)
                imshow(Lic_img)
                title('Test card')
                subplot(2,n,i+1)
                imshow(match.img{i})
                title(['Card matched with ',num2str(match.corr{i}),' correlation'])
            end
        else
            subplot(2,1,1)
            imshow(Lic_img)
            title('Test card')
            subplot(2,1,2)
            imshow('X.jpg')
            title('No match found')
        end
        
        if ~isempty(fieldnames(approx))
            [~, q] = size(approx.img);
            z = ceil(q/2);
            figure;
            for i = 1:q
                subplot(2,z,i)
                imshow(approx.img{i})
                title(['Card matched with ',num2str(approx.corr{i}),' correlation'])
            end
        end
        
        r = match;
        t = approx;
    else
        r = 0;
        t = 0;
    end
end
end