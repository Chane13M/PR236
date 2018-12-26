function data_sm=runsum(data_src,n_bin);
% 29.08.03 A. Shevchenko: Smoothing using running sum averages

if nargin~=2
fprintf(' runsum - function for smoothing using running sum averages\n');
fprintf(' Usage: data_smoothed=runsum(data_src,n_bins)\n\n');
fprintf(' 1. data_src - vector with source data to be smoothed\n');
fprintf(' 2. n_bin - number of bins to use in the running sum. Must be an odd number (1,3,5,...)\n');
return;
end

m_ind=floor(0.5*(n_bin-1.0));
data_len=length(data_src);
data_sm=data_src;

for i=m_ind+1:data_len-m_ind
   data_sm(i)=sum(data_src(i-m_ind:i+m_ind)) / n_bin;
end

