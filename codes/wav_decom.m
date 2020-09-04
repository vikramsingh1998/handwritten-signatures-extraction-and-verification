function output_img = wav_decom(I)

% WAV_DECOM Decompose the binarized input image using two level Haar  
% Wavelet Decompostion.

% B = wav_decom(I) computes the two level decomposition of input binarized 
% image I and returns only the approximation coefficient of the decomposed 
% image.

%filter_img = filter_im(I);

J = im2uint8(I);

[c,s] = wavedec2(J,4,'db1');

[H1,V1,D1] = detcoef2('all',c,s,1);

A1 = appcoef2(c,s,'db1',1);

output_img = A1;

% subplot(2,1,1)
% imshow(I)
% title('Original Signature')

% subplot(3,1,2)
% imshow(filter_img)
% title('Filtered input image')

% subplot(2,1,2)
% imshow(output_img)
% title('Approximation coefficient(A1)')

end
