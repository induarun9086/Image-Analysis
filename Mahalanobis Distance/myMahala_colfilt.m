function mahadist = myMahala_colfilt(M)
    [r,c] = size(M);
    if mod(r,2) ==0
      rc = r/2 ; 
    
    else
        rc = (r+1)/2 ;
    end
    mahadist = zeros(r,1);
    for i=1:c
        V = double(M(:,i));
        I = double(M(rc,i));
        miu = mean(V); 
        sd = std(V);
        if(sd == 0)
            mahadist(i) = 0;
        else
            mahadist(i) = (I - miu) / sd;
        end

    end
end