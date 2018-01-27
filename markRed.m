function [ img ] = markRed( im )

R = im(:,:,1);
G = im(:,:,2);
B = im(:,:,3);

[m,n] = size(R);

      for i=1:m
          
         for j=1:n
             if R(i,j)==255;
                R(i,j) = 255;
                G(i,j) = 0;
                B(i,j) = 0;
             end
         end
         
      end
     im(:,:,1) = R;
     im(:,:,2) = G;
     im(:,:,3) = B; 
     
     img = im;
      
end

