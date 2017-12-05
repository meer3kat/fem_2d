clear all;
geometry = @circleg;
h = 1/20; % mesh size
[p,e,t] = initmesh(geometry,'hmax', h);
%construct our mesh
np = size(p,2);

k = 0.01; %time intervals
Time = 30; %final time 
t_steps = round(Time/k);

m_loss = zeros(t_steps,1);


[A, M, R, b, r] = assemble(p, e, t, @f2, @g, 0.01);%need g
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

for l = 1:t_steps
    
    LHS = (M/k + A/2);
    RHS = (b + (M/k-A/2)*xi);
    %LHS(e(1,:),:) = I(e(1,:),:);
    %RHS(e(1,:)) = 0;
    xi = LHS\RHS;
    m_loss(l) = mass_loss(p, t, e, xi, initial);
    %pdeplot(p,[],t,'XYData',xi,'ZData',xi,'Mesh','on');
    %pdecont(p, t, xi)
    %pdesurf(p,t,xi);
    %pause(0.000001);
    
 
end


    
