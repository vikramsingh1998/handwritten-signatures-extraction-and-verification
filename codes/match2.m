function [r, cor] = match2(main_dir)
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
        i = 1;
        j = 1;
        cor_match = [];
        
        prompt = {'Enter the threshold value:'};
        dlgtitle = 'Input';
        dims = [1 35];
        definput = {'0.98'};
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
            
            avg_corr = mean(corr_mat(:));
            
            cor.valx{n} = corr_mat(1);
            cor.valy{n} = corr_mat(2);
            cor.avg{n} = avg_corr;
            cor.img{n} = strcat(main_dir, '\', 'Lic_img/', nam, '.png');
            
            x = x + 62;
            
        end
        thresh = str2num(answer{1});
        cor_mat = cell2mat(cor.avg);
        cor_match = find(cor_mat>=thresh);
        x = 1;
        if ~isempty(cor_match)
            [~, n] = size(cor_match);
            for i = 1:n
                subplot(2,n,1)
                imshow(Lic_img)
                title('Test card')
                subplot(2,n,i+1)
                imshow(cor.img{cor_match(x)})
                %                 title(['Card matched with ',num2str(cor.avg{cor_match(x)}),'% correlation'])
                title('Card matched with the test card')
                cor.avg{cor_match(x)} = 0;
                x = x+1;
            end
        else
            subplot(2,1,1)
            imshow(Lic_img)
            title('Test card')
            subplot(2,1,2)
            imshow('X.jpg')
            title('No match found')
        end
        
        cor_mat = cell2mat(cor.avg);
        [u, v] = max(cor_mat);
        min_v = min(cor.valx{v},cor.valy{v});
        cor_mat(v) = 0;
        [t, s] = max(cor_mat);
        min_s = min(cor.valx{s},cor.valy{s});
        
        figure
        subplot(2,1,1)
        imshow(cor.img{v})
        %         title(['2nd best match with ',num2str(min_v),'% correlation'])
        title('2nd best match with the test card')
        subplot(2,1,2)
        imshow(cor.img{s})
        title(['3rd best match with ',num2str(min_s),'% correlation'])
        r = 1;
    else
        r = 0;
    end
end
end