function edgeColorCode()
    % Read the image
    rgbImage = imread('dew.jpg');
    
    %Apply gaussian filter
    gaussian_filter = fspecial('gaussian');
    
    gA = rgb2gray(imfilter(rgbImage, gaussian_filter));
    
    A = rgb2gray(rgbImage);
    
    %Apply sobel filter and find x and y gradients
    [Gx,Gy] = imgradientxy(A,'sobel');
    
    %Compute magnitude and direction
    [magnitude, Gdir] = imgradient(Gx, Gy);
    
    % Get threshold  value where 2% of magnitude lies
    thresh = quantile(A(:), 0.98);
    
    %Apply the computed threshold
    Gmag = magnitude > thresh;
        
    % find the magnitude and direction for gaussian filtered image as well
    [Gfx,Gfy] = imgradientxy(gA,'sobel');
    [Gfmagnitude, Gfdir] = imgradient(Gfx, Gfy);
    
    Gfmag = Gfmagnitude > thresh;
    
    % Filter only the edges in direction (90 +/- 22.5 or -90 +/- 22.5 degrees)
    EdgeV = Gdir;
    EdgeV = (((EdgeV >= -22.5) & (EdgeV <= 22.5)) | ((EdgeV >= 157.5) & (EdgeV <= 202.5))) .* Gmag;
    
    EdgeVGaussian = Gfdir;
    EdgeVGaussian = (((EdgeVGaussian >= -22.5) & (EdgeVGaussian <= 22.5)) | ((EdgeVGaussian >= 157.5) & (EdgeVGaussian <= 202.5))) .* Gfmag;

    % Filter only the edges in direction (0 +/- 22.5 or 180 +/- 22.5 degrees) 
    EdgeH = Gdir;
    EdgeH = ((EdgeH >= 67.5  &  EdgeH <= 112.5) | (EdgeH >= -112.5 & EdgeH <= -67.5)) .* Gmag;

    EdgeHGaussian = Gfdir;
    EdgeHGaussian = (((EdgeHGaussian >= 67.5) & (EdgeHGaussian <= 112.5)) | ((EdgeHGaussian >= -112.5) & (EdgeHGaussian <= -67.5))) .* Gfmag;
     
    % Filter only the edges in direction (45 +/- 22.5 or 225 +/- 22.5 degrees)
    EdgeD1 = Gdir;
    EdgeD1 = ((EdgeD1 >= 22.5  &  EdgeD1 <= 67.5) | (EdgeD1 >= 202.5 & EdgeD1 <= 247.5)) .* Gmag;
    
    EdgeD1Gaussian = Gfdir;
    EdgeD1Gaussian = (((EdgeD1Gaussian >= 22.5) & (EdgeD1Gaussian <= 67.5)) | ((EdgeD1Gaussian >= 202.5) & (EdgeD1Gaussian <= 247.5))) .* Gfmag;

     % Filter only the edges in direction  (-45 +/- 22.5 or 135 +/- 22.5 degrees)
    EdgeD2 = Gdir;
    EdgeD2 = ((EdgeD2 >= -67.5  &  EdgeD2 <= -22.5) | (EdgeD2 >= 112.5 & EdgeD2 <= 157.5)) .* Gmag;

    EdgeD2Gaussian = Gfdir;
    EdgeD2Gaussian = (((EdgeD2Gaussian >= -67.5) & (EdgeD2Gaussian <= -22.5)) | ((EdgeD2Gaussian >= 112.5) & (EdgeD2Gaussian <= 157.5))) .* Gfmag;

    %Apply color coding for edges
    rA = rgbImage();
    rA(:, :, 1) = EdgeD1 + EdgeH;
    rA(:, :, 2) = EdgeD2 + EdgeH;
    rA(:, :, 3) = EdgeV;
    
    rAGaussian = rgbImage();
    rAGaussian(:, :, 1) = EdgeD1Gaussian + EdgeHGaussian;
    rAGaussian(:, :, 2) = EdgeD2Gaussian + EdgeHGaussian;
    rAGaussian(:, :, 3) = EdgeVGaussian;

    %Plot the images
    subplot(1,3,1),imshow(mat2gray(rgbImage)),title('Original Image');
    subplot(1,3,2),imshow(mat2gray(rA)),title('without gaussian smoothing');
    subplot(1,3,3),imshow(mat2gray(rAGaussian)),title('with gaussian smoothing');

end
