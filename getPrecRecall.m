function [prec, recall] = getPrecRecall(imageFriends, imaDB, sortedImages)
prec = zeros(1, size(sortedImages, 2));
recall = zeros(1, size(sortedImages, 2));
aciertos = 0;
    for i = 1:size(sortedImages, 2)
        ima = imaDB(sortedImages(2,i)).name;
        for j = 1:size(imageFriends, 1)
            if(strcmp(imageFriends(j,:), ima))
                aciertos = aciertos + 1;
                break
            end
        end
        prec(i) = aciertos ./ i;
        recall(i) = aciertos ./ size(imageFriends, 1);
    end
end