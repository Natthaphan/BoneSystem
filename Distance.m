function  num = Distance(test,train)

    [m,n] = size(train);
    data = zeros(m,2);
    num = zeros(m,2);
    test = double(test);
    
    for i=1:m
        for j=1:n
            data(i,1)= data(i,1)+(sqrt((train(i,j)-test(1,j))^2));
        end
        data(i,2) = train(i,5);
       
    end
    

    num(:,1) = sort(data(:,1));
    
    for i=1:m
        for j=1:m
            if num(i,1) == data(j,1)
               num(i,2) = data(j,2);
            end
        end
        
    end

    num = num(1,2);
    

end

