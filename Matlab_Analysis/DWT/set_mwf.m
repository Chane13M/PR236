function scale_factor=set_mwf(mwf);
% 16.07.03 A. Shevchenko
% used in other scripts to define the normalization os wavelet scales to
% FWHM scales for different wavelets

if nargin==0
fprintf(' set_mwf - used in other scripts to set the normalization of wavelet scales to FWHM scales for different wavelets)...\n');
fprintf(' Usage: fwhm_factor=set_mwf(mwf)   e.g. fwhm_factor=set_mwf(''morl'')\n\n');
fprintf('   1. mwf - Conventional name of the mother wavelet function to be used.\n');
return;
end

mwf_set={'haar','gaus2','mexh','gaus4','morl','bior3.9','bior2.8','bior6.8'};
fwhm_set=[146.0/50.0,68./50.,48./50.,90./50.,150./50.,168./50.,3.25,3.17];
% for adjustment
%fwhm_set=[146.0/50.0, 68./50., 48./50., 90.50, 50./50., 168./50., 3.25, 3.17];

for i=1:length(mwf_set)
    if(strcmp(mwf,mwf_set(i)))
        scale_factor=double(fwhm_set(i));
    end
end
