function a_localiser()

    I = imread('text_test.jpg');
    figure (1), imshow(I);
    
    hold on;
    filteredImage = imsharpen(I);
    adjustedImage = imadjust(filteredImage,[0,0.69],[0,1],1);
    filteredImage1 = imsharpen(adjustedImage);
    adjustedImage1 = imadjust(filteredImage1,[0,0.96],[0,1],1);

    gaussianFilter = fspecial('gaussian',10,1);
    adjustedImage2 = imfilter(adjustedImage1,gaussianFilter,'same','circular','conv');
    
    thresh = quantile(adjustedImage2(:), 0.18);
    binarisedImage = adjustedImage2 < thresh;
    
    t1 = bwmorph(binarisedImage, 'thick', 1);
    
    [L, n] = bwlabel(t1, 4);
    
    Ia = rgb2gray(imread('t1.jpg'));
    Iba = Ia > 220;
    
    thresholdVector = zeros(1,n); 
    letter_count_row_size = zeros(1,n);
    letter_count_column_size = zeros(1,n);

     for K = 1:n
        Lb = (L == K); % localize object k
        [r, c] = find(L == K); % find indices (row, col) of all its pixels 
        Lb_crop = double(Lb(min(r):max(r), min(c):max(c))); % crop object
        corrRes = imfilter(Lb_crop, double(Iba), 'same', 0, 'corr'); 
        
        thresholdVector(K) = quantile(corrRes(:), 0.99);
        letter_count_row_size(K) = size(Lb_crop,1);
        letter_count_column_size(K) = size(Lb_crop,2);
     end
     
    threshold = quantile(thresholdVector(:), 0.94);
    letter_count_thresh1 = quantile(letter_count_row_size(:), 0.205);
    letter_count_thresh2 = quantile(letter_count_column_size(:), 0.19);
           
    letter_count = 0;
    for K = 1:n
        Lb = (L == K); % localize object k
        [r, c] = find(L == K); % find indices (row, col) of all its pixels 
        Lb_crop = double(Lb(min(r):max(r), min(c):max(c))); % crop object
        
        %subplot(ceil(n/10),10,K),imshow(Lb_crop);
        if((size(Lb_crop,1) > letter_count_thresh1) & (size(Lb_crop,2) > letter_count_thresh2));
            letter_count = letter_count + 1;
        end
        corrRes = imfilter(Lb_crop, double(Iba), 'same', 0, 'corr');        
        thresh1 = quantile(corrRes(:), 0.99);
        if thresh1 > threshold
            r_mean = mean(r);
            c_mean = mean(c);    
            figure(1);
            plot(c_mean, r_mean, 'Marker', 'o', 'MarkerEdgeColor', 'r', ...
                'MarkerFaceColor', 'r', 'MarkerSize', 10);   
        end
    end
    
    disp(letter_count);
end