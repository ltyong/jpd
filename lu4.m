%% y=(x1, x2, x3, x4)
function ff=lu4(y)
a = 10; b = 76; c = 3;

ff(1) = a * (y(2) - y(1)) + y(4);
ff(2) = b * y(1) - y(1) * y(3) + y(4);
ff(3) = y(1) * y(2) - y(3) - y(4);
ff(4) = -c * (y(1) + y(2));

ff=ff(:);