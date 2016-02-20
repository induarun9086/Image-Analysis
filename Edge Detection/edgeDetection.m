function edgeDetection()
    I = imread('spiderman.jpg');
    I1 = edge(I,'Sobel');
    I2 = edge(I,'Prewitt');
    I3 = edge(I,'Roberts');
    I4 = edge(I,'log');
    I5 = edge(I,'Canny');
    I6 = edge(I,'zerocross');
    
    figure(1);
    imshow(mat2gray(I)),title('Original Image');
    figure(2);
    imshow(mat2gray(I1)),title('Sobel filtering');
    figure(3);imshow(mat2gray(I2)),title('Prewitt filtering');
    figure(4);imshow(mat2gray(I3)),title('Roberts filtering');
    figure(5);imshow(mat2gray(I4)),title('Log filtering');
    figure(6);imshow(mat2gray(I5)),title('Canny filtering');
    figure(7);imshow(mat2gray(I6)),title('Zero Crossing filtering');
       
end