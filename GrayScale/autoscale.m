function autoscale()

    I = imread('Pollen_orig.jpg');

    % Histogram stretching factor is 
    %((Each pixel intensity) - (minimum pixel intensity)/
    %(maximum pixel intensity)- (minimum pixel intensity)) * gray level


    % Compute the minimum pixel intensity
    low_in = min(I(:));

    % Compute the maximum pixel intensity
    high_in = max(I(:));

    %Shift all the pixel values to left
    Im  = I - low_in;

    %Find the difference between the max and min pixel intensity
    diff = high_in - low_in;

    % Sretch the histogram with the formula stated above
    g = (double(Im)/double(diff))*256;

    % Plot the original image,resultant image and their histograms
    subplot(2,2,1), subimage(I),title('Original Image');
    subplot(2,2,3), imhist(I),title('Histogram of original Image');
    subplot(2,2,2), subimage(uint8(g)),title('Enhanced Image');
    subplot(2,2,4), imhist(uint8(g)),title('Histogram after Contrast Enhancement');

    
end



