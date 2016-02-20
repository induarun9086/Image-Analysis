function intensity_transform_impulse(m1,m2)
    %102 120
    %Read the image 
    I = imread('LumbarSpineCT.jpg');
    
    %Compute dimensions of the image
    [a,b] = size(I);
    
    I_new = zeros(a,b);
    
     %In new image values > m1 and values < m2 are made 1 and others are set to zero
    for i=1:a
        for j=1:b
            if(I(i,j) > m1 && I(i,j) < m2)
                I_new(i,j) = 1;
            end
        end
    end
    
    %Plot the images
    subplot(1,2,1), subimage(I),title('Original Image'); v = axis;
    subplot(1,2,2), subimage(I_new),title('Adjusted Image'); axis(v); 
    
end