img1 = imread('Test/tri8.jpg');
img1 = rgb2gray(img1);
img1 = imbinarize(img1);
% imshow(img1)

% decom_img = wav_decom(img1);
% 
% compl_img = imcomplement(decom_img);

compl_img = imcomplement(im2uint8(img1));
% 
logical_img = imbinarize(compl_img);

skeleton_img = bwskel(logical_img,'MinBranchLength',0);
% skeleton_img = bwmorph(logical_img,'skel',100);
output_img = imcomplement(skeleton_img);
% imshow(output_img)
output_img = minsqr(output_img);
% output_img = imbinarize(skeleton_img);
figure
imshow(output_img)