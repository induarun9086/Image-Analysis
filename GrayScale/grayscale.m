function grayscale(n)
%Creates a grayscale for given bit depth n

    % Initialise column and row size
    count = 2^n;
    colsize=64;
    rowsize=1024;

    % Initialise a matrix for given column and row size
    mat = zeros(colsize, rowsize);

    for i=1:colsize
        row = zeros(1,rowsize);
        for j=1:rowsize
            row(j) = uint32(floor(((j-1)*count)/rowsize));
        end
        mat(i, :) = row;
    end


    img = mat2gray(mat, [0 count]);

    imshow(img);

end

