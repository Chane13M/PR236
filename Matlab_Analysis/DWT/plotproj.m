% plot projection of CWT coefficient according to 'Value'
subplot(2,2,4);
valpro = get(norp,'Value');
rr = exist('zcoefs');
% check if projection exists
if (rr == 1)
    if (valpro == 1)
        % plot local projection; no zoom, no difference
        if (zoomed == 1)
            plotproy = zproy;
            normpr = 1;
            switch (setlogs)
                case ('lin-lin')     
                    plot(plotproy,zscale,'y');
                case ('lin-log')     
                    semilogx(plotproy,zscale,'y');
                case ('log-lin')     
                    semilogy(plotproy,zscale,'y');
                case ('log-log')     
                    loglog(plotproy,zscale,'y');
            end 
            grid on;
            ttitel = sprintf('%s local',mwf);
            title(ttitel);
            axis([min(plotproy) max(plotproy) curaxis(5) curaxis(6)]);
            ylabel('Scales (MeV)');
            xlabel('sum of Ca,*');
        else    
            errordlg('Nothing to plot! You must zoom first!',...
                     '        Idiot!!!        ');
        end
    elseif (valpro == 2)
        % plot a part of global projection; no zoom, no difference
        if (zoomed == 1)
            plotproy = proy(binbsave:bintsave);
            normpr = 2;
            switch (setlogs)
                case ('lin-lin')     
                    plot(plotproy,zscale,'y');
                case ('lin-log')     
                    semilogx(plotproy,zscale,'y');
                case ('log-lin')     
                    semilogy(plotproy,zscale,'y');
                case ('log-log')     
                    loglog(plotproy,zscale,'y');
            end 
            grid on;
            ttitel = sprintf('%s global',mwf);
            title(ttitel);
            axis([min(plotproy) max(plotproy) curaxis(5) curaxis(6)]);
            ylabel('Scales (MeV)');
            xlabel('sum of Ca,*');
        else    
            errordlg('Nothing to plot! You must zoom first!',...
                     '        Idiot!!!        ');
        end
    else
        fprintf(1,'\a');
    end
    clear plotproy ttitel;
else
    errordlg('Nothing to plot! You must run CWT first!',...
             '        Idiot!!!        ');
end
clear rr;
