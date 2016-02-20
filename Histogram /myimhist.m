function myimhist(bin)

    %Read the image
    RGB = imread('pout_equalized.jpg');
       
    %Convert the rgb image to gray
    I  = rgb2gray(RGB);
    
    
    % Find the maximum intensity of the image
    maximum_intensity = double(max(I(:)));
    
    bin_ratio = (maximum_intensity +1)/bin;

    
    % Convert image matrix into a vector
    B = double(I(:));

    len = length(B);
    
    count = zeros(1,bin);

    %Find the count of different pixel values 
    for i=1:len
        
         grayvalue = B(i);
         
         value = floor((grayvalue/bin_ratio) +1);
       
         index = min(value,bin);
        
         count(index) = count(index) + 1;
                                            
    end
    
    x = 0: bin_ratio : maximum_intensity;
        
    logicalImage = imageSeperation(I);
    
    subplot(1,3,1), imshow(I),title('Original Image');
    subplot(1,3,2), stem(x,count),title('Histogram');
    subplot(1,3,3), imshow(logicalImage),title('Logical Image');
    
end

function logicalImage = imageSeperation(I)
    logicalImage = I;
    logicalImage = logicalImage >= 100;
    
end

