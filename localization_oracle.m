function [p,q_hat] = localization_oracle(q,p_a)
%% [p,q_hat] = localization_oracle(q,TP)
%      Simulates a data-driven binary classification oracle with a true
%      positive (TP)
%
% Inputs:
%     - q [N-by-1]          : A vector of actual values of the positive class
%     - p_a [scalar [0, 1]] : True Positive rate
%
% Outputs:
%     - p [N-by-1]     : Simulated output of the ML algorithm
%     - q_hat [N-by-1] : Estimated q


% Generate uniform psuedo random numbers
u = rand(size(q));

% Generate agreement vector
p       = CDF_inv(u,p_a);        % agreement probabilities
epsilon = double(p>=0.5);        % agreement vector



% Generate estimated positive class values
q_hat = (q - (1-epsilon))./(2*epsilon-1);




%% Inverse CDF for the corresponding TP-weighted uniform distribution
function p = CDF_inv(x,TP)
% Inputs:
%  - x [N-by-1] : a vector of uniformly distributed random numbers between
%                 [0,1]
%  - TP [scalar]: True Positive Rate
% Output:
%  -  p [N-by-1] :  simulated vector of agreements probabilities

p = (0.5/(1-TP)*x).*double(x<(1-TP)) + (0.5 + (0.5/TP)*(x-1+TP)).*double(x>=(1-TP));

