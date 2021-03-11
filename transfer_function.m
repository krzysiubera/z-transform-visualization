function transfer_function(x,y)
% convertion to the coefficients form
if size(x,1)>1
    b = poly(x);
    a = poly(y);
else
    b = x;
    a = y;
end
clear x y


% frequency response - amplitude
fpr = 1000;
fmax = 500;
df = 0.5;
f = 0:df:fmax;
wn = 2*pi*f/fpr;
H = freqz(b, a, wn);

Habs = abs(H);

figure(1)
plot(f, Habs, 'r-')
grid on
title('charakterystyka amplitudowa')
xlabel('f[Hz]')

% frequency response - phase
figure(2)
Hfa = unwrap(angle(H));
plot(f, Hfa, 'b-')
grid on
title('charakterystyka fazowa')
xlabel('f[Hz]')
ylabel('[rd]')

% transition to the form of zeros and poles
[Hzeros, Hpoles, Hwzm] = tf2zpk(b, a);

% diagram of zeros and poles
NP = 1000;
fi = 2*pi*(0:NP)/NP;
s = sin(fi);
c = cos(fi);
figure(3)
plot(s, c, '-k', real(Hzeros), imag(Hzeros), 'or', real(Hpoles), imag(Hpoles), 'xb')
title('zera i bieguny')
grid on
axis equal

%  3D visualization
[X,Y]=meshgrid(-2:0.05:2); 
z = X+j*Y;

[num, denum] = num_denum(Hzeros,Hpoles,z);
[num_ok, denum_ok] = num_denum(Hzeros,Hpoles,c+j*s);

% choose form of visualization
wykres = 1;

switch wykres
    case 1
        Z = 20*log(abs(num./denum)/max(max(abs(num./denum))));
        Z_ok = 20*log(abs(num_ok./denum_ok)/max(max(abs(num./denum))));
    case 2
        Z = atan(abs(num./denum));
        Z_ok = atan(abs(num_ok./denum_ok));
end

    
figure(4), hold on, grid on
surf(X, Y, Z)
plot3(c,s,Z_ok,'r','linewidth',6)
plot3(c,s,ones(size(c))*min(get(gca,'zlim')),'k:','linewidth',2)
xlabel('Real')
ylabel('Imaginary')
zlabel('abs(H[z])')
title('Wykres 3D')
view([60  60])

in = inpolygon(X, Y, c, s); 

ZZ = NaN*ones(size(Z));
ZZ(in) = Z(in);



figure(5), hold on, grid on
surf(X,Y,ZZ)
plot3(c,s,Z_ok,'r','linewidth',6)
plot3(c,s,ones(size(c))*min(get(gca,'zlim')),'k:','linewidth',2)
xlabel('Real')
ylabel('Imaginary')
zlabel('abs(H[z])')
title('Wykres 3D')
view([60  60])

end