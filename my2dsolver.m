clear all;
% to call include
%assemble.m
%f1.m 
%g1.m
%in this script, we will solve
% -u'' = f in 2D.
%first initialize our grid

geometry = @circleg;
% a unit circle. 
% we will test it with different size of mesh, 

for j = 1:5
    h(j) = 1/(2^j);
    [p,e,t] = initmesh(geometry,'hmax', h(j));
    [A, M, R, b, r] = assemble(p, e, t, @f1, @g1, 1);
    phi = (A+R)\(b+r); %this is the FEM results.
    
    
    if h(j) == 0.5
        pp1 = p;
        tt1 = t;
        xx1 = phi;
    end
    
    if h(j) == 1/32
        pp2 = p;
        tt2 = t;
        xx2 = phi;
    end
        
    
    for i = 1:length(phi)
        
        solution= g1(p(1,i),p(2,i));
        err(i) = solution - phi(i);
    
    end
    
    enex = sqrt(err*A*err'); %energy norm
    totalerr(j) = enex;
        
end


%plot of energy norm 
linearfits = polyfit(log(h), log(totalerr), 1);
x = [0 -3.5];
fit = linearfits(1)*x + linearfits(2);
fig_err = figure('position', [0 0 650 500]);
scatter(log(h), log(totalerr));
hold on;
plot(x, fit);
text(-1.5,0,['slope = ',num2str(linearfits(1))]);
xlabel('log(h)');
ylabel('log(error)');
title('error analysis and convergence rate for energy norm');
legend('error in the form of energy norm');
grid on;
saveas(fig_err,'energynorm.png');
hold off;

%plot of the solution 
fig = figure('position', [0,0,1000,450]);
subplot(1,2,1);
pdesurf(pp1,tt1,xx1);
title('solution with mesh size 1/2');

subplot(1,2,2);
pdesurf(pp2,tt2,xx2);
title('solution with mesh size 1/32');

saveas(fig, '2dsolution.png');
 

