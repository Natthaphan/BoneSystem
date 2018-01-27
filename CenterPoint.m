function [xpoint , ypoint] = CenterPoint( img )

x=0;
y=0;

[m,n] = size(img);
px = zeros(m);
py = zeros(n);


for i=1:m
    for j=1:n
        if img(i,j)==1
            px(i) = int32(px(i)) +1;
        end
    end
end

for i=1:n
    for j=1:m
        if img(j,i)==1
            py(i) = int32(py(i)) +1;
        end
    end
end

for i=1:m
    x = int32(x+(px(i)*i));
end

for i=1:n
    y = int32(y+(py(i)*i));
end


  x = int32(x/AreaBi(img));
  y = int32(y/AreaBi(img));

  xpoint = x;
  ypoint = y;

end

