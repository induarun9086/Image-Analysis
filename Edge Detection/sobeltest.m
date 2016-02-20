function sobeltest()
    I1 = ones(128);
    I2 = zeros(128);
    I12 = horzcat(I1,I2);
    I21 = horzcat(I2,I1);
    I = vertcat(I12,I21);
    w = fspecial('sobel')';
    gx = imfilter(I, w, 'corr', 'replicate', 'same');
    imshow(mat2gray(gx));

end