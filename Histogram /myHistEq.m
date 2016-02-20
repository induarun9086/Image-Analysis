function myHistEq(image)
 
    %Read the image
    rgbImage = imread(image);
    I = rgb2gray(rgbImage);
    
    tic;
   
    %Find the information and then compute bit depth
    info = imfinfo(image);
    bitdepth = info.BitDepth / info.NumberOfSamples;
    
    %Find the maximum possible intensity for the computed bitdepth
    maximum_intensity = power(2,bitdepth);
     
    %Convert the image matrix to a vector
    B = double(I(:));
    len = length(B);
    
    %Initialize count and normalised count
    count = zeros(1,maximum_intensity);
    normalised_count = zeros(1,maximum_intensity);
    
    %Find the count of different pixel values and 
    %normalise the count 
    for i=1:len
        
        value = B(i);
        
        count(value+1) = count(value +1) +1;
        
        normalised_count(value+1) = count(value+1) / len;
            
    end
    
    %Initialise vector for normalisation and cumulative sum
    cumulative_sum = zeros(1,maximum_intensity);
    
    sum = 0;   
    output=zeros(1,maximum_intensity);
 
    %Iterate the count vector,find the cumulative sum
    for i =1:maximum_intensity
        
         sum=sum+normalised_count(i);
 
         cumulative_sum(i)=sum;
         
         output(i)=round(cumulative_sum(i) * maximum_intensity);
                
    end
        
    g=double(zeros(size(I,1),size(I,2)));
 
    %copy vector output to result matrix g             
    for i=1:size(I,1)
 
      for j=1:size(I,2)
 
            g(i,j)=output(I(i,j)+1);
 
      end
 
    end
    
    %Plot the image,transfer function and the adjusted image
    subplot(1,3,1), imshow(I),title('Original image');
    subplot(1,3,2), plot(cumulative_sum),title('Transfer Function');
    subplot(1,3,3), imshow(mat2gray(g)),title('Histogram Equalized image'); 
        
    t1 = toc
    
    tic;
    histeq(I);
    t2 = toc
end
