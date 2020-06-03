
function ya = gen_attack_channel(H, max_attack,I_attack,tau)
%% ya = gen_attack_channel(H, max_attack, epsilon,I_attack,tau) 
%  Generates sparse attack vector that corrupts the states estimates as
%  much as possible for the linear systeme given by: y = H*x 
%  Inputs:
%     - H [m-by-n]: System Linear Measurment model
%     - max_attack [scalar]        : maximum allowable attack along any channel
%     - I_attack[ k-column vector] : vector of attack locations
%     - tau [scalar >0, <1]        : Bad Data Detection(BDD) escape
%                                    parameter. This is to ensure that the
%                                    resulting corrupted signal will pass
%                                    threshold-based BDD
%
%  Output:
%    - ya[m-column vector] : The sparse attack vector with support I_attack

%% Olugbenga Moses Anubi, Jan 2019
%%   Modified: Olugbenga Moses Anubi, Jan 2020
%       - Changed name to reflect usage more
%       - got rid of the 1 dimensional qcqp
%       - solved the problem completely using SVD and matrix subspaces
%       - Problem: We seek a vector y \in R^m with the sparsity pattern
%                  specified by I_attack such that the projection x = H\y
%                  has a maximum norm while the residual (I-H(H\))y has a
%                  norm <= tau.
%       - Idea  : Suboptimal Heuristic. Done without proof, but works!
%               1. Decomposing H into its SVD. 
%                          H = [U1 U2]*blkdiag(S_1,zero)*V'
%               2. y=Hx <=> U.'*y = [S_1*V.'*x; zeros]
%               3. Factoring in the sparsity pattern of y yields the
%                  refined problem
%               4. max : ||U1_attack.'*y_attack||^2 
%                   s.t: ||U2_attack.'*y_attack||^2<=tau^2
%               5. To maximize the objective , we take the SVD of
%                  U1_attack.' and picked the singular vector corresponding tp
%                  to the maximum singular value(V1_attack)
%               6. A scaling factor lambda is then used to gurantee that
%                  the constraint is satisfied.
%%


% sizes
[m,n] = size(H);

[U,~,~] = svd(H);

U1_attack = U(I_attack,1:n);
U2_attack = U(I_attack,n+1:end);

[~,~,V1_attack] = svd(U1_attack.');

lambda = min(tau/norm(U2_attack.'*V1_attack(:,1)) , max_attack);

y_attack = lambda*V1_attack(:,1);

ya = zeros(m,1);
ya(I_attack) = y_attack;





