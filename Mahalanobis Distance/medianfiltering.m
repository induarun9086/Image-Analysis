function medianFiltering()
          %Read the image
          I = imread('eight.tif');
          %Add salt and pepper noise
          noisy_image = imnoise(I,'salt & pepper',0.02);
          
          tic;
          %use nlfilter in the noisy image
          B = nlfilter(noisy_image,[3 3],@myMahala);
          t1 = toc;
          
          disp(t1);

          m = 3; n = 3;
          
          fp = padarray(noisy_image, [3 3], 'replicate');
          
          tic;
          %use colfilter in the noisy image
          B1 = colfilt(fp, [m n], 'sliding', @myMahala_colfilt);
          t2 =toc;
          
          disp(t2);
          
           %Find threshold where 0.5% strongest outlier pixels
           % with positive Mahalanobis distance lies
           thresh = quantile(B1(:), 0.995);
           
           %Find threshold where 0.5% strongest outlier pixels
           % with negative Mahalanobis distance lies
           thresh1 = quantile(B1(:), 0.005);
           
           B2 = B1;
           %Apply the thresholds
           B2 =  ((B2 > thresh) | (B2 < thresh1)) .*B2;
           
          figure(1);imshow(mat2gray(B2)),title('0.5% strongest outlier pixels ');
           
          %Find outlierness for the colfiltered image
          s = sum(abs(B1(:)));
          
          [r,c] = size(B1);
          
          number_of_pixels = r*c;
          
          outlierness = s/number_of_pixels;
          
          disp(outlierness);
          
          %Apply mean filter
          B3  = double(colfilt(fp, [m n], 'sliding', @myMean));
          
          B4 = double(colfilt(B3, [m n], 'sliding', @myMahala_colfilt));
          
          s = sum(abs(B4(:)));
          
          [r,c] = size(B4);
          
          number_of_pixels = r*c;
          
          mean_outlierness = s/number_of_pixels;
          disp(mean_outlierness);
          
          %Apply median filter
          B5 = double(colfilt(fp, [m n], 'sliding', @myMedian));
          B6 = double(colfilt(B5, [m n], 'sliding', @myMahala_colfilt));
                            
          s = sum(abs(B6(:)));
          
          [r,c] = size(B6);
                    
          number_of_pixels = r*c;
          
          median_outlierness = s/number_of_pixels;
          disp(median_outlierness);          
          
          figure(1);imshow(I),title('Original Image');
          figure(2);imshow(noisy_image),title('Noisy Image');
          figure(3);imshow(mat2gray(B)),title('using Mahalanobis filter nlfilt');
          figure(4);imshow(mat2gray(B1)),title('using Mahalanobis filter colfilt');
          figure(5);imshow(mat2gray(B3)),title('using mean filter colfilt');
          figure(6);imshow(mat2gray(B4)),title('using median filter colfilt');

end



