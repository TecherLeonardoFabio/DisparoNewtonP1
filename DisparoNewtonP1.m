function [nodos ,solaprox ,t,iter, incre ] = DisparoNewtonP1 (funcion ,a,b,alfa ,beta,n,tol, maxiter )
h=(b-a)/(n+1);
x=a:h:b; 
t0 =(beta-alfa)/(b-a);
[x,Y]= ode45 (funcion ,x ,[t0 ,alfa-t0,1,-1]'); %<-----
yb1=Y(end ,1); %u(3,t0) <----
yb2=Y(end, 2); %u'(3,t0) <----
zb1=Y(end ,3); %z(3,t0) <----
zb2=Y(end ,4); %z'(3,t0) <----

iter=1; 
incre =tol +1;

while incre >tol && iter < maxiter
t=t0 -(yb1+yb2-beta)/(zb1+zb2); %Metodo de Newton <-----
[x,Y]= ode45 (funcion ,x ,[t,alfa-t,1,-1]'); %<-----
yb1=Y(end ,1); 
yb2=Y(end ,2);
zb1=Y(end ,3);
zb2=Y(end,4);
incre =abs(yb1+yb2 -beta); %<------ |u(3,t1)-u'(3,t1)-beta|<=tol
iter= iter +1;

t0=t; 

end
if incre <= tol
nodos =x;
solaprox =Y;
else
disp('se necesitan mas iteraciones ')
end
end