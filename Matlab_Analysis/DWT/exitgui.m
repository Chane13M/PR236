gohome = 1;
qbutton = questdlg('If you quit, all unsaved commands and scales will be written in cwtgui.dat . Do you want to rename cwtgui.dat?',...
                   'Attention');
if (strcmp(qbutton,'Yes'))
    savecom;
    fclose(outa);
elseif (strcmp(qbutton,'No'))
    den = date;
    chas = fix(clock);
    fprintf(outa,'Stopped on %s at %2d:%2d:%2d\n',...
            den, chas(4), chas(5), chas(6));
    clear den chas;
    fclose(outa);
else
    gohome = 0;
end
if (gohome ~= 0)
    qbutton = questdlg('If you quit, all unsaved variables will be lost. Do you want to save them?',...
                       'Attention');
    if (strcmp(qbutton,'Yes'))
        savemat;
        close(fig);
        clear;
    elseif (strcmp(qbutton,'No'))
        close(fig);
        clear;
    else
        outa = fopen('cwtgui.dat','w');
        den = date;
        chas = fix(clock);
        fprintf(outa,'Stopped on %s at %2d:%2d:%2d\n',...
                den, chas(4), chas(5), chas(6));
        clear den chas;
    end
end    