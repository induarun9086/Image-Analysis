function testimfilter()
    image = zeros(7,7);
    value = 1;
    for i = 1:size(image,1)
       for j = 1:size(image,2)
           image(i,j) = value;
            value = value +1;
        end
    end
    display(image);
    %gaussianFilter = [1 -1 3 3 3; -1 5 -1 -1 -1; 0 -1 0 0 0;  0 -1 0 0 0;  0 -1 0 0 0];
    %image = imread('text_test.jpg');
    gaussianFilter = fspecial('laplacian',0.2)
    adjustedImage2 = imfilter(image,gaussianFilter);
        
    filteredImage = image - adjustedImage2
    
   

end