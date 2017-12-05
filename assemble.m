function [A, M, R, load_b, r] = assemble(p, e, t, f, g, a)
np = size(p,2);
nt = size(t,2);
ne = size(e,2);
A = sparse(np,np);
R = sparse(np,np);
M = sparse(np,np);
load_b = zeros(np,1);
r = zeros(np,1);
gamma = 1;
%assemble stiffness matrix A:
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
    MK = [2 1 1; 1 2 1; 1 1 2]/12*area;
    M(loc2glb, loc2glb) = M(loc2glb, loc2glb) + MK;
end


for K = 1:nt
    loc2glb = t(1:3, K);
    x1 = p(1, loc2glb);
    x2 = p(2, loc2glb);
    area = polyarea(x1, x2);
    bK = [f(x1(1), x2(1)); f(x1(2), x2(2)); f(x1(3), x2(3))]/3*area;
    load_b(loc2glb) = load_b(loc2glb) +bK;
end


%assemble boundary mass matrix R, and vector r
for E = 1:ne
    loc2glb = e(1:2, E);
    x1 = p(1, loc2glb);
    x2 = p(2, loc2glb);
    len = sqrt((x1(1) - x1(2))^2 + (x2(1) -x2(2))^2);
    k = 100000;
    x1c = mean(x1);
    x2c = mean(x2);
    RE = k/6 *[2 1; 1 2] * len;
    R(loc2glb, loc2glb) = R(loc2glb, loc2glb) + RE;
    temr = k * g(x1c, x2c);
    rE = temr * [1; 1] * len/2;
    r(loc2glb) = r(loc2glb) + rE;
end




