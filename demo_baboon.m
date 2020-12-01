clear all;

I = imread('baboon.tiff');
if exist('./baboon') == 0
    mkdir('./baboon');
end

imwrite(I, './baboon/baboon.tiff');

imwrite(I(:, :, 1), './baboon/baboon_r.tiff');
imwrite(I(:, :, 2), './baboon/baboon_g.tiff');
imwrite(I(:, :, 3), './baboon/baboon_b.tiff');

b1 = 1;
b2 = 1;
b3 = 2;
b4 = 2;
[y, K] = getSeq(I, b1, b2, b3, b4);

C = jpd_encrypt(I, y);

imwrite(C(:, :, 1), './baboon/baboon_en_r.tiff');
imwrite(C(:, :, 2), './baboon/baboon_en_g.tiff');
imwrite(C(:, :, 3), './baboon/baboon_en_b.tiff');

imwrite(C, './baboon/baboon_en.tiff');

D = jpd_decrypt(C, y);

imwrite(D(:, :, 1), './baboon/baboon_de_r.tiff');
imwrite(D(:, :, 2), './baboon/baboon_de_g.tiff');
imwrite(D(:, :, 3), './baboon/baboon_de_b.tiff');

imwrite(D, './baboon/baboon_de.tiff');
