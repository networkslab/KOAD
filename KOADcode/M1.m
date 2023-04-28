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


function [d_k dist_out] = M1(x, s, k)
if k+1 > size(s,1)
    error('Value of k must be less than the number of pts');
end %if k+1 > size(s,1)

squares = (repmat(x,size(s,1),1) - s).^2;
dist = sqrt(sum(squares,2));
dist_out = dist; %Distance of "x" to every point in "s" (NOT sorted)
[dist, index] = sort(dist, 'ascend');
d_k = dist(k+1); %Note: NOT dist(k), as k=1 then yields dist with itself, equal to 0.
