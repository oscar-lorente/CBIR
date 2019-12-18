function res = algo2( h1, h2 )
    %res = sum(abs((h1-h2)));
    %res = ((h1-h2)*(h1-h2).')./size(h1, 2);
    %res = distChiSq(h1, h2);
    res = bhattacharyya(h1,h2);
end

