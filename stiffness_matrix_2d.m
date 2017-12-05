function A = stiffness_matrix_2d(p, t, a)

np = size(p, 2);
nt = size(t, 2);
A = sparse(np, np);

for K = 1:nt
    loc2glb = t(1:3, K);
    x1 = p(1, loc2glb);
    x2 = p(2, loc2glb);
    [area, b, c] = hat_gradient(x1, x2);
    x1c = mean(x1); 
    x2c = mean(x2);
    abar = a; 
    %need to define a if a function of x1 and x2. 
    AK = abar * (b*b' + c*c') * area;
    A(loc2glb, loc2glb) = A(loc2glb, loc2glb) + AK;
end

    
    

