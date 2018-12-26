% plot CWT coefficient according to 'Value'
subplot(2,2,3);
valcoe = get(coep,'Value');
rr = exist('zcoefs');
if (rr == 1)
    if (valcoe == 1)
        plotcoefs = zcoefs;
        imagesc(zexc,zscale,plotcoefs);
        axis xy;
        ylabel('Scales (MeV)');
        xlabel('Excitation Energy (MeV)');
    elseif (valcoe == 2)
        plotcoefs = zcoefs;
        for ls = 1:length(zscale)
            plotcoefs(ls,:) = plotcoefs(ls,:)/zscale(ls);
        end
        imagesc(zexc,zscale,plotcoefs);
        axis xy;
        ylabel('Scales (MeV)');
        xlabel('Excitation Energy (MeV)');
    elseif (valcoe == 3)
        plotcoefs = abs(zcoefs);
        imagesc(zexc,zscale,plotcoefs);
        axis xy;
        ylabel('Scales (MeV)');
        xlabel('Excitation Energy (MeV)');
    elseif (valcoe == 4)
        plotcoefs = abs(zcoefs);
        for ls = 1:length(zscale)
            plotcoefs(ls,:) = plotcoefs(ls,:)/zscale(ls);
        end
        imagesc(zexc,zscale,plotcoefs);
        axis xy;
        ylabel('Scales (MeV)');
        xlabel('Excitation Energy (MeV)');
    elseif (valcoe == 5)
        plotcoefs = zcoefs.*zcoefs;
        imagesc(zexc,zscale,plotcoefs);
        axis xy;
        ylabel('Scales (MeV)');
        xlabel('Excitation Energy (MeV)');
    elseif (valcoe == 6)
        plotcoefs = zcoefs.*zcoefs;
        for ls = 1:length(zscale)
            plotcoefs(ls,:) = plotcoefs(ls,:)/zscale(ls);
        end
        imagesc(zexc,zscale,plotcoefs);
        axis xy;
        ylabel('Scales (MeV)');
        xlabel('Excitation Energy (MeV)');
    else
        fprintf(1,'\a');
    end
else    
    errordlg('Nothing to plot! You must run CWT first!',...
             '        Idiot!!!        ');
end
rr = exist('plotcoeffs');
if (rr == 1)
    clear plotcoefs;
end
clear rr;