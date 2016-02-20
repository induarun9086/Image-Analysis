    function median = myMedian(M)
        B = sort(M,1);
        [r,c] = size(B);

        median = zeros(r,1);

        for i=1:c
            if mod(r,2) ==0
              index = r/2;
              median(i) = (B(index,i) + B(index+1,i))/2; 

            else
               index = (r+1)/2;
               median(i) = B(index,i);
            end
        end
    end