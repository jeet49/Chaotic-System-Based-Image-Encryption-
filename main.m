
Img1 = imread('plain_image.jpg');
Img2 = imread('panipuri.jpg');
Img3 = imread('chhole.jpg');
img4 = imread('dada.jpg');
Imagecell=cell(1,4);
Imagecell{1} = Img1;
Imagecell{2} = Img2;
Imagecell{3}=Img3(1:256,1:256);
Imagecell{4}=img4;

for i = 1:1
    Img = Imagecell(i);
    Img = cell2mat(Img);
      
T = im2double(Img);
[A,B] = size(T);
A=A-mod(A,8);
B=B-mod(B,8);
T=T(1:A,1:B);
plainimg_dct = T;

secret_key  = 0.88;

%%encryption
T = T*255-128;
 actual_dct=dct(T);
actual_dct= round (actual_dct*0.5);


encrypted= encrypt(actual_dct,secret_key);

% add noise

[encrypted_norm,settings]=mapminmax(encrypted,0,1);
 encrypted_after_noise = imnoise(encrypted_norm,'salt & pepper');
 encrypted_after_noise = mapminmax.reverse(encrypted_after_noise,settings);
 encrypted_after_noise= imrotate(encrypted_after_noise,180);

% added gaussian noise on scramble image

dec_after_scramble = decrypt(encrypted,secret_key);
dec_after_scramble = dec_after_scramble/0.5;
decreption_result = idct(dec_after_scramble);

  [plainimg_dct_norm,settings]=mapminmax(actual_dct,0,1);
   plainimg_dct_afternoise = imnoise(plainimg_dct_norm,'gaussian');
    plainimg_dct_afternoise = mapminmax.reverse(plainimg_dct_afternoise,settings);
    plainimg_dct_afternoise= plainimg_dct_afternoise/0.5
    plainimg_dct_afternoise =idct(plainimg_dct_afternoise);
    plainimg_dct_afternoise= imrotate(plainimg_dct_afternoise,180);

      plainimg_dct_afternoise =  (plainimg_dct_afternoise+128)/255;



 
decreption_result= (decreption_result+128)/255;

% display all images
subplot(4,3,(i-1)*3+1),subimage(plainimg_dct),title('plain image');
subplot(4,3,(i-1)*3+2),subimage(encrypted),title('encrypted image');
subplot(4,3,(i-1)*3+3),subimage(decreption_result),title('decrypted image');

 
%  histogram for images
[counts,binLocations] = imhist(plainimg_dct);
subplot(4,3,(i-1)*3+4),bar(binLocations,counts),title('original histogram');
[counts,binLocations] = imhist(encrypted_norm);
subplot(4,3,(i-1)*3+5),bar(binLocations,counts),title('encrypted histogram');
[counts,binLocations] = imhist(decreption_result);
subplot(4,3,(i-1)*3+6),bar(binLocations,counts),title('decrypted histogram');

end

