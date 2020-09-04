function [out_skel out_sig out_lic] = process_test_license(I)


%% Extract License

img1 = I(:, 80:end, :);
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
out_lic = img1(cut:ls, inf:sup, :);

%% Extract Signature

[q, v] =  size(out_lic);

y1 = round((0.4116*v)/100);
y2 = round((11.2*v)/100);

I_vert = out_lic(round(0.7*q):end,y1:y2);
I_vert = imadjust(I_vert);
[p, r] = size(I_vert);
I_binarize = imbinarize(I_vert,'adaptive', 'ForegroundPolarity','dark','Sensitivity',0.4);
I_binarize = filter_im(I_binarize);
b = 1;
Y = [];

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

out_sig = minsqr(new_img);
%% Resize
out_sig = imresize(out_sig,[165, 500]);
%% Extract Skeleton
decom_img = wav_decom(out_sig);

compl_img = imcomplement(decom_img);

logical_img = imbinarize(compl_img);

skeleton_img = bwskel(logical_img,'MinBranchLength',0);

output_img = imcomplement(skeleton_img);

out_skel = minsqr(output_img);

end
