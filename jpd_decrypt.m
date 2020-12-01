function D = jpd_decrypt(I,K)
    I = double(I);
    K = double(K);
    D = uint8(I);
    ep = 0;
    [h, w, c] = size(I);
    for i = 1: c
        sp = ep + 1;
        ep = sp + (4 + w) * w - 1;
        D(:, :, i) = uint8(jpd(I(:, :, i), K(sp:ep), 'de', 2));
    end
end