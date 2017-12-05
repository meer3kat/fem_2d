clear all;
geometry = @circleg;
%{
hmax = 0.1;
[p, e, t] = initmesh(geometry, 'hmax', hmax);



[A, R, b, r] = assemble(p, e, t, @f1, @g1, 1);
%b = load_vector_2d(p, t, @f1);

phi = (A+R)\(b+r);

for i = 1:length(phi)
    solution = g1(p(1,i),p(2,i));
    %sin(2*pi*p(1,i))*sin(2*pi*p(2,i));
    err(i) = solution - phi(i);
end

ene = sqrt(err*A*err');

pdecont(p, t, phi);
%}

for j = 1:5
    h(j) = 1/(2^j);
    [p,e,t] = initmesh(geometry,'hmax', h(j));
    [A, R, b, r] = assemble(p, e, t, @f1, @g1, 1);
    phi = (A+R)\(b+r);
    
    for i = 1:length(phi)
        
        solution= g1(p(1,i),p(2,i));
        err(i) = solution - phi(i);
    
    end
    
    enex = sqrt(err*A*err');
    totalerr(j) = enex;
    %pdesurf(p,t,phi);
    %waitforbuttonpress
 
    
end
