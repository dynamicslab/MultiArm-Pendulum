function dydt=DoublePendulumODE_Mounted(t,y,m1,m2,a1,a2,L1,I1,I2,k1,k2,g)
%The state is : phi1, phi2, dphi1, dphi2
dydt(1,1)=y(3);

dydt(2,1)=y(4);

dydt(3,1)=-(I2*y(3)*k1 + I2*y(3)*k2 - I2*y(4)*k2 + a2^2*y(3)*k1*m2 + a2^2*y(3)*k2*m2 - a2^2*y(4)*k2*m2 + L1*a2^3*y(4)^2*m2^2*sin(y(1) - y(2)) - (L1*a2^2*g*m2^2*sin(y(1)))/2 - I2*L1*g*m2*sin(y(1)) - (L1*a2^2*g*m2^2*sin(y(1) - 2*y(2)))/2 - I2*a1*g*m1*sin(y(1)) + (L1^2*a2^2*y(3)^2*m2^2*sin(2*y(1) - 2*y(2)))/2 + L1*a2*y(3)*k2*m2*cos(y(1) - y(2)) - L1*a2*y(4)*k2*m2*cos(y(1) - y(2)) + I2*L1*a2*y(4)^2*m2*sin(y(1) - y(2)) - a1*a2^2*g*m1*m2*sin(y(1)))/(I1*I2 + L1^2*a2^2*m2^2 + I2*L1^2*m2 + I2*a1^2*m1 + I1*a2^2*m2 - L1^2*a2^2*m2^2*cos(y(1) - y(2))^2 + a1^2*a2^2*m1*m2);

dydt(4,1)=(I1*y(3)*k2 - I1*y(4)*k2 + L1^2*y(3)*k2*m2 - L1^2*y(4)*k2*m2 + a1^2*y(3)*k2*m1 - a1^2*y(4)*k2*m1 + L1^3*a2*y(3)^2*m2^2*sin(y(1) - y(2)) + L1^2*a2*g*m2^2*sin(y(2)) + I1*a2*g*m2*sin(y(2)) + (L1^2*a2^2*y(4)^2*m2^2*sin(2*y(1) - 2*y(2)))/2 + L1*a2*y(3)*k1*m2*cos(y(1) - y(2)) + L1*a2*y(3)*k2*m2*cos(y(1) - y(2)) - L1*a2*y(4)*k2*m2*cos(y(1) - y(2)) - L1^2*a2*g*m2^2*cos(y(1) - y(2))*sin(y(1)) + I1*L1*a2*y(3)^2*m2*sin(y(1) - y(2)) + a1^2*a2*g*m1*m2*sin(y(2)) + L1*a1^2*a2*y(3)^2*m1*m2*sin(y(1) - y(2)) - L1*a1*a2*g*m1*m2*cos(y(1) - y(2))*sin(y(1)))/(I1*I2 + L1^2*a2^2*m2^2 + I2*L1^2*m2 + I2*a1^2*m1 + I1*a2^2*m2 - L1^2*a2^2*m2^2*cos(y(1) - y(2))^2 + a1^2*a2^2*m1*m2);
