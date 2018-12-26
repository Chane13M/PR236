% clear old independent and dependent variables if any
% read from the previous file
rawvar = exist('stored2s');
if (rawvar == 1)
    clear stored2s storeexc;
end
% preprocessed variables: input and output of CWT
cwtvar = exist('d2s');
if (cwtvar == 1)
    clear exc d2s coefs scale proy;
end
% zoomed input and output variables
zvar = exist('zd2s');
if (zvar == 1)
    clear zexc zd2s zcoefs zscale zproy zoomed;
end
% get a file name
[fname,pname,findex] = uigetfile('*.out; *.dat; *.txt',...
                          'ASCII file to read?',200,200);
% disable buttons when no data
if (findex == 0)
    warndlg('All variables have gone! You must read a file or exit!',...
            'Idiot!!');
    guicreated = exist('prepb');
    if ( guicreated == 1)
        guistatus = get(prepb,'Enable');
        if (strcmp(guistatus,'on'))
            set(prepb,'Enable','off');
            set(rcwtb,'Enable','off');
            set(pospb,'Enable','off');
            set(mapp,'Enable','off');
            set(norp,'Enable','off');
            set(logp,'Enable','off');
            set(coep,'Enable','off');
        end
    end
end
while (findex ~= 0)
    fpname = strcat(pname,fname);
    textb = uicontrol('Parent',fig,...
                      'Style', 'text',...
                      'String', fpname,...
                      'Position', [120 395 330 20]);
    % get a user defined C-format
    promptf = {strcat('Enter format to read ',fname),...
               'Enter number of variables'};
    dlg_titlef = 'C-Format to read an ASCII file';
    num_linesf = 1;
    deff = {'%f %f','2'};
    answerf = inputdlg(promptf,dlg_titlef,num_linesf,deff);
    % if cancel 
    [sizea1,sizea2] = size(answerf);
    % disable buttons when o data
    if (sizea1 == 0 || sizea2 == 0)
        warndlg('All variables have gone! You must read a file or exit!',...
                'Idiot!!');
        guicreated = exist('prepb');
        if ( guicreated == 1)
            guistatus = get(prepb,'Enable');
            if (strcmp(guistatus,'on'))
                set(prepb,'Enable','off');
                set(rcwtb,'Enable','off');
                set(pospb,'Enable','off');
                set(mapp,'Enable','off');
                set(norp,'Enable','off');
                set(logp,'Enable','off');
                set(coep,'Enable','off');
            end
        end
        break;
    end
    readformat = char(answerf(1,1));
    vartoread = str2num(char(answerf(2,1)));
    fid=fopen(fpname,'r');
    a=fscanf(fid,readformat,[vartoread,inf]);
    % determine independent and dependent variables
    if (vartoread == 1)
        stored2s=a;    
        prompte = {'Enter the lowest energy in MeV',...
                   'Enter the highest energy in MeV'};
        dlg_titlee = 'Specify the independent variable';
        num_linese = 1;
        defe = {'0.0','20.0'};
        answere = inputdlg(prompte,dlg_titlee,num_linese,defe);
        % if cancel 
        [sizea1,sizea2] = size(answere);
        % disable buttons when o data
        if (sizea1 == 0 || sizea2 == 0)
                warndlg('All variables have gone! You must read a file or exit!',...
                'Idiot!!');
            guicreated = exist('prepb');
            if ( guicreated == 1)
                guistatus = get(prepb,'Enable');
                if (strcmp(guistatus,'on'))
                    set(prepb,'Enable','off');
                    set(rcwtb,'Enable','off');
                    set(pospb,'Enable','off');
                    set(mapp,'Enable','off');
                    set(norp,'Enable','off');
                    set(coep,'Enable','off');
                    set(logp,'Enable','off');
                end
            end
            break;
        end
        exmin = str2double(char(answere(1,1)));
        exmax = str2double(char(answere(2,1)));
        binsize = (exmax - exmin)/(length(stored2s) - 1.0);
        ii = 1;
        for ee=exmin:binsize:exmax
            storeexc(ii)=ee;
            ii=ii+1;
        end
    else
        for lev=1:vartoread
            str=int2str(lev);
            if (lev < 10)
                selexc(lev,1)=str;
                selexc(lev,2)=' ';
            else
                selexc(lev,:)=str;
            end
        end
        [dum1,ok]=listdlg('PromptString','Select independent variable',...
                       'ListString',selexc,...
                       'SelectionMode','single',...
                       'CancelString','Stop');
        % if cancel 
        if (ok==0)
                warndlg('All variables have gone! You must read a file or exit!',...
                'Idiot!!');
                % disable buttons when o data
                guicreated = exist('prepb');
                if ( guicreated == 1)
                    guistatus = get(prepb,'Enable');
                    if (strcmp(guistatus,'on'))
                        set(prepb,'Enable','off');
                        set(rcwtb,'Enable','off');
                        set(pospb,'Enable','off');
                        set(coep,'Enable','off');
                        set(mapp,'Enable','off');
                        set(logp,'Enable','off');
                        set(norp,'Enable','off');
                    end
                end
            break;
        end
        storeexc = a(dum1,:);
        binsize = (storeexc(length(storeexc)) - storeexc(1))/(length(storeexc) - 1);
        selexc(dum1,:)=[];
        [dum2,ok]=listdlg('PromptString','Select dependent variable',...
                       'ListString',selexc,...
                       'SelectionMode','single',...
                       'CancelString','Stop');
        % if cancel 
        if (ok==0)
                warndlg('All variables have gone! You must read a file or exit!',...
                'Idiot!!');
                % disable buttons when o data
                guicreated = exist('prepb');
                if ( guicreated == 1)
                    guistatus = get(prepb,'Enable');
                    if (strcmp(guistatus,'on'))
                        set(prepb,'Enable','off');
                        set(rcwtb,'Enable','off');
                        set(pospb,'Enable','off');
                        set(mapp,'Enable','off');
                        set(norp,'Enable','off');
                        set(logp,'Enable','off');
                        set(coep,'Enable','off');
                    end
                end
            break;
        end
        if (dum2 >= dum1) 
        stored2s = a(dum2+1,:);
        else
            stored2s = a(dum2,:);
        end
    end
    % to define the max scale in another file
    sizem = length(storeexc);
    sizen = 1;
    % close input file and clear temporary variables
    clear a lev ii ee str dum1 dum2 selexc;
    fclose(fid);
    % plot the spectrum
    subplot(2,2,1);
    drawnow;
    whitebg('black');
    plot(storeexc,stored2s,'m');
    tstr = sprintf('%3d',1000*binsize);
    ylab = strcat('Counts / ',tstr,' keV');
    ylabel(ylab);
    xlabel('Exitation Energy (MeV)');
    grid on;
    axis([min(storeexc) max(storeexc) min(stored2s) max(stored2s)]);
    % status and default axis settings are saved
    d2s = stored2s;
    exc = storeexc;
    storebinsize = binsize;
    cwtdone = 0;
    zoomed = 0;
    defaxis = [min(exc) max(exc) min(d2s) max(d2s) 0.0 0.0 0.0 0.0];
    % write commands to asci file
    fprintf(outa,'\n%s opened\n', fpname);
    fprintf(outa,'Emin=%f MeV Emax=%f MeV Binsize=%f MeV\n',...
    min(exc), max(exc), binsize);
    clear sizea1 sizea2;
     findex = 0;
    % buttons status
    guicreated = exist('prepb');
    % enable buttons when data exist
    if ( guicreated == 1)
        set(rcwtb,'String','Run/Plot');
        guistatus = get(prepb,'Enable');
        if (strcmp(guistatus,'off'))
            set(prepb,'Enable','on');
            set(rcwtb,'Enable','on');
            set(norp,'Enable','off');
            set(logp,'Enable','off');
            set(coep,'Enable','off');
        end
    end
    clear guicreated guistatus;
end


