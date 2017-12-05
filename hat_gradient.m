function [area, b, c] = hat_gradient(x1, x2)
area = polyarea(x1, x2);
b = [x2(2) - x2(3); x2(3) - x2(1); x2(1) - x2(2)]/2/area;
c = [x1(3) - x1(2); x1(1) - x1(3); x1(2) - x1(1)]/2/area;
 
