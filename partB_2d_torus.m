clear all;
% this is for solving the 2D torus
% to run include:
% torus_2d.m
% assemble.m
% mass_loss.m
% f2.m
% g.m
[p1,t1,e1,initial1,xi1,m_loss1] = torus_2d(1/5, 0.1, 30);
[p2,t2,e2,initial2,xi2,m_loss2] = torus_2d(1/20, 0.1, 30);

%plot of solutions
fig_1 = figure('position', [0,0,1000,1000]);
subplot(2,2,1);
pdesurf(p1,t1,initial1);
title('solution at time = 0, mesh size = 1/5');

subplot(2,2,2);
pdesurf(p1,t1,xi1);
title('solution at time = 30, mesh size = 1/5');

subplot(2,2,3);
pdesurf(p2,t2,initial2);
title('solution at time = 0, mesh size = 1/20');

subplot(2,2,4);
pdesurf(p2,t2,xi2);
title('solution at time = 30, mesh size = 1/20');
saveas(fig_1, 'torus_2d_solution.png');


%plot of hormone losses
hresult = 0.1:0.1:30;
fig_mloss = figure('position', [0,0,1000,450]);
subplot(1,2,1);
plot(hresult,m_loss1);
xlim([0 30]);
ylim([0 20]);
xlabel('time');
ylabel('hormone loss');
title('hormone loss (mesh size 1/5)');

subplot(1,2,2);
plot(hresult,m_loss2);
xlim([0 30]);
ylim([0 20]);
xlabel('time');
ylabel('hormone loss');
title('hormone loss (mesh size 1/20)');

saveas(fig_mloss, 'torus_2d_hormone_emission.png');

