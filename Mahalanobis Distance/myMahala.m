function mahadist = myMahala(M)

    %M =[1 2 3; 2 0 5; 3 5 8];

    [r,c] = size(M);

    if mod(r,2) ==0
      rc = r/2 ; 
    
    else
        rc = (r+1)/2 ;
    end
    
    if mod(c,2) ==0
      cc = c/2 ; 
    else
        cc = (c+1)/2 ;
    end
    I = double(M(rc,cc));

    V = double(M(:));

    miu = mean(V); 
    
    sd = std(V);
    

    if(sd == 0)
            mahadist = 0;
        else
            mahadist = (I - miu) / sd;
    end
 
end