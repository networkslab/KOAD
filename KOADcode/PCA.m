%   Copyright 2004 Tarem Ahmed and Mark Coates
%
%   Licensed under the Apache License, Version 2.0 (the "License");
%   you may not use this file except in compliance with the License.
%   You may obtain a copy of the License at
%
%       http://www.apache.org/licenses/LICENSE-2.0
%
%   Unless required by applicable law or agreed to in writing, software
%   distributed under the License is distributed on an "AS IS" BASIS,
%   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%   See the License for the specific language governing permissions and
%   limitations under the License.


function [alarm_PCA_out X_residual_out delta_PCA_out] = PCA(X, r)
%PCA offline anomaly detection algorithm.
%Requires the following inputs:
% Mandatory: data matrix (X), number of Principal Components(r).
%Yields the following outputs:
% Always: PCA alarm positions.
% If desired: magnitude of residual and Q-statistic threshold.


%X = P; %May be X=B or X=F to refer to Bytes or Flows, instead of Packets
[T f] = size(X);

%X = X_P'; %Transpose X, if data matrix is in transposed form
X = X - repmat( mean(X,1) , size(X,1) , 1 ); %Then subtract off each dimension across all timesteps.

C = X'*X;
[V D] = eig(C); %Columns of V are the e-vectors
d = diag(D);
V = fliplr(V);
d = flipud(d);
D = diag(d);

normSquare = sum((X*V).^2);
var = normSquare/sum(normSquare); %Percentage of variances
u = X*V;
u = u ./ repmat( sqrt(normSquare) , size(X,1) , 1 );

%r=4; %Number of Principal Components  allocated to normal subspace
R = V(:,1:r);
X_hat = R*R'*X'; %Projections
X_tilde = ( eye(size(R,1)) - R*R' ) * X';
X_state=sum(X_hat.^2,1);
X_residual=sum(X_tilde.^2,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calculate Q-Statistic (PCA Threshold) %

d = d/(T-1);

ErrorSub = r+1:size(d,1);
phi1 = sum(d(ErrorSub));
phi2 = sum(d(ErrorSub).^2);
phi3 = sum(d(ErrorSub).^3);

h0 = 1 - (2*phi1*phi3)/(3*phi2*phi2);
c=3.090; %p=0.999

size(ErrorSub,2);
while (h0<0)
    %%reduce the higher numbered evectors one by one
    %%and recompute h0 with them omitted
    ErrorSub = ErrorSub(1:end-1);
    phi1 = sum(d(ErrorSub));
    phi2 = sum(d(ErrorSub).^2);
    phi3 = sum(d(ErrorSub).^3);
    h0 = 1 - (2*phi1*phi3)/(3*phi2*phi2);
    size(ErrorSub,2);
end %while

delta_PCA = phi1 * ( c*sqrt(2*phi2*h0*h0)/phi1 + 1 + phi2*h0*(h0-1)/(phi1*phi1) )^(1/h0);
alarm_PCA = find(X_residual>delta_PCA);

if nargout == 1
    alarm_PCA_out = alarm_PCA; 
elseif nargout == 2
    alarm_PCA_out = alarm_PCA; X_residual_out = X_residual;
elseif nargout == 3
    alarm_PCA_out = alarm_PCA; X_residual_out = X_residual; delta_PCA_out = delta_PCA;
end
