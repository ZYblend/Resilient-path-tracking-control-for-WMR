function [R_idx_C,T_hat_eta_C,q_hat_eta,L_eta] = robustness_support(p,T_hat_C,s,eta)
%% [TR,qR] = robustness_support(P,q_hat,S,eta)
%      Simulates a probability process to obtain the robustness support
%      Confidence   (S)
%      Reliability (eta)
%
% Inputs:
%     - p [N-by-1]     : Simulated output of the ML algorithm
%     - q_hat [N-by-1] : Estimated q
% Outputs:
%     - T_hat_eta [changing size]     : Robustness support
%     - q_hat_eta [N-by-1]            : indication of T_hat_eta
%     - L_eta [scalar]                : reliable number of attacked nodes

% the number of measurement nodes
%N=100;     % for comparision of ML and Pruning
N=6;        % for four simulink models 
%T_hat = find(~q_hat);          % find the nonzero elemens (attacked nodes) and output index
S = s*ones(N,1);
L_eta = reliable_num_attacks(p,eta,N);   % we believe there is L_eta number of good estimated measurement node in oracle

%% Obtain the robustness support
% first step: elementwise multiplication of probability vector and confidence vector
%ps = p_GME.*S;
ps = p.*S;

% Second step: sort the index of elements in ascending order 
[~,idx] = sort(ps); % we believe the first one has the least probability of good measurement node

% Third step: extract the reliable number of nodes' indexs with largest probability of attacking
R_idx_C = idx(N-L_eta+1:N);      % the support of the most (N-L_eta) number of attacked measurement


% Fourth step: Obtain the intersection of estimated spport and reliable support
%if isempty(T_hat)                    % T_hat and R_idx might be empty set
%    T_hat = zeros(0,1);              % but intersect function cannot accept empty set as input
%end                                  % Therefore, set T_hat or R_idx as 0-1 zero vector when they are empty sets
%if isempty(R_idx)
%    R_idx = zeros(0,1);
%end

T_hat_eta_C=intersect(sort(T_hat_C),sort(R_idx_C)); 


% Obtain the indics of robustness support ( set 0 at the attacked nodes)
q_hat_eta = zeros(N,1);
q_hat_eta(T_hat_eta_C)=1;                     








function L_eta = reliable_num_attacks(p,eta,N)
%% Obtain reliable number of attacked nodes
%      Reliability (eta)
%
% Inputs:
%     - p [N-by-1]          : Simulated output of the ML algorithm
% Outputs:
%     - L_eta [scalar]      : reliable number of attacked nodes

P_mutiply = prod(p);
con = zeros(1,N+1);                    % Define the size of the convolution result vector
con(1:2)=[(1-p(1))/p(1),1];            % Initial convolution vector

for ii = 1:N-1
    M = [(1-p(ii+1))/p(ii+1),1];       % Bernoulli probability vector
    v=conv(con,M);
    con=v(1:N+1);
end

r = P_mutiply*con';                    % probability mass function for poisson-binomially distribution

%% define a reliability /eta, and use the probaility r wo get reliable number of attacked nodes
if r(1) > (1-eta) 
     L_eta=0;
else
    sum = r(1);
    k=1;
    while sum <=(1-eta)
        k=k+1;
        sum = sum+r(k);      % ** If when k=N+1, sum is still less than 1-eta, this loop will have error ???
    end
    L_eta=k-1;
end