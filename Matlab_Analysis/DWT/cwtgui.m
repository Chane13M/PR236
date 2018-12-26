% Y. Kalmykov and A. Shevchenko, IKP TU-Darmstadt, 2003-2004

% clear everything and modify the path
clear;
close all;
set(0,'DefaultTextFontSize',10);
set(0,'DefaultTextInterpreter','tex');
set(0,'DefaultAxesFontSize',10);
set(0,'DefaultAxesLineWidth',0.5);
%path('z:\Si28\cwtgui',path);
%path('C:\Users\Usman\Documents\GR Experiment\28Si 12deg\cwtgui',path);
path('C:\Users\A0000891\Documents\MATLAB\cwtgui',path);
% how to convert scales in FWHM
fwhm_factor = 3.0;
% which wavelet use
mwf = 'morl';
% how to plot projection of CWT coefficient
setlogs = 'lin-lin';
normpr = 0;
% if already read a file
readfile = 0;
% if CWT is done
cwtdone = 0;
% open file to save commands
outa = fopen('cwtgui.dat','w');
den = date;
chas = fix(clock);
fprintf(outa,'Started on %s at %2d:%2d:%2d\n',...
        den, chas(4), chas(5), chas(6));
clear den chas;
% create a figure to plot everything and GUI
fig = figure('NumberTitle','off',...
             'Name','cwt', ...
             'Resize', 'on',...
             'Position',[360 300 560 406]);
% must be called after fig created, otherwise you have 2 figures
colormap('hsv');
% create menus on the figure
dummm = uimenu('Label','    ',...
               'Position',[8],...
               'Enable','off');
readm = uimenu('Label','Read',...
               'Position',[9],...
               'ForegroundColor','r');
    uimenu(readm,'Label','Read ASCI',...
                 'Callback','createbuttons; getascif;');
    uimenu(readm,'Label','Read mat ',...
                 'Callback','createbuttons; getmatf;');
% to be done
%    uimenu(readm,'Label','Read coef',...
%                 'Callback','getmatf; createbuttons;');
savem = uimenu('Label','Save',...
               'Position',[10],...
               'ForegroundColor',[1 0 0]);
    uimenu(savem,'Label','Save ASCI',...
                 'Callback','savecom');
    uimenu(savem,'Label','Save mat ',...
                 'Callback','savemat')
exitm = uimenu('Label','Exit',...
               'Position',[11],...
               'ForegroundColor',[1 0 0]);
    uimenu(exitm,'Label','Exit',...
                 'Callback','exitgui');

