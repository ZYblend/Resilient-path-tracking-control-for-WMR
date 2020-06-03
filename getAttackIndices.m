function [I_attack] = getAttackIndices(H,k)
%% I_attack = getAttackIndices(H,k)
%  Is a brute-force solution to the NP-Hard FDIA sub-problem of identifying
%  the indices of the attack vector ya (||ya||_0<=k) such that the residual
%  ya - H(H\ya) has the minimum norm. This is equivalent to searching for a
%  projection matrix P whose columns span the desired sparse sapce 
%      S_k = {y | ||y||_0 <= k}
% such that the linear operator P(I-H(H\)) has the minimum induced norm.
% This is obviously an NP-hard problem whose convex relaxation is not
% trivial. This is left for future work. At the moment, we just brute-force
% the solution for a small number where nchoosek(n,k) <= 100. This
% SO DO NOT USE THIS CODE IF nchoosek(n,k) > 100. Otherwise, it will take
% forever to run.
%
% Inputs:
%     - H [m-by-n]: System Linear Measurment model
%     - k [scalar]: The number of attacked channels. 
%
% Output:
%     - I_attack: The indices of the attack channels that will correspond
%                 to the minimum norm for the residual space.

%% Olugbenga Moses Anubi, Mar 2020

indices = (1:size(H,1));  % measurement indices
attack_indices = nchoosek(indices,k); % returning all attack indices

n_trials = size(attack_indices,1);
min_svds = zeros(n_trials,1); % to store the minimum svds of all trials

for trial_i = 1:n_trials
    res_indices = setdiff(indices,attack_indices(trial_i,:)); % the indices that will determenine the residual
    min_svds(trial_i) = min(svd(H(res_indices,:)));       
end

[~,i_min_svd] = min(min_svds); % returning the index corresponding to the minimum of the min_svds
                               % This trials correspond to the projection of the residual space to the sparse space
                               
I_attack = attack_indices(i_min_svd,:); 
