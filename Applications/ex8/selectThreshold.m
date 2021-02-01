function [bestEpsilon bestF1] = selectThreshold(yval, pval)
%SELECTTHRESHOLD Find the best threshold (epsilon) to use for selecting
%outliers
%   [bestEpsilon bestF1] = SELECTTHRESHOLD(yval, pval) finds the best
%   threshold to use for selecting outliers based on the results from a
%   validation set (pval) and the ground truth (yval).
%
bestEpsilon = 0;
bestF1 = 0;
F1 = 0;

stepsize = (max(pval) - min(pval)) / 1000;
for epsilon = min(pval):stepsize:max(pval)

    % ====================== YOUR CODE HERE ======================
    % Instructions: Compute the F1 score of choosing epsilon as the
    %               threshold and place the value in F1. The code at the
    %               end of the loop will compare the F1 score for this
    %               choice of epsilon and set it to be the best epsilon if
    %               it is better than the current choice of epsilon.
    %
    % Note: You can use predictions = (pval < epsilon) to get a binary vector
    %       of 0's and 1's of the outlier predictions
    for i=1:size(pval)

    %  if (pval(i) < epsilon)
    %      if (yval(i) == 1)
    %        result(i) = 1; % 1 -- true negative
    %      else
    %        result(i) = 2; % 2 -- false negative
    %      endif
    %  else
    %      if (yval(i) == 0)
    %        result(i) = 3; % 3 -- true positive
    %      else
    %        result(i) = 4; % 4 -- false positive
    %      endif
    %  endif
      if (pval(i) < epsilon)
        if(i==1)
          cvPredictions = [1];
        else
          cvPredictions =[cvPredictions; 1];
        endif
      else
      if(i==1)
        cvPredictions = [0];
      else
        cvPredictions =[cvPredictions; 0];
      endif
      endif
    endfor

    %Tp = sum(result == 3)/3;
    %Fp = sum(result == 4)/4;
    %Fn = sum(result == 2)/2;

    Fp = sum((cvPredictions == 1) & (yval == 0));
    Tp = sum((cvPredictions == 0) & (yval == 0));
    Fn = sum((cvPredictions == 0) & (yval == 1));
    Tn = sum((cvPredictions == 1) & (yval == 1));

    Prec = Tp/(Tp+Fp);
    Recall = Tp/(Tp+Fn);
    F1 = 2*(Prec*Recall)/(Prec+Recall);



    % =============================================================

    if F1 > bestF1
       bestF1 = F1;
       bestEpsilon = epsilon;
    end
end

end
