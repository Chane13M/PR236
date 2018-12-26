function scale_mouse(tb,fn,ifn)
disp('Left mouse button picks points.')
disp('Right mouse button picks last point.')
xy = [];
n = 0;
but = 1;
while but == 1
    [xi,yi,but] = ginput(1);
    hold on;
    plot(xi,yi,'gx','MarkerSize',12);
    n = n+1;
    xy(:,n) = [xi;yi];
   % print scales on the screen
   fprintf('Scale at %f MeV \t Projection %f\n',yi,xi);
   % write scales to asci file
   if (ifn == 1)
       fprintf(fn,'Local scale at %f MeV\n', yi);
   elseif (ifn == 2)
       fprintf(fn,'Global scale at %f MeV\n', yi);
   else
       fprintf(fn,'Unknown scale at %f MeV\n', yi);
   end       
   % display scales on the figure
   sstr = sprintf('%f',yi);
   scalestr = strcat('Scale at :',sstr,' MeV');
   set(tb,'Visible','on',...
             'String',scalestr);   
end
% remove button with scales from the figure;
set(tb,'Visible','off', 'String', ' ');
hold off;
