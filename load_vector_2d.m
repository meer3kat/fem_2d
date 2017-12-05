function b = load_vector_2d(p, t, f)
np = size(p,2);
nt = size(t,2);
b = zeros(np,1);
for K = 1:nt
    loc2glb = t(1:3, K);
    x1 = p(1, loc2glb);
    x2 = p(2, loc2glb);
    area = polyarea(x1, x2);
    bK = [f(x1(1), x2(1)); f(x1(2), x2(2)); f(x1(3), x2(3))]/3*area;
    b(loc2glb) = b(loc2glb) +bK;
end
