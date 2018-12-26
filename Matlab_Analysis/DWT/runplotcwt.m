if (cwtdone == 0)
% make cwt if not yet made
    [f,p] = log2(length(d2s));
    p=p-1;
    smax=2^p;
    if (smax >= 2048)
	    smax = 1024;
    end
    svar = exist('scale');
    if (svar == 1)
        clear scale;
    end
    for ii=1:smax
	    scale(ii)=ii/fwhm_factor*binsize;
    end
    coefs = cwt(d2s,1:1:smax,mwf);
    proy = sum(coefs');
    zcoefs = coefs;
    zproy = proy;
    curaxis(6) = max(scale);
    cwtdone = 1;
    set(pospb,'Enable','on');
    set(rcwtb,'String','  Plot  ');
    set(mapp,'Enable','on');
    set(norp,'Enable','on');
    set(coep,'Enable','on');
% cwt has just been done
    zoomed = 0;
    zexc = exc;
    zd2s = d2s;
    zcoefs = coefs;
    zscale = scale;
    % write commands to asci file
    fprintf(outa,'CWT made\n');
end  
% plot CWT coefficient according to 'valcoe'
if (zoomed == 0)
% if cwt has just been done
    valcoe = get(coep,'Value');
    if (valcoe == 1)
        plotcoefs = zcoefs;
        nproy = proy;
        set(logp,'Enable','off');
        set(logp,'Value',1);
        setlogs = 'lin-lin';
        fprintf(outa,'Plot for values\n');
    elseif (valcoe == 2)
        plotcoefs = zcoefs;
        for ls = 1:length(zscale)
            plotcoefs(ls,:) = plotcoefs(ls,:)/zscale(ls);
        end
        nproy = proy./scale;
        set(logp,'Enable','off');
        set(logp,'Value',1);
        setlogs = 'lin-lin';
        fprintf(outa,'Plot for normalized values\n');
    elseif (valcoe == 3)
        plotcoefs = abs(zcoefs);
        nproy = sum(abs(coefs'));
        set(logp,'Enable','on');
        fprintf(outa,'Plot for absolute values\n');
    elseif (valcoe == 4)
        plotcoefs = abs(zcoefs);
        for ls = 1:length(zscale)
            plotcoefs(ls,:) = plotcoefs(ls,:)/zscale(ls);
        end
        nproy = sum(abs(coefs'))./scale;
        set(logp,'Enable','on');
        fprintf(outa,'Plot for absolute normalized values\n');
    elseif (valcoe == 5)
        plotcoefs = zcoefs.*zcoefs;
        nproy = sum((coefs'.*coefs'));
        set(logp,'Enable','on');
        fprintf(outa,'Plot for squared values\n');
    elseif (valcoe == 6)
        plotcoefs = zcoefs.*zcoefs;
        for ls = 1:length(zscale)
            plotcoefs(ls,:) = plotcoefs(ls,:)/zscale(ls);
        end
        nproy = sum((coefs'.*coefs'))./scale;
        set(logp,'Enable','on');
        fprintf(outa,'Plot for squared normalized values\n');
    else
        fprintf(1,'\a');
    end
    subplot(2,2,3)
    imagesc(zexc,zscale,plotcoefs);
    axis xy;
    ylabel('Scales (MeV)');
    xlabel('Excitation Energy (MeV)');
    zproy=sum(plotcoefs');
    nproy=sum(plotcoefs');
    curaxis(7)=min(zproy);
    curaxis(8)=max(zproy);
    subplot(2,2,4);
    whitebg('black');
    if (valcoe == 1 | valcoe == 2 )
            plot(zproy,zscale,'y');
    else
         switch (setlogs)
            case ('lin-lin')     
                plot(zproy,zscale,'y');
            case ('lin-log')     
                semilogx(zproy,zscale,'y');
            case ('log-lin')     
                semilogy(zproy,zscale,'y');
            case ('log-log')     
                loglog(zproy,zscale,'y');
         end
    end
    grid on;
    set(norp,'Value',2);
    normpr = 2;
    ttitle = sprintf('%s global',mwf);
    title(ttitle);
    clear ttitle;
    axis([curaxis(7) curaxis(8) 0.0 curaxis(6)]);
    ylabel('Scales (MeV)');
    xlabel('sum of Ca,*');
    % write commands to asci file
    fprintf(outa,'Plot %f %f %f %f %f %f %f %f\n', curaxis);
else
% if data has already been processed
    justzoomed = exist('binl');
    if (justzoomed == 1)
        tmpe = zexc;
        tmpd = zd2s;
        tmps = zscale;
        tmpc = zcoefs;
        clear zexc zd2s zscale zcoefs;
        zexc = tmpe(binl:binr);
        zd2s = tmpd(binl:binr);
        zscale = tmps(binb:bint);
        zcoefs = tmpc(binb:bint,binl:binr);
        binbsave = binb;
        bintsave = bint;
        clear binl binr binb bint tmpe tmpd tmps tmpc;
    end
    valcoe = get(coep,'Value');
    if (valcoe == 1)
        plotcoefs = zcoefs;
        nproy = proy;
        set(logp,'Enable','off');
        set(logp,'Value',1);
        setlogs = 'lin-lin';
       fprintf(outa,'Plot for values\n');
    elseif (valcoe == 2)
        plotcoefs = zcoefs;
        for ls = 1:length(zscale)
            plotcoefs(ls,:) = plotcoefs(ls,:)/zscale(ls);
        end
        nproy = proy./scale;
        set(logp,'Enable','off');
        set(logp,'Value',1);
        setlogs = 'lin-lin';
        fprintf(outa,'Plot for normalized values\n');
    elseif (valcoe == 3)
        plotcoefs = abs(zcoefs);
        nproy = sum(abs(coefs'));
        set(logp,'Enable','on');
        fprintf(outa,'Plot for absolute values\n');
    elseif (valcoe == 4)
        plotcoefs = abs(zcoefs);
        for ls = 1:length(zscale)
            plotcoefs(ls,:) = plotcoefs(ls,:)/zscale(ls);
        end
        nproy = sum(abs(coefs'))./scale;
        set(logp,'Enable','on');
        fprintf(outa,'Plot for absolute normalized values\n');
    elseif (valcoe == 5)
        plotcoefs = zcoefs.*zcoefs;
        nproy = sum((coefs'.*coefs'));
        set(logp,'Enable','on');
        fprintf(outa,'Plot for squared values\n');
    elseif (valcoe == 6)
        plotcoefs = zcoefs.*zcoefs;
        for ls = 1:length(zscale)
            plotcoefs(ls,:) = plotcoefs(ls,:)/zscale(ls);
        end
        nproy = sum((coefs'.*coefs'))./scale;
        set(logp,'Enable','on');
        fprintf(outa,'Plot for squared normalized values\n');
    else
        fprintf(1,'\a');
    end
    subplot(2,2,3);
    imagesc(zexc,zscale,plotcoefs);
    axis xy;
    ylabel('Scales (MeV)');
    xlabel('Excitation Energy (MeV)');
    zproy=sum(plotcoefs');
    curaxis(1) = min(zexc);
    curaxis(2) = max(zexc);
    curaxis(3) = min(zd2s);
    curaxis(4) = max(zd2s);
    curaxis(5) = min(zscale);
    curaxis(6) = max(zscale);
    curaxis(7) = min(zproy);
    curaxis(8) = max(zproy);
% plot local or global projection of wavelet coefficients
    valpro = get(norp,'Value');
    subplot(2,2,4);
    whitebg('black');
    if (valpro == 1)
        % plot local projection; no zoom, no difference
        plotproy = zproy;
        normpr = 1;
        if (valcoe == 1 | valcoe == 2 )
            plot(zproy,zscale,'y');
        else
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
       end
        grid on;
        ttitel = sprintf('%s local',mwf);
        title(ttitel);
        axis([min(plotproy) max(plotproy) curaxis(5) curaxis(6)]);
        ylabel('Scales (MeV)');
        xlabel('sum of Ca,*');
    elseif (valpro == 2)
        % plot a part of global projection; no zoom, no difference
        plotproy = nproy(binbsave:bintsave);
        normpr = 2;
        if (valcoe == 1 | valcoe == 2 )
            plot(zproy,zscale,'y');
        else
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
        end
        grid on;
        ttitel = sprintf('%s global',mwf);
        title(ttitel);
        axis([min(plotproy) max(plotproy) curaxis(5) curaxis(6)]);
        ylabel('Scales (MeV)');
        xlabel('sum of Ca,*');
    end
    subplot(2,2,1);
    plot(zexc,zd2s,'m');
    ylabel(ylab);
    xlabel('Exitation Energy (MeV)');
    grid on;
    axis([curaxis(1) curaxis(2) curaxis(3) curaxis(4)]);
    % write commands to asci file
    fprintf(outa,'Plot %f %f %f %f %f %f %f %f\n', curaxis);
end