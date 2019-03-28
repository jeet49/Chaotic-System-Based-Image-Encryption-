function [ P,Q,R ] = transition_matrix( A,B,init )
% Generate basic Logistic Array
C=A*B;
u=4;
t(1)=init
for i=1:C-1
    t(i+1)=u*t(i)-u*t(i)^2;
end

%%2. Generate symbolize matrix Q
v(1) = 0.25; 
key=5;
for i = 1:C-1
    v(i+1) = cos(key*(acosd(v(i))));
end

for i= 1:C
    if(t(i)<v(i))
        Q_array(i) = -1;
    else
        Q_array(i)=1;
    end
end

count = 1;
for i = 1:A
    for j = 1:B
        Q(i,j)= Q_array(count);
        count = count +1;
    end
end



J = t(1:(A/8)*(B/8));
[L_s,P] = sort(J,'descend'); 


%. Generate transformation matirx R
t=double(mod(round(t*10^14), 256) + 1);
C1 = 1;
for i=1: (A)
    for j= 1: (B)
        R(i,j) = t(C1);
        C1=C1+1;
    end
end


end

