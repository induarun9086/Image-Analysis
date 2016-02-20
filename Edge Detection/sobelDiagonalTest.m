function sobelDiagonalTest()
    I1 = triu(ones(64,64),1);
    I2 = fliplr(I1');
    I3 = tril(ones(64,64),-1);
    I4 = fliplr(I3');
    I12 = horzcat(I1,I2);
    I34 = horzcat(I4,I3);
    I = vertcat(I12,I34);
    w = [0,4,8;-4,0,4;-8,-4,0];
    gx = imfilter(I, w, 'corr', 'replicate', 'same');
    resultImage = imadjust(mat2gray(gx),[0,0.99],[0,1]);
    imshow(resultImage);


end