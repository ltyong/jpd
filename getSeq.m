function [y, K] = getSeq(I, c1, c2, c3, c4)
    [x1, x2, x3, x4] = gen_chaos_init(I, c1, c2, c3, c4);
    chaoslen = 320000 * size(I, 3);
    [y, K]=generateChaoticSequence(@lu4,chaoslen,500,[x1 x2 x3 x4],0.001);
end