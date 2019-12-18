function [idealPrec, idealRecall] = getIdealPrecRecall(N, friendsSize)
aux = 0;
    for i = 1:N
        if(aux ~= friendsSize)
            aux = aux + 1;
        end
        idealPrec(i) =  aux ./ i;
        idealRecall(i) = aux ./ friendsSize; 
    end
end