function conv_gray_scale(n)
    
    % Read the image CThead.tif
    I = imread('CThead.tif');
    
    % Get information and bit depth of CThead.tif
    info = imfinfo('CThead.tif');
    bitdepth = info.BitDepth;
    
    %Calculate maximum possible intensity
    maximum_intensity = power(2,bitdepth);
    
    %scale the image to the given bit depth n 
    %and multiply this factor to the image
    g = I * (n/maximum_intensity);
       
    %Plots the original image and the resultant image
    subplot(1,2,1), subimage(I),title('Original Image');  v = axis;
    subplot(1,2,2), subimage(mat2gray(g, [0, n-1])),title('Resultant Image'); axis(v);

end