% create buttons to control program execution
if (readfile == 0)
    cmwfb = uicontrol('Parent',fig,...
                      'Style', 'pushbutton',...
                      'String', '  Wavelet ',...
                      'Position', [265 359 70 30],...
                      'Callback', 'choosewf');
    prepb = uicontrol('Parent',fig,...
                      'Style','pushbutton',...
                      'String', 'Preprocess',...
                      'Position', [336 359 70 30],...
                      'Callback', 'prepdata');
    rcwtb = uicontrol('Parent',fig,...
                      'Style', 'pushbutton',...
                      'String', ' Run/Plot ',...
                      'Position', [407 359 70 30],...
                      'Callback', 'runplotcwt');
    pospb = uicontrol('Parent',fig,...
                      'Style', 'pushbutton',...
                      'String', 'Postprocess',...
                      'Position', [478 359 70 30],...
                      'Callback', 'postpdata');
% create text button
    mousb = uicontrol('Parent',fig,...
                      'Style', 'text',...
                      'Visible', 'off',...
                      'Position', [265 240 283 30]);
% create popup menues
    coep = uicontrol('Style', 'popup',...
                     'String',...
                     '  values  | by scale | absolute |abs+scales|  square  |sqr+scales',...
                     'Position', [265 320 69 10],...
                     'ForegroundColor','b',...
                     'Enable','off');
    mapp = uicontrol('Style', 'popup',...
                     'String', '  hsv  |  jet  | prism |  hot  | gray  ',...
                     'Position', [336 320 69 10],...
                     'ForegroundColor','m',...
                     'Enable','off',...
                     'Callback', 'setmap');
    norp = uicontrol('Style', 'popup',...
                     'String', ' local  | global ',...
                     'Position', [408 320 69 10],...
                     'ForegroundColor','b',...
                     'Enable','off');
    logp = uicontrol('Style', 'popup',...
                     'String', 'lin-lin|lin-log|log-lin|log-log',...
                     'Position', [479 320 69 10],...
                     'ForegroundColor','m',...
                     'Enable','off',...
                     'Callback', 'setlog');
    readfile = 1;
end
% disable postprocessing befor CWT
if (cwtdone == 0)
    set(pospb,'Enable','off');
end