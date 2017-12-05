function mass_res = mass_loss(p, t, e, xi, x_initial)
nt = size(t,2);
mass_res = 0; 


%loop through each triangle:
for K = 1:nt
    loc2glb = t(1:3, K);
    x1 = p(1, loc2glb);
    x2 = p(2, loc2glb);
    area = polyarea(x1, x2);
    for j = 1:3
        local_cur(j) = xi(loc2glb(j));
        local_initial(j) = x_initial(loc2glb(j));
    end
    
    local_sum = area*(sum(local_cur))/3;
    local_initial = area*(sum(local_initial))/3;
    local_loss = local_initial - local_sum;
    mass_res = mass_res + local_loss;

end

end

