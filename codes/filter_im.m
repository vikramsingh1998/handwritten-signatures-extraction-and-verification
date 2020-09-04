function output_img = filter_im(img)

% FILTER_IM Remove the small noises from the binarized image.

% B = filter_im(A) computes the binarized image free from small noises.

    max_A = size(img, 1)*size(img, 2);
    
    min_A = max_A * (0.006 / 100);
    
    bw = bwareafilt(not(img),[min_A, max_A]);
    
    output_img = not(bw);

end