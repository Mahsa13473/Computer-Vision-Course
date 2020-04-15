function [NMS] = nonMaximalSuppression(X)

    % non-maximum suppression
    % move a 3 × 3  filter over the image
    
    filter_1 = [1  0  0;
                0 -1  0;
                0  0  0];
    
    filter_2 = [0  1  0;
                0 -1  0;
                0  0  0];
            
    filter_3 = [0  0  1;
                0 -1  0;
                0  0  0];
    
    filter_4 = [0  0  0;
                1 -1  0;
                0  0  0];            

    filter_6 = [0  0  0;
                0 -1  1;
                0  0  0];
    
    filter_7 = [0  0  0;
                0 -1  0;
                1  0  0];
            
    filter_8 = [0  0  0;
                0 -1  0;
                0  1  0];
    
    filter_9 = [0  0  0;
                0 -1  0;
                0  0  1]; 

    % compute gradient magnitude difference in each direction for every
    % point
    X_1 = myImageFilter(X, filter_1);
    X_2 = myImageFilter(X, filter_2);
    X_3 = myImageFilter(X, filter_3);
    X_4 = myImageFilter(X, filter_4);
    X_6 = myImageFilter(X, filter_6);
    X_7 = myImageFilter(X, filter_7);
    X_8 = myImageFilter(X, filter_8);
    X_9 = myImageFilter(X, filter_9);
   
    NMS_X = zeros(size(X));

    NMS_X = max(X_1, X_2);
    NMS_X = max(NMS_X, X_3);
    NMS_X = max(NMS_X, X_4);
    NMS_X = max(NMS_X, X_6);
    NMS_X = max(NMS_X, X_7);
    NMS_X = max(NMS_X, X_8);
    NMS_X = max(NMS_X, X_9);


    % if the maximum is negetive then keep the original value, else set its
    % value to zero
    NMS = zeros(size(X));
    NMS(NMS_X<0) = X(NMS_X<0);

end