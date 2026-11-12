function [serr]=AF(err)
iqr_val = iqr(err); % Calculate the interquartile range.
quartiles = quantile(err, [0.25, 0.75]); % Calculate the first quartile and the third quartile.
lower = quartiles(1) - 1.5 * iqr_val; % Lower bound
upper = quartiles(2) + 1.5 * iqr_val; % Upper bound
q = upper+3*(upper-lower);     % Calculate outliers
len=length(err);
serr=err;
for i=1:len
    if err(i)<-q
       serr(i)=-q;
    elseif err(i)>=-q && err(i)<=q
        serr(i)=err(i);
    elseif err(i)>q
        serr(i)=q;
    end
end
end