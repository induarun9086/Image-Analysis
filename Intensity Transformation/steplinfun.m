function steplinfun(x,x1,x2,y1,y2)
    %100 200 100 150
    %Read the image 
    I = imread('LumbarSpineCT.jpg');

    %Define range for x coordinates
    x_r = 0:x;
    x_r1 = (x+1):x1;
    x_r2 = (x1+1):x2;
    x_r3 = (x2+1):255;

    %find slope for the points
    a = 0;
    a1 = y1/(x1-x);
    a2 = double((y2-y1)/(x2-x1));
    a3 = double((255-y2)/(255-x2));

    yo = floor(a*x_r);
    yo_1 = floor(a1*(x_r1-x));
    yo_2 = floor(y1 + (a2*(x_r2-x1)));
    yo_3 = floor(y2 + (a3*(x_r3-x2)));

    % line concatance
    y = [yo yo_1 yo_2 yo_3];

    % plot line
    figure(1),plot(y);
    

    %Define a mask for different lines
    mask = double(I<=x);
    mask_1 = double((I>x)&(I<=x1));
    mask_2 = double((I>x1)&(I<=x2));
    mask_3 = double(I>x2);
    
    %multiply the masks with the lines
    im = mask.*double(floor(a*I));
    im1 = mask_1.*double(floor(a1*(I-x)));
    im2 = mask_2.*double(floor(y1 + (a2*(I-x1))));
    im3 = mask_3.*double(floor(y2 + (a3*(I-x2))));
    
    %Add the outcome after applying masks
    I_new = cast(im+im1+im2+im3,'uint8');

     %Plot the images
    subplot(1,3,1), subimage(I),title('Original Image'); v = axis;
    subplot(1,3,2), plot(y),xlim([0 255]),ylim([0 255]),title('Transfer function');
    subplot(1,3,3), subimage(I_new),title('Adjusted Image'); axis(v); 

end