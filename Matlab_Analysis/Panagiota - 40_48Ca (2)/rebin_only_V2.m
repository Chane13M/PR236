function rebin_only_V2(fname,fout,exmin,exmax,binsize);
% A. Shevchenko: getting rid of PHYSICA. Make analog to rebin.pcm
% HISTORY:
% 051003 - rebin_only.m started.

if nargin~=5
fprintf(' rebin_only.m - rebin the data to a regular grid...Read .DAT-file, rebin to a 1keV grid, then smooth, then rebin to final binsize\n');
fprintf(' Usage: rebin_only(fname,fout,exmin,exmax,binsize)\n\n');
fprintf(' 1. fname - name of the input DAT-file with the data without extenstion!\n');
fprintf(' 2. fout - the output MAT-filename\n');
fprintf(' 3+4. exmin,exmax - starting and ending point in MeV\n');
fprintf(' 5. binsize of the output data\n');
return;
end



disp(['Script ' mfilename ' started at ' datestr(now)]);

disp('First Column must be independent variable, second column contains the data!');

disp(['In:' fname ' Out:' fout]);
disp(['Binsize=' num2str(binsize)]);
disp(['E: ' num2str(exmin) '-' num2str(exmax)]);


%========================================================================


% ALTERNATIVE WAY OF GETTING DATA FROM DAT-FILES:
[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column


[size1m,size1n]=size(ex_src);
[size2m,size2n]=size(cnts_src);

%if ((size1m~=size2m)||(size1n~=size2n))
%   disp('Ok, lets do it-0!');
%   fprintf('OOPS, the dimentions of 1st and 2nd column are not equal! There might be a problem there!');
%endif

% transpone the vector if needed - to be compatible to both cases of input data
if (size1m>size1n)
  ex_src=ex_src';
  cnts_src=cnts_src';
  [size1m,size1n]=size(ex_src);
  [size2m,size2n]=size(cnts_src);
end

minde=ex_src(2)-ex_src(1); % find the minimal distance between 2 data points in a dataset
for k=2:size1n
 if (ex_src(k)-ex_src(k-1))<minde
    minde=ex_src(k)-ex_src(k-1);
 end
 if(cnts_src(k)<0.0)
   fprintf('OOPS, k=%d CNTS=%f\n',k,cnts_src(k));
 end
end

disp(['Minimal distance between 2 points is ' num2str(minde)]);


[ex,cnts]=rebin_V2(ex_src,cnts_src,exmin,exmax,binsize);

% ==== DO SOME PLOTS OF THE SPECTRA === just for a check that the correct data are analyzed
figure(1);
%subplot(2,1,1); plot(ex_src,cnts_src,'Color','black'); axis tight;
subplot(2,1,1); stairs(ex_src,cnts_src,'Color','black'); axis tight;
%title(['  Script:' mfilename '  Data: ' fname],'FontSize',fsize);
set(gcf, 'color', 'white');
set(gca, 'color', 'white');
set(gcf, 'InvertHardCopy', 'off');

%subplot(2,1,2); plot(ex,cnts,'Color','black'); axis tight;
subplot(2,1,2); stairs(ex,cnts,'Color','green'); axis tight;
%title(['  Script:' mfilename '  Data: ' fname],'FontSize',fsize);
set(gcf, 'color', 'white');
set(gca, 'color', 'white');
set(gcf, 'InvertHardCopy', 'off');

disp(['Done at ' datestr(now)]);

% ==== SAVE to DAT file ==============
%foutd = fopen(fout,'w');
%fprintf(foutd,'%13.8f\t%13.8f\n',[ex; cnts]);
%fclose(foutd);
% ==== SAVE to MAT file ==============
if (size(strfind(fout,'.dat'))~=0)
% then save in dat format
        fid = fopen(fout,'w');
        fprintf(fid,'%12.5f  %15.10f\n',[ex;cnts]);
        fclose(fid);
   return;
else
save(fout,'cnts');

end


end