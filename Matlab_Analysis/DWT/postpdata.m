% Postprocessing of the data
choicean = menu('Postproces data',...
                ' define scales ',...
                ' define region ',...
                '  full region  ');
if (choicean == 1)
     % defune scales by mouse click
     scale_mouse(mousb,outa,normpr);
elseif (choicean == 2)
    % selcect a region 
     k = waitforbuttonpress;
     point1 = get(gca,'CurrentPoint');    % button down detected
     finalRect = rbbox;                   % return figure units
     point2 = get(gca,'CurrentPoint');    % button up detected
     point1 = point1(1,1:2);              % extract x and y
     point2 = point2(1,1:2);
     p1 = min(point1,point2);             % calculate locations
     offset = abs(point1-point2);         % and dimensions
     x = [p1(1) p1(1)+offset(1) p1(1)+offset(1) p1(1) p1(1)];
     y = [p1(2) p1(2) p1(2)+offset(2) p1(2)+offset(2) p1(2)];
     hold on
     plot(x,y,'r')                        % redraw in dataspace units
     hold off
     binl = floor((x(1) - zexc(1))/binsize) + 1;
     if (binl < 1 || binl > length(zexc))
         binl = 1;
     end
     binb = floor((y(2) - zscale(1))/(zscale(2) - zscale(1))) + 1;
     if (binb < 1 || binb > length(zscale))
         binb = 1;
     end
     binr = floor((x(2) - zexc(1))/binsize) + 1;
     if (binr < 1 || binr > length(zexc))
         binr = length(zexc);
     end
     bint = floor((y(3) - zscale(1))/(zscale(2) - zscale(1))) + 1;
     if (bint < 1 || bint > length(zscale))
         bint = length(zscale);
     end
     zoomed = 1;
 elseif (choicean == 3)
     % restore a region CWT was done for
     zexc = exc;
     zd2s = d2s;
     zcoefs = coefs;
     zscale = scale;
     zproy = proy;
     subplot(2,2,1);
     plot(zexc,zd2s,'m');
     ylabel(ylab);
     xlabel('Excitation Energy (MeV)');
     grid on;
     curaxis(1) = min(exc);
     curaxis(2) = max(exc);
     curaxis(3) = min(d2s);
     curaxis(4) = max(d2s);
     curaxis(5) = 0.0;
     curaxis(6) = max(scale);
     curaxis(7) = min(proy);
     curaxis(8) = max(proy);
     axis([curaxis(1) curaxis(2) curaxis(3) curaxis(4)]);
     subplot(2,2,3);
     imagesc(zexc,zscale,zcoefs);
     axis xy;
     ylabel('Scales (MeV)');
     xlabel('Excitation Energy (MeV)');
     subplot(2,2,4);
     whitebg('black');
     hold off;
     set(logp,'Enable','off');
     set(logp,'Value',1);
     setlogs = 'lin-lin';
     plot(zproy,zscale,'y');
     grid on;
     set(norp,'Value',2);
     normpr = 2;
     ttitle = sprintf('%s global',mwf);
     title(ttitle);
     clear ttitle;
     axis([curaxis(7) curaxis(8) curaxis(5) curaxis(6)]);
     ylabel('Scales (MeV)');
     xlabel('sum of Ca,*');
     zoomed = 0;
     set(coep,'Value',1);
     set(logp,'Value',1);
else
    fprintf(1,'\07');
end