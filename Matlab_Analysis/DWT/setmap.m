valmap = get(mapp,'Value');
if (valmap == 1)
    colormap('hsv');
    cmap = 'hsv';
elseif (valmap == 2)
    colormap('jet');
    cmap = 'jet';
elseif (valmap == 3)
    colormap('prism');
    cmap = 'prism';
elseif (valmap == 4)
    colormap('hot');
    cmap = 'hot';
elseif (valmap == 5)
    colormap('gray');
    cmap = 'gray';
else
    fprintf(1,'\a');
end