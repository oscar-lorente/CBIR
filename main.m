prog = 2;
%Prog: variable to decide whether to run the program developed in prog1 (gray level histogram)
%or the one developed in prog2 (Color Layout Descriptors)

databaseUbication = 'C:\Users\oscar\Desktop\3B\PIV\Lab\Prog\Prog1-CBIR/UKentuckyDatabase/';

imaDB = dir(strcat(databaseUbication, '*.jpg')); %database
N = size(imaDB, 1);
if (prog == 2)
    CLD = cell(3, N);
end
%CLD: Array of 3 rows cells (one for each component Y, Cb y Cr) x N columns
%(N: número de imágenes de la base de datos, 2000) where each cell contains
%the DCT coefficients of the component and corresponding image

tic
for i = 1:N
    if (prog == 1)
        h(i, :) = imhist(rgb2gray(imread(strcat(imaDB(i).folder, '\', imaDB(i).name))));
    else
        [CLD{1,i}, CLD{2,i}, CLD{3,i}] = CLDescriptor(double(imread(strcat(imaDB(i).folder, '\', imaDB(i).name)))/double(255));
    end
   %CLDescriptor: Function developed in which, for each image, the DCT coefficients 
   %for each component are calculated and obtained, being stored in the variable CLD {k, l},
   %where k represents the component% (1 - Y , 2 - Cb, 3 - Cr) and l the image in question
end
toc %to get the duration of exctracting descriptors from the entire database

inputFileUbication = 'C:\Users\oscar\Desktop\3B\PIV\Lab\Prog\Prog1-CBIR\Test\input.txt';
outputFileUbication = 'C:\Users\oscar\Desktop\3B\PIV\Lab\Prog\Prog1-CBIR\Test\output8.txt';
inFile = fopen(inputFileUbication, 'r'); %input.txt
outFile = fopen(outputFileUbication, 'w'); %output.txt
counter = 0; %to obtain the precision and recall average values

while ~feof(inFile)  %for each image in the file input.txt
    imageName = fgetl(inFile);
    imageFriends = getImageFriends (imageName, imaDB);
    %imageFriends: variable with the names of the 4 correct images
    
    if (prog == 1)
        imaHist(1, :) = imhist((rgb2gray(imread(strcat(imaDB(1).folder, '\', imageName)))));
        D = zeros(2, N);
        for i = 1:N
            D(1, i) = algo2(imaHist(1, :), h(i, :));
            D(2, i) = i;
        end
    else
        D = CLDMatching(CLD, find(strcmp({imaDB.name}, imageName)==1));
     %D: 2 rows matrix (first: distance between one image and another, second:
     %image corresponding to that factor) x 2000 columns (number of images of
     %the database). CLDMatching ? Function that calculates the distance
     %between two images and receives 2 arguments: CLD (of type cell) and the
     %index of the image of the input.txt file in question
    end
    
    [~,idx] = sort(D(1,:));
    %Idx: vector of 1x2000 with the indices of images arranged according of
    %the distance (D, ascending order), being idx [1] the index of the image
    %more similar to the image in question (which will be the image itself)
    sortedImages = D(:,idx);
    %sortedImages: 2x2000 matrix, the second row being equivalent to the idx
    %variable (that is, indexes of the images sorted according to the distance
    %of ascending form) and the first row the distances corresponding to each
    %index (the first value being = 0, because the distance between an image and
    %itself is 0)
    sortedImages = sortedImages(:, 1:10);
    %Finally we are left with the 10 images with the smaller distance ? more
    %similar
    writeResults(outFile, imageName, sortedImages, imaDB); %results --> output.txt
    [precAux, recallAux] = getPrecRecall(imageFriends, imaDB, sortedImages); 
    %getPrecRecall function returns 2 arrays 1x10: precAux (precision
    %obtained in this image for each threshold - 1 image, 2 images, ...) and
    %recallAux (same but with the recall)
    
    if(~counter) %if it's the first image of the input.txt file
        prec = precAux;
        recall = recallAux;
    else
        prec = prec + precAux;
        recall = recall + recallAux;
    end
    counter = counter + 1;
end

prec = prec ./ counter; 
recall = recall ./ counter;
%to get the precision (recall) average from the precisions (recalls) obtained for each image in the input.txt file 
fscore = 2*((prec.*recall)./(prec+recall)); %get "fscore" array for each precision-recall value
maxFscore = max(fscore); %obtain the fscore value by taking the maximum of the fscore array values
disp(round(maxFscore, 3));
plotPrecRecall(prec, recall, size(imageFriends, 1), maxFscore, prog);
fclose(inFile);
fclose(outFile);