function [sm,lse] = softmax(x)
%SOFTMAX    Softmax function.
%    sm = SOFTMAX(x) returns the softmax function evaluated at
%    the vector x.
%    [sm,lse] = SOFTMAX(x) also returns the log-sum-exp function evaluated
%    at x.
%    The functions are defined by lse = log(sum(exp(x)) and
%    sm = exp(x)/sum(exp(x)) but are computed in way that avoids overflow and 
%    optimizes numerical stability.   

%    Reference:
%    P. Blanchard, D. J. Higham, and N. J. Higham.  
%    Accurately computing the log-sum-exp and softmax functions. 
%    IMA J. Numer. Anal., Advance access, 2020.

if ~isvector(x), error('Input x must be a vector.'), end

n = length(x);
s = 0; e = zeros(n,1);
[xmax,k] = max(x); a = xmax;
s = 0;
for i = 1:n
    e(i) = exp(x(i)-xmax);
    if i ~= k
       s = s + e(i);
    end   
end
if nargout > 1
   lse = a + log1p(s);
end   
sm = e/(1+s);
