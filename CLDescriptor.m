function [coefY, coefCb, coefCr] = CLDescriptor(im)
%Function CLDescriptor that accepts as an argument an image and returns
%the corresponding DCT coefficients Y, Cb and Cr

    avgR = blkproc(im(:,:,1), [size(im, 1)/8 size(im, 2)/8], 'mean2');
    avgG = blkproc(im(:,:,2), [size(im, 1)/8 size(im, 2)/8], 'mean2');
    avgB = blkproc(im(:,:,3), [size(im, 1)/8 size(im, 2)/8], 'mean2');
    %For each matrix R, G and B, corresponding to im (:,:, 1), im (:,:, 2)
    %and im (:,:, 3) respectively, the blkproc function is used to divide the
    %matrices (of 640x480) in 8 blocks -of size size(image) / 8- and
    %calculate the average of the pixels of each block, resulting in 3
    %matrices (avgR, avgGy avgB) of 8x8
        
    Y = 0.299*avgR + 0.587*avgG + 0.114*avgB;
    Cb = -0.169*avgR - 0.331*avgG + 0.500*avgB;
    Cr = 0.500*avgR - 0.419*avgG - 0.081*avgB;
    %Transformation of color space RGB ? YUV, obtaining 3 matrices: Y, Cb and
    %Cr, of 8x8 each
    
    dctY = dct2(Y);
    dctCb = dct2(Cb);
    dctCr = dct2(Cr);
    %dctY, dctCb and dctCr: matrices with the DCT coefficients of the
    %luminance and chrominance components Cb and Cr, respectively
    
    zigzagY = ZigZag(dctY);
    zigzagCb = ZigZag(dctCb);
    zigzagCr = ZigZag(dctCr);
    %When performing a zigzag on matrices dctY, dctCb and dctCr, 3 vectors of
    %64 coefficients each (1 row x 64 columns) are obtained
    
    coefY = zigzagY(1:6); %The first 6 Y coefficients are used
    coefCb = zigzagCb(1:6); %The first 6 Cb coefficients are used
    coefCr = zigzagCr(1:6); %The first 6 Cr coefficients are used
    %The number of coefficients to be used may vary

end