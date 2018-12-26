load Ni58; s = Ni58;
    w = 'bior6.8'
    [c,l] = wavedec(s,10,w);

% Reconstruct the approximation signals and detail signals at 
% levels 1 to 10, using the wavelet decomposition structure [c,l].
for i = 1:10,
    A(i,:) = wrcoef('a',c,l,w,i);
    D(i,:) = wrcoef('d',c,l,w,i);
end
% Plots. 
    % t = 1:1501; 
    t = 1:1400; 
    subplot(11,2,1); plot(t,s(t),'red'); 
    title('^{58}Ni at \theta_{Lab} = 0^{o} and Approximations'); hold on;
    subplot(11,2,2); plot(t,s(t),'green'); 
    title('^{58}Ni at \theta_{Lab} = 0^{o} and Details'); hold on;
    for i = 1:10, 
        %subplot(11,2,2*i+1); plot(t,A(10-i+1,t),'black');
        %subplot(11,2,2*i+2); plot(t,D(10-i+1,t),'black');
        subplot(11,2,2*i+1); plot(t,A(i+1-1,t),'red'); 
        subplot(11,2,2*i+2); plot(t,D(i+1-1,t),'red'); 
    end
        subplot(11,2,1); plot(t,A(9,t),'b');
        subplot(11,2,2); plot(t,A(9,t),'b');
        %subplot(11,2,1); plot(t,0.2*A(10,t),'r');
        %subplot(11,2,2); plot(t,0.2*A(10,t),'r');