function [num, denum] = num_denum(zeros,poles,z)
num = 1;
for k = 1:length(zeros)
     num = num.*(1 - zeros(k).*z.^(-1));
end
denum = 1;
for m = 1:length(poles)
     denum = denum.*(1 - poles(m).*z.^(-1));
end
return