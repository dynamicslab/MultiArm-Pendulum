function dydt=SinglePendulumODE(t,y,a1,m1,I1,k1,g)
dydt(1,:)=y(2,:);
dydt(2,:)= -(k1*y(2,:) - a1*g*m1*sin(y(1,:)))/(m1*a1^2 + I1);

