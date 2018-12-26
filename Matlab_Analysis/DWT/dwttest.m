% Load original 1-D signal.
    %load calcium; s = calcium;% note size=130 and nlevel=6.

   % load caeen; s = caeen; %note size=1812 and nlevel=9.
   % load cappn; s = cappn; %note size=2696 and nlevl=10.
   % load cappprime; s = cappprime; %note size=2995 and nlevl=11.
    % load ca1020dwt; s = ca1020dwt; %note size=1000 and nlevl=9.
  %   load ca11deg1025; s = ca11deg1025; %note size=1501 and nlevl=10.
    % load ca11degcs1025; s = ca11degcs1025; %note size=1501 and nlevl=10.
  %  load ca11degcsqfbkgrdsubnew; s = ca11degcsqfbkgrdsubnew; %note size=1501 and nlevl=10.
   % load ca15degcsqfbkgrdsubnew; s = ca15degcsqfbkgrdsubnew; %note size=1501 and nlevl=10.
   % load ca7degcsqfbkgrdsubnew; s = ca7degcsqfbkgrdsubnew; %note size=1501 and nlevl=10.
     %load ca11degcsqfsub; s = ca11degcsqfsub; %note size=1501 and nlevl=10.
  % load ca11degcs1025new; s = ca11degcs1025new; %note size=1501 and nlevl=10.
  % load cazerodegcs1025; s = cazerodegcs1025; %note size=1501 and nlevl=10.
   load pbexcitation; s = pbexcitation; %note size=1401 and nlevl=10.
  %  load ca40zerodeg1025; s = cazerodegcs1025; %note size=1501 and nlevl=10.
   %  load ca15degcs1025new; s = ca15degcs1025new; %note size=1501 and nlevl=10.
   %  load ca7degcs1025new; s = ca7degcs1025new; %note size=1501 and nlevl=10.
% Perform the decomposition of s at level 5, using coif3.
    %w = 'bior3.9'
    w = 'bior6.8'
    [c,l] = wavedec(s,10,w);

% Reconstruct the approximation signals and detail signals at 
% levels 1 to 10, using the wavelet decomposition structure [c,l].
for i = 1:10,
    A(i,:) = wrcoef('a',c,l,w,i);
    D(i,:) = wrcoef('d',c,l,w,i);
end
% Plots. 
    t = 1:1401; 
    subplot(11,2,1); plot(t,s(t),'red'); 
    title('^{40}Ca at \theta_{Lab} = 11^{o} and Approximations'); 
    subplot(11,2,2); plot(t,s(t),'green'); 
    title('^{40}Ca at \theta_{Lab} = 11^{o} and Details'); 
    for i = 1:10, 
        subplot(11,2,2*i+1); plot(t,A(10-i+1,t),'red'); 
        subplot(11,2,2*i+2); plot(t,D(10-i+1,t),'red'); 
    end