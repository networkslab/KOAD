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

function [k] = kernel(x1, x2, kernelChoice, sigma)
if nargin < 4, sigma = 1; end; %Standard deviation
if nargin < 3, kernelChoice = 1; sigma = 1; end; %Standard deviation
normSquare = sum((x1-x2).*(x1-x2));

if kernelChoice == 1
    k = sum(x1.*x2); %Linear kernel = simply the dot product
elseif kernelChoice == 2
    k = exp(-1*normSquare/(2*sigma^2)); %Gaussian kernel
else
    error('kernelChoice must be either 1=Linear or 2=Gaussian');
end %if kernelChoice == 1
