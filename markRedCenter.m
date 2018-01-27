function [ img ] = markRedCenter( im,point,num)

R = im(:,:,1);
G = im(:,:,2);
B = im(:,:,3);


[m,n] = size(R);

      for i=1:m
          
         for j=1:n
             for k=1:num
                if (point(k,1)==i) && (point(k,2)==j);
                    R(i,j) = 255;             
                    R(i,j+1) = 255;
                    R(i,j-1) = 255;
                    
                    R(i+1,j) = 255;
                    R(i+1,j-1) = 255;
                    R(i+1,j+1) = 255;
                    
                    R(i-1,j) = 255;
                    R(i-1,j-1) = 255;
                    R(i-1,j+1) = 255;
                    
                    R(i,j) = 255;             
                    R(i,j+2) = 255;
                    R(i,j-2) = 255;
                    
                    R(i+1,j) = 255;
                    R(i+1,j-2) = 255;
                    R(i+1,j+2) = 255;
                    
                    R(i-1,j) = 255;
                    R(i-1,j-2) = 255;
                    R(i-1,j+2) = 255;
                    
                              
                    
                    
                    
%                   G(i,j) = 0;
                    G(i,j) = 0;             
                    G(i,j+1) = 0;
                    G(i,j-1) = 0;
                    
                    G(i+1,j) = 0;
                    G(i+1,j-1) = 0;
                    G(i+1,j+1) = 0;
                    
                    G(i-1,j) = 0;
                    G(i-1,j-1) = 0;
                    G(i-1,j+1) = 0;
                    
                    G(i,j) = 0;             
                    G(i,j+2) = 0;
                    G(i,j-2) = 0;
                    
                    G(i+1,j) = 0;
                    G(i+1,j-2) = 0;
                    G(i+1,j+2) = 0;
                    
                    G(i-1,j) = 0;
                    G(i-1,j-2) = 0;
                    G(i-1,j+2) = 0;

                    
                    
                    B(i,j) = 0;             
                    B(i,j+1) = 0;
                    B(i,j-1) = 0;
                    
                    B(i+1,j) = 0;
                    B(i+1,j-1) = 0;
                    B(i+1,j+1) = 0;
                    
                    B(i-1,j) = 0;
                    B(i-1,j-1) = 0;
                    B(i-1,j+1) = 0;
                    
                    B(i,j) = 0;             
                    B(i,j+2) = 0;
                    B(i,j-2) = 0;
                    
                    B(i+1,j) = 0;
                    B(i+1,j-2) = 0;
                    B(i+1,j+2) = 0;
                    
                    B(i-1,j) = 0;
                    B(i-1,j-2) = 0;
                    B(i-1,j+2) = 0;

                end
             end
         end
         
      end
     im(:,:,1) = R;
     im(:,:,2) = G;
     im(:,:,3) = B; 
     
     img = im;
      
end

