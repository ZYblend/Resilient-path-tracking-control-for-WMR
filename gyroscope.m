function y1 = gyroscope(x)
%gyroscope: for measurement v and w

C=[1,0;
    0,1];
y1=C*x;
end

