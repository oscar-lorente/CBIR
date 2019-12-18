function res = bhattacharyya(X, Y);
    muX = mean(X);
    muY = mean(Y);
    a = sqrt(muX*muY*(size(X,2)^2));
    b = 0;
    for i = 1:size(X,2)
       b = b + sqrt(X(i)*Y(i)); 
    end
    res = sqrt(1-(1/a)*b);
end