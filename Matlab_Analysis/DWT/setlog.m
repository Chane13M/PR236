vallog = get(logp,'Value');
rr = exist('zproy');
if (rr == 1)
    if (vallog == 1)
        setlogs = 'lin-lin';
        runplotcwt;
    elseif (vallog == 2)
        setlogs = 'lin-log';
        runplotcwt;
    elseif (vallog == 3)
        setlogs = 'log-lin';
        runplotcwt;
    elseif (vallog == 4)
        setlogs = 'log-log';
        runplotcwt;
    end
    clear vallog;
else    
    errordlg('Nothing to plot! You must run CWT first!',...
             '        Idiot!!!        ');
end
clear rr;
    