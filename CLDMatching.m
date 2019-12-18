function D = CLDMatching (CLD, index)
    coefY = CLD {1, index};
    coefCb = CLD {2, index};
    coefCr = CLD {3, index};
    %coefY, coefCb and coefCr: Arrays containing the DCT coefficients of the
    %components Y, Cb and Cr, respectively, of the image in question (defined
    %by index)
    
    wY = [1, 1, 1, 1, 1, 1];
    wCb = [1, 1, 1, 1, 1, 1];
    wCr = [1, 1, 1, 1, 1, 1];
    %Weights: all to 1 ? same importance to all components
    
    N = size(CLD,2);
    D = zeros(2, N);
    for i = 1:N %For each image
        D(1, i) = sqrt(sum(wY.*(coefY-CLD{1,i}).^2)) + sqrt(sum(wCb.*(coefCb-CLD{2,i}).^2)) + sqrt(sum(wCr.*(coefCr-CLD{3,i}).^2));
        %Calculation of the distance
        D(2, i) = i;
        %i: index of the image that has been compared
    end
end