function y=lagrange(x0,y0,x,flagship,NENE)
n=length(x0);
m=length(x);

for i=1:m
    z=x(i);
    s=0.0;
    for k=1:n
        p=1.0;
        for j=1:n
            if j~=k
                p=p*(z-x0(j))/(x0(k)-x0(j));
            end
        end
        s=p*y0(k)+s;
    end
    y(i)=s;
end

if (flagship ~= NENE)
    ind = length(y);
    y = y(1:(ind-1));
end