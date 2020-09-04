## handwritten-signatures-extraction-and-verification

The aim of the project is:
- to extract the signatures from the license cards
- to skeletonize the extracted signatures
- to create a program that can verify a signature whether it exists in the database provided or not


# Getting started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.


# Prerequisites

- MATLAB version greater than 2018a (2019a preferred)


# Instructions to run the programs

* In the programs which require main_directory as input, give full path of 'Database' directory as input.

STEP 1 - Extract licences, signatures and skeletonized signatures (if not exists)

- ExtractLicense.m : to extract all the license images from the images provided in the database and store it in Lic_img/ directory

- get_all_sig.m : to extract all the signature images from the license images and store them in the Sig_img/ directory

- resize_all.m : to make the size of all the extracted signatures equal and store the output in the Sig_resimg/ directory

- get_all_skel : to extract the skeleton of the signatures and store them in the Skel_img/ directory

* If the licences, signatures and skeletonized signatures are already extracted then move to STEP 2

STEP 2 - Extract the features of the skeletonized signatures

- get_all_feat.m : to extract all the features from the skeletonized signatures


STEP 3 - Verification

- match.m : run this function, select a test image from the database and give the minimum and maximum value of the threshold you want

- match2.m : run this function, select a test image from the database and give the maximum value of the threshold you want


# Other used programs

- filter_im.m : used to remove small noises from the extracted signatures

- wav_decom : used to remove small noises and redundant pixels from the extracted signatures

- HorizontalFeat.m : used to extract 31 horizontally splitted features per image

- VerticalFeat.m : used to extract 31 vertically splitted features per image


# Authors

- Vikram Singh, Zakir Husain College of Engineering and Technology, Aligarh Muslim University, Aligarh, India

- For any query, send me a mail on vikramverma1997@gmail.com

