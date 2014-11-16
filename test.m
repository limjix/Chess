function test

for i = 1 : 10
    disp('i')
    disp(i)
    for j = 1 : 10
        disp('j')
        disp(j)
        if j ==5
            flag = 1;
            break
        end
    end
    if flag
        break
    end
end