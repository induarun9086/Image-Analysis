function bubbleLocaliser()
    % Read the image
    I = double(imread('bubbles.jpg'));
        
    diskRadius = 21.5;
    
    % generate disk1 of diameter 43
    circular_disk1 = fspecial('disk',diskRadius);
    ones1 = ones(size(circular_disk1),'double');
    circular_disk1 = circular_disk1 .* (ones1 * (diskRadius-2.5)*2) * ((diskRadius-2.5)*2);
   
    % generate disk2 of diameter 40
    circular_disk2 = fspecial('disk',(diskRadius-1.5));
    ones2 = ones(size(circular_disk2),'double');
    circular_disk2 = circular_disk2 .* (ones2 * ((diskRadius-2.5)*2) * ((diskRadius-2.5)*2));
    
    padSize = ((size(circular_disk1) - size(circular_disk2))/2);
    
    circular_disk2_padded = padarray(circular_disk2, padSize);
    
    % Subtract disk2 from disk1 to generate the required filter
    inverse_circular_disk2 = (ones((diskRadius*2),(diskRadius*2),'double') - (circular_disk2_padded));
    
    resultant_filter = circular_disk1.*inverse_circular_disk2;
    
    % Apply correlation filter on the image
    corr_filtered_image = imfilter(I,resultant_filter,'circular','same','corr');
    corr_filtered_image = corr_filtered_image.^20;
    
    % Apply convolution filter on the image
    conv_filtered_image = imfilter(I,resultant_filter,'circular','same','conv');
    conv_filtered_image = conv_filtered_image.^20;
        
    %Apply bubble representative to the image
    bubble_filter = double(imread('bubble_representative.jpg'));
    filtered_image = imfilter(I,bubble_filter,'circular','full','corr');
    
    subplot(3,5,[1 2 6 7 11 12]),imshow(mat2gray(I)), title('Original Image');
    subplot(3,5,8),imshow(mat2gray(bubble_filter)), title('Filter');
     subplot(3,5,[4 5 9 10 14 15]),imshow(mat2gray(filtered_image)), title('Filtered Image using Bubble Representative');
    
%       figure(1);imshow(mat2gray(I)), title('Original Image');
%       figure(2);imshow(mat2gray(bubble_filter)), title('Filter');
%       figure(3);imshow(mat2gray(corr_filtered_image)), title('Filtered Image using correlation and applying exp weighting');
%       figure(4);imshow(mat2gray(conv_filtered_image)), title('Filtered Image using convolution and applying exp weighting');
%       figure(5);imshow(mat2gray(filtered_image)), title('Filtered Image using Bubble Representative');

end