function [ex,cnts]=rebin(ex_src,cnts_src,exmin,exmax,binsize);
% A. Shevchenko: getting rid of PHYSICA. Make analog to rebin.pcm
% HISTORY:
% 051003 - rebin.m started.
% this is used e.g. in rebin_fold.m

if nargin~=5
fprintf(' rebin.m - rebin utility to rebin to regular grid...\n');
fprintf(' Usage: [ex cnts]=rebin(ex_src,cnts_src,exmin,exmax,binsize)\n\n');
fprintf(' 1. ex_src - original ex (x-axis, excitation energy\n');
fprintf(' 2. cnts_src - original signal to be rebinned\n');
fprintf(' 3. exmin - starting value for the new x-axis (Ex, in MeV)\n');
fprintf(' 4. exmax - end value (inclusive) for the new -axis (in MeV)\n');
fprintf(' 5. binsize of the rebinned data to be\n');
return;
end

ex=exmin:binsize:exmax; % New uniform mesh of excitation energies
src_ind=1;
dst_ind=1;
cnts(1:length(ex))=0.0;
while((src_ind<=length(ex_src))&&(dst_ind<=length(ex)))
 if(ex_src(src_ind)<=ex(dst_ind))
     cnts(dst_ind)=cnts(dst_ind)+cnts_src(src_ind);
     src_ind = src_ind+1;
     if(mod(src_ind,1000)==0)
      fprintf('%d\n',src_ind);
     end
 else
     dst_ind=dst_ind+1;
 end
end    
