function y = f(x1, x2)
bigR = 0.5;
smallr=0.3;
p=10;
if abs(bigR - sqrt(x1^2+x2^2)) <= smallr
    y = p;
else 
    y = 0;
end
end
