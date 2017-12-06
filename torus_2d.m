function [p,t,e,initial,xi,m_loss] = torus_2d(meshsize, timestep, final_time)

geometry = @circleg;
h = meshsize; % mesh size
[p,e,t] = initmesh(geometry,'hmax', h);
%construct our mesh
np = size(p,2);
k = timestep; %time intervals
Time = final_time; %final time 
t_steps = round(Time/k);
m_loss = zeros(t_steps,1);
%call to construct our different matrices.
[A, M, R, b, r] = assemble(p, e, t, @f2, @g, 0.01);

%set set up our homogeneous derichlet boundary condition
I = eye(length(p));
A(e(1,:),:) = I(e(1,:),:);
b(e(1,:)) = 0;

%initial condition
xi = zeros(np,1);
len_xi = length(xi);
ro = 10;
bigR = 0.5;
smallr = 0.3;
for i = 1:len_xi  
    if(abs(bigR - sqrt(p(1,i)^2 + p(2,i)^2))) <= smallr
        xi(i) = ro;
    end
end
    
initial = xi;

%now we loop through the time discretization 
%using crank nicolson methods to solve the pde.
for l = 1:t_steps
    
    LHS = (M/k + A/2);
    RHS = (b + (M/k-A/2)*xi);

    xi = LHS\RHS;
    m_loss(l) = mass_loss(p, t, xi, initial);
    
end
end
