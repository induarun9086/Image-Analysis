function filterOperations()

    sample_image = zeros(2,2);
    sample_image(1,:) = 1;
    sample_image(2,:) = -1;
     
    original_image = repmat(sample_image,10,10);
    
    filter1=[-1/3,1/3,-1/3;1/3,-1/3,1/3;-1/3,1/3,-1/3];
    image1 = imfilter(original_image,filter1,'circular','same','corr');
        
    inverse_filter=[1/3,1/3,1/3;1/3,1/3,1/3;1/3,1/3,1/3];
    inverse_filtered_image = imfilter(original_image,inverse_filter,'circular','same','corr');
    
    gray_value_filter = [0,-1,0; -1,0,-1; 0,-1,0];    
    gray_value_filtered_image = imfilter(original_image,gray_value_filter,'circular','same','corr');
    
    averaging_filter = [1/9,1/9,1/9;1/9,1/9,1/9;1/9,1/9,1/9];
    average_filtered_image = imfilter(original_image,averaging_filter,'circular','same','corr');

   
    figure(1);imshow(mat2gray(original_image)),title('Original Image');
    figure(2);imshow(mat2gray(image1)),title('Image');    
    figure(3);imshow(mat2gray(inverse_filtered_image)),title('Inverse Image');
    figure(4);imshow(mat2gray(gray_value_filtered_image),[-1,1]),title('Gray Value Image');  
    figure(5);imshow(mat2gray(average_filtered_image)),title('Average Value Image');    

    
end

