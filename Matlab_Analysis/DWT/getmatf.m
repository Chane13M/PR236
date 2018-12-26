% clear old independent and dependent variables if any
% read from the previous file
rawvar = exist('stored2s');
if (rawvar == 1)
    clear stored2s storeexc;
end
% preprocessed variables: input and output of CWT
cwtvar = exist('d2s');
if (cwtvar == 1)
    clear exc d2s coefs scale proy zoomed;
end
% zoomed input and output variables
zvar = exist('zd2s');
if (zvar == 1)
    clear zexc zd2s zcoefs zscale zproy;
end
clear rawvar cwtvar zvar;
% get file name
[fname,pname,findex]=uigetfile('*.mat','Spectrum to analyze?',200,200);
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
% open and read mat-file
while (findex ~= 0)
    fpname=strcat(pname,fname);
    textb = uicontrol('Parent',fig,...
                      'Style', 'text',...
                      'String', fpname,...
                      'Position', [120 395 330 20]);
    filestructure=whos('-file',fpname);
    load(fpname);
    numofvar = length(filestructure);
    if (numofvar > 1)
        for lev=1:numofvar
            str=int2str(lev);
            if (lev < 10)
                selvar(lev,1)=str;
                selvar(lev,2)=' ';
            else
                selvar(lev,:)=str;
            end
        end
        [dum1,ok]=listdlg('PromptString','Select independent variable',...
                      'ListString',selvar,...
                      'SelectionMode','single',...
                      'CancelString','Stop');
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
        selvar(dum1,:)=[];
        [dum2,ok]=listdlg('PromptString','Select dependent variable',...
                       'ListString',selvar,...
                       'SelectionMode','single',...
                       'CancelString','Stop');
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
            data = eval(filestructure(dum2 + 1).name);
        else
            data = eval(filestructure(dum2).name);
        end
        storeexc = eval(filestructure(dum1).name);
        [sizem,sizen] = size(storeexc);
        if (sizem > 1 && sizen > 1)
            errordlg('It is not a 1d-variable!',...
                     'Shit happens while reading a file ...');
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
        binsize = (storeexc(length(storeexc)) - storeexc(1))/(length(storeexc) - 1);
% transpose the matrix if needed - to be compatible to both cases of input data
        [sizem,sizen]=size(data);
        if ( sizen == 1 && sizem > sizen)
            stored2s = data;
            [sizem,sizen] = size(stored2s);
        elseif (sizem == 1 && sizen > sizem)
            stored2s = data';
            [sizem,sizen] = size(stored2s);
        else
            errordlg('It is not a 1d-variable!',...
                     'Shit happens while reading a file ...');
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
    else
        data = eval(filestructure.name);
        [sizem,sizen] = size(data);
% transpose the matrix if needed - to be compatible to both cases of input data
        if ( sizen == 1 && sizem > sizen)
            stored2s = data;
            [sizem,sizen] = size(stored2s);
            prompte = {'Enter the lowest energy in MeV',...
                       'Enter the highest energy in MeV'};
            dlg_titlee = 'Specify the independent variable';
            num_linese = 1;
            defe = {'0.0','20.0','0.01'};
            answere = inputdlg(prompte,dlg_titlee,num_linese,defe);
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
                        set(logp,'Enable','off');
                        set(coep,'Enable','off');
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
        elseif (sizem == 1 && sizen > sizem)
            stored2s = data';
            prompte = {'Enter the lowest energy in MeV',...
                       'Enter the highest energy in MeV'};
            dlg_titlee = 'Specify the independent variable';
            num_linese = 1;
            defe = {'0.0','20.0'};
            answere = inputdlg(prompte,dlg_titlee,num_linese,defe);
            [sizea1,sizea2] = size(answere);
            % disable buttons when o data
            if (sizea1 == 0 || sizea2 == 0)
                warndlg('All variables have gone! You must read a file or exit!',...
                'Idiot!!');
                guicreated = exist('prepb');
                if ( guicreated == 1)
                   guistatus = get(prepb,'Enable');
                   if (strcmp(guistatus ,'on'))
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

            exmin = str2double(char(answere(1,1)));
            exmax = str2double(char(answere(2,1)));
            binsize = (exmax - exmin)/(length(stored2s) - 1.0);
            ii = 1;
            for ee=exmin:binsize:exmax 
                storeexc(ii)=ee;
                ii=ii+1;
            end
        else
            errordlg('It is not a 1d-variable!','Shit happens while reading a file ...');
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
    end
    subplot(2,2,1)
    whitebg('black');
    plot(storeexc,stored2s,'m');
    tstr = sprintf('%3d',1000*binsize);
    ylab = strcat('Counts / ',tstr,' keV');
    ylabel(ylab);
    xlabel('Excitation Energy (MeV)');
    grid on;
    axis([min(storeexc) max(storeexc) min(stored2s) max(stored2s)]);
    % status is saved
    d2s = stored2s;
    exc = storeexc;
    storebinsize = binsize;
    cwtdone = 0;
    zoomed = 0;
    defaxis = [min(exc) max(exc) min(d2s) max(d2s) 0.0 0.0 0.0 0.0];
    curaxis = defaxis;
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