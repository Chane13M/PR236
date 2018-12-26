% preprocess data in desired
choicepp = menu('Preprocess data',...
                ' interpolation ',...
                'select interval',...
                ' subtract mean ',...
                'smooth the data',...
                'subtract smooth',...
                'stationary data',...
                '  running sum  ',...
                '  derivatives  ',...
                '  restore raw  ');
if (choicepp == 1)
% if not equidistant one can make a spline interpolation; also rebinning    
    promptb = {'Enter bin size in MeV'};
    dlg_titleb = 'Bin size';
    num_linesb = 1;
    defb = {'0.01'};
    answerb = inputdlg(promptb,dlg_titleb,num_linesb,defb);
    % if cancel 
    [sizea1,sizea2] = size(answerb);
    if (sizea1 == 0 || sizea2 == 0)
        fprintf(1,'\a');
    else
        newbinsize = str2double(char(answerb(1,1)));
        binsize = newbinsize;
        ii = 1;
        for erbin = exc(1):newbinsize:exc(length(exc))
            excb(ii) = erbin;
            ii = ii +1;
        end
%        d2si = interp1(exc, d2s, excb, 'linear');
        d2si = interp1(exc, d2s, excb, 'linear');
        clear exc d2s;
        exc = excb;
        d2s = d2si;
        % write commands to asci file
        fprintf(outa,'Spline interpolation for binsize %f done\n', newbinsize);
        clear sizea1 sizea2 answerb ii erbin excb d2si newbinsize;
        % plot smoothed spectrum
        subplot(2,2,1);
        hold off;
        plot(exc,d2s,'r');
        ylabel(ylab);
        xlabel('Excitation Energy (MeV)');
        grid on;
        curaxis(1) = min(exc);
        curaxis(2) = max(exc);
        curaxis(3) = min(d2s);
        curaxis(4) = max(d2s);
        axis([curaxis(1) curaxis(2) curaxis(3) curaxis(4)]);
    end
elseif (choicepp == 2)
% select interval to proceed
    [dum1,dum2] = ginput(1);
    if (dum1 <= exc(1) || dum1 >= exc(length(exc)))
        fb = 1;
    else
        fb = floor((dum1 - exc(1))/binsize) + 1;
    end
    [dum1,dum2] = ginput(1);
    if (dum1 <= exc(1) || dum1 >= exc(length(exc)))
        lb = length(exc);
    else
        lb = floor((dum1 - exc(1))/binsize);
    end
    xl = min(fb,lb);
    xr = max(fb,lb);
    tmpe = exc;
    tmpd = d2s;
    clear exc d2s;
    exc = tmpe(xl:xr);
    d2s = tmpd(xl:xr);
    clear tmpe tmpd;
    curaxis(1) = min(exc);
    curaxis(2) = max(exc);
    curaxis(3) = min(d2s);
    curaxis(4) = max(d2s);
    subplot(2,2,1);
    plot(exc,d2s,'m');
    ylabel(ylab);
    xlabel('Excitation Energy (MeV)');
    grid on;
    axis([curaxis(1) curaxis(2) curaxis(3) curaxis(4)]);
    % write commands to asci file
    fprintf(outa,'Emin=%f Emax=%f selected\n', min(exc), max(exc));
elseif (choicepp == 3)
% subtract the mean value
	meand2s = sum(d2s)/length(d2s);
    d2s = d2s - meand2s;
    clear meand2s;
    subplot(2,2,1);
    hold off;
    plot(exc,d2s,'y');
    ylabel(ylab);
    xlabel('Excitation Energy (MeV)');
    grid on;
    curaxis(1) = min(exc);
    curaxis(2) = max(exc);
    curaxis(3) = min(d2s);
    curaxis(4) = max(d2s);
    axis([curaxis(1) curaxis(2) curaxis(3) curaxis(4)]);
    % write commands to asci file
    fprintf(outa,'Mean value subtracted\n');
elseif (choicepp == 4)
% smooth the data
    prompts = {'Enter fwhm in bins for smoothing','Enter number of contributing bins'};
    dlg_titles = 'FWHM';
    num_liness = 1;
    defs = {'3','50'};
    answers = inputdlg(prompts,dlg_titles,num_liness,defs);
    % if cancel 
    [sizea1,sizea2] = size(answers);
    if (sizea1 == 0 || sizea2 == 0)
        fprintf(1,'\a');
    else
        fwhm_smooth = str2num(char(answers(1,1)));
        effnb = str2num(char(answers(2,1)));
        d2s_smooth = gaussfold(exc,d2s,fwhm_smooth*binsize,effnb);
        d2s = d2s_smooth;
        clear d2s_smooth fwhm_smooth;
        subplot(2,2,1);
        hold off;
        plot(exc,d2s,'g');
        ylabel(ylab);
        xlabel('Excitation Energy (MeV)');
        grid on;
        curaxis(1) = min(exc);
        curaxis(2) = max(exc);
        curaxis(3) = min(d2s);
        curaxis(4) = max(d2s);
        axis([curaxis(1) curaxis(2) curaxis(3) curaxis(4)]);
        % write commands to asci file
        fprintf(outa,'Data smoothed with effnb=%d\n',effnb);
    end
    clear sizea1 sizea2 answers;
elseif (choicepp == 5)
% smooth the data and subtract smoothed signal
    prompts = {'Enter fwhm in bins for smoothing','Enter number of contributing bins'};
    dlg_titles = 'FWHM';
    num_liness = 1;
    defs = {'3','50'};
    answers = inputdlg(prompts,dlg_titles,num_liness,defs);
    % if cancel 
    [sizea1,sizea2] = size(answers);
    if (sizea1 == 0 || sizea2 == 0)
        fprintf(1,'\a');
    else
        fwhm_smooth = str2num(char(answers(1,1)));
        effnb = str2num(char(answers(2,1)));
        d2s_smooth = gaussfold(exc,d2s,fwhm_smooth*binsize,effnb);
        d2s_smooth = (d2s_smooth)';
        d2s = d2s - d2s_smooth;
        clear d2s_smooth fwhm_smooth;
        subplot(2,2,1);
        hold off;
        plot(exc,d2s,'b');
        ylabel(ylab);
        xlabel('Excitation Energy (MeV)');
        grid on;
        curaxis(1) = min(exc);
        curaxis(2) = max(exc);
        curaxis(3) = min(d2s);
        curaxis(4) = max(d2s);
        axis([curaxis(1) curaxis(2) curaxis(3) curaxis(4)]);
        % write commands to asci file
        fprintf(outa,'Data smoothed with effnb=%d\n',effnb);
        fprintf(outa,'Smoothed version subtracted\n');
    end
    clear sizea1 sizea2 answers;
elseif (choicepp == 6)
% produce a stattionary spectrum
    prompts = {'Enter fwhm in bins for smoothing','Enter number of contributing bins'};
    dlg_titles = 'FWHM';
    num_liness = 1;
    defs = {'3','50'};
    answers = inputdlg(prompts,dlg_titles,num_liness,defs);
    % if cancel 
    [sizea1,sizea2] = size(answers);
    if (sizea1 == 0 || sizea2 == 0)
        fprintf(1,'\a');
    else
        fwhm_smooth = str2num(char(answers(1,1)));
        effnb = str2num(char(answers(2,1)));
        d2s_smooth = gaussfold(exc,d2s,fwhm_smooth*binsize,effnb);
        d2s_smooth = (d2s_smooth)';
        d2s = d2s ./ d2s_smooth - 1.0;
        clear d2s_smooth fwhm_smooth;
        subplot(2,2,1);
        hold off;
        plot(exc,d2s,'c');
        ylabel(ylab);
        xlabel('Excitation Energy (MeV)');
        grid on;
        curaxis(1) = min(exc);
        curaxis(2) = max(exc);
        curaxis(3) = min(d2s);
        curaxis(4) = max(d2s);
        axis([curaxis(1) curaxis(2) -1.0 1.0]);
        % write commands to asci file
        fprintf(outa,'Data smoothed with effnb=%d\n',effnb);
        fprintf(outa,'Stationary spectrum produced\n');
    end
    clear sizea1 sizea2 answers;
elseif (choicepp == 7)
% running sum average
    prompts = {'Enter fwhm in bins for smoothing'};
    dlg_titles = 'FWHM';
    num_liness = 1;
    defs = {'3'};
    answers = inputdlg(prompts,dlg_titles,num_liness,defs);
    % if cancel 
    [sizea1,sizea2] = size(answers);
    if (sizea1 == 0 || sizea2 == 0)
        fprintf(1,'\a');
    else
        fwhm_smooth = str2num(char(answers(1,1)));
        d2s_smooth = runsum(d2s,fwhm_smooth);
        d2s = d2s_smooth;
        % write commands to asci file
        fprintf(outa,'Running sum average %d\n', fwhm_smooth);
        clear d2s_smooht fwhm_smooth;
        % plot smoothed spectrum
        subplot(2,2,1);
        hold off;
        plot(exc,d2s,'w');
        ylabel(ylab);
        xlabel('Excitation Energy (MeV)');
        grid on;
        curaxis(1) = min(exc);
        curaxis(2) = max(exc);
        curaxis(3) = min(d2s);
        curaxis(4) = max(d2s);
        axis([curaxis(1) curaxis(2) curaxis(3) curaxis(4)]);
    end
    clear sizea1 sizea2 answers;
elseif (choicepp == 8)
% take a derivative
	gradd2s = gradient(d2s);
    d2s = gradd2s;
    clear gradd2s;
    subplot(2,2,1);
    hold off;
    plot(exc,d2s,'y');
    ylabel(ylab);
    xlabel('Excitation Energy (MeV)');
    grid on;
    curaxis(1) = min(exc);
    curaxis(2) = max(exc);
    curaxis(3) = min(d2s);
    curaxis(4) = max(d2s);
    axis([curaxis(1) curaxis(2) curaxis(3) curaxis(4)]);
    % write commands to asci file
    fprintf(outa,'Derivative is taken\n');
elseif (choicepp == 9)
% restore read from file data
    clear exc d2s;
    d2s = stored2s;
    exc = storeexc;
    binsize = storebinsize;
    subplot(2,2,1);
    hold off;
    plot(exc,d2s,'m');
    ylabel(ylab);
    xlabel('Excitation Energy (MeV)');
    grid on;
    curaxis(1) = min(exc);
    curaxis(2) = max(exc);
    curaxis(3) = min(d2s);
    curaxis(4) = max(d2s);
    axis([curaxis(1) curaxis(2) curaxis(3) curaxis(4)]);
    warndlg('All coefficients have gone! You must run a new CWT or exit!',...
            'Attention!');
    % write commands to asci file
    fprintf(outa,'Original data restored\n');
else
    fprintf(1,'\07');
end
if (choicepp ~= 0)
    % clear postprocess variables if any
    zvar = exist('zd2s');
    if (zvar == 1)
        clear zexc zd2s zcoefs zscale zproy;
    end
    % disable postprocessing and enable CWT
    set(pospb,'Enable','off');
    zoomed = 0;
    set(rcwtb,'String','Run/Plot');
    cwtdone = 0;
end    
