function v = myMean(M)
    mn = size(M, 1);
    v = double(sum (M, 1)/mn);
end