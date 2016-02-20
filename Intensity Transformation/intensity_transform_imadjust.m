function intensity_transform_imadjust()
   
    %Read the image 
    I = imread('LumbarSpineCT.jpg');
    
    %Apply imadjust with optimal values
    I_new = imadjust(I,[0.3 0.8],[0 1],0.9);
    
    %Plot the images
    subplot(1,2,1), subimage(I),title('Original Image'); v = axis;
    subplot(1,2,2), subimage(I_new),title('Adjusted Image'); axis(v);    
end