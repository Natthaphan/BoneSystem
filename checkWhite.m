function  num  = checkWhite( im )

    pix = 0;
    pix = int32(pix);
    
        [m,n] = size(im);
        for i=1:m
           for j=1:n
               if im(i,j) > 200
                  pix = pix+1; 
               end
           end
        end
   num = pix;

end

