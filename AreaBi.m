function area = AreaBi( img )
area = 0;
     [m,n] = size(img);
     
     for i=1: m
         for j=1:n
             if img(i,j)==1
                 area = int32(area)+1;
             end
         end
     end
end

