function rebin_fold(fname,fout,exmin,exmax,binsize,fwhm);
% A. Shevchenko: getting rid of PHYSICA. Make analog to rebin.pcm
% HISTORY:
% 051003 - rebin_fold.m started.
% 180204 - fixed small bug for data where the minimal spacing is larger than the final binsize
%20050703 add minres to make it faster for a palaver
%20051023 add more user-friedliness
%20060126 JC Wits
%         1) Preliminary rebinning to zero MeV occurs if ex energy same for consecutive data points.
%            Edit data set to combine consecutive data points. Now warned in output messages.  
%         2) If preliminary rebin size less than 10 eV leads to memory problems.
%            Constrain preliminary rebinning to 10 eV if necessary.

minres=0.001  % limit to 1 keV

if nargin~=6
fprintf(' rebin_fold.m - rebin the folded data to a regular grid...Read .DAT-file, rebin to a fine grid, then smooth, then rebin to final binsize\n');
fprintf(' Usage: rebin_fold(fname,fout,exmin,exmax,binsize,fwhm)\n\n');
fprintf(' 1. fname - name of the input DAT-file with the data\n');
fprintf(' 2. fout - the output filename. If .dat is present - will be dat, if not - will be .MAT\n');
fprintf(' 3+4. exmin,exmax - starting and ending point in MeV\n');
fprintf(' 5. binsize of the output data (MeV)\n');
fprintf(' 6. fwhm - folding width of Gauss-function FWHM (MeV)\n');

if nargin<1
   fname=uigetfile({'*.dat';'*.*'}, 'Input .DAT-file with data...');
   if fname==0
	fprintf('Operation Cancelled!\n');
	return;
   end;
 fprintf('Selected input file %s\n',fname);
end;

[path,nam,ext,versn]=fileparts(fname);

if nargin<2
  fout = [nam '.mat'];
  fout=uiputfile(fout, 'Output file (.DAT or .MAT)...');
   if fout==0
	fprintf('Operation Cancelled!\n');
	return;
   end;
 fprintf('Selected output file %s\n',fout);
end;

def     = {'0.0','30.0','0.01','0.05'};

if nargin==3
def     = {num2str(exmin),'30.0','0.01','0.05'};
end

if nargin==4
def     = {num2str(exmin),num2str(exmax),'0.01','0.05'};
end

if nargin==5
def     = {num2str(exmin),num2str(exmax),num2str(binsize),'0.05'};
end

if nargin<6
   prompt = {'Enter staring Ex (MeV):','Enter ending Ex (MeV):','Enter binsize (MeV):','Enter folding width FWHM (MeV):'};
   dlg_title = 'Input for rebinning and folding function';
   num_lines= 1;
   answer  = inputdlg(prompt,dlg_title,num_lines,def);
   if length(char(answer))==0
	 fprintf('Operation Cancelled!\n');
	 return;
   end;

   exmin = str2num(answer{1});
   exmax = str2num(answer{2});
   binsize = str2num(answer{3});
   fwhm = str2num(answer{4});
   fprintf('Exmin=%f  Exmax=%f binsize=%f fwhm_fold=%f\n',exmin,exmax,binsize,fwhm);

end

if nargin>6
   fprintf('ERROR: TOO MANY ARGUMENTS, %d  instead of 6\n',nargin);
end


end



disp(['Script ' mfilename ' started at ' datestr(now)]);
disp('First Column must be independent variable, second column contains the data!');

disp(['In:' fname ' Out:' fout]);
disp(['Binsize=' num2str(binsize)]);
disp(['E: ' num2str(exmin) '-' num2str(exmax)]);
fprintf('fwhm_smooth=%f\n',fwhm);


%========================================================================


% ALTERNATIVE WAY OF GETTING DATA FROM DAT-FILES:
[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column
disp('Ok, lets do it!aa');

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

% JC 20060126
% Use next fprintf to check for zero distance between points.
% This leads to preliminary binning rebin_fold('non-collective.dat','non-collective_10kev_50.dat',0,30,0.01,0.05)of zero MeV and arithmetic error later.
% Suggest combine data points at that energy.
% Found to be a problem at 0.00001 MeV for non-collective data.
minde=ex_src(2)-ex_src(1); % find the minimal distance between 2 data points in a dataset
for k=2:size1n
 if (ex_src(k)-ex_src(k-1))<minde
    minde=ex_src(k)-ex_src(k-1);
    fprintf('Minimal distance between 2 points is %f at excitation energy %f\n',minde,ex_src(k));
 end
end

disp(['Minimal distance between 2 points is ' num2str(minde)]);
if minde<minres
  fprintf('Minimal distance between 2 points in data is %f and smaller than %f\n',minde,minres);
  minres=minde/10.0;
  fprintf('Decreasing preliminary binning to %f\n',minres);
  if minres<0.00001
     minres=0.00001; % JC 20060126 If binsize less than 10 eV leads to memory problems.
     disp(['Forcing preliminary binning to 0.00001 MeV. Smaller leads to memory problems.']);
  end   
end


%=== rebin data to first to a regular grid with a half of the smallest distance present in the data set

% next thing removes the bug found in Feb.2004
% if final binsize is smaller than the minimal distance, then there appeared dropouts in spectra

if minres>binsize
  fprintf('Warning! Final binsize is smaller than %f!\n',minres);
  minres=binsize/2.0;
end

[ex1,cnts1]=rebin(ex_src,cnts_src,exmin,exmax,minres);
disp(['Pre-Rebin to ' num2str(minres) ' MeV done!']);


% ==== Preprocess data (do smoothing or mean subtraction or whatever here
cnts_smooth = smooth_vl3(cnts1,fwhm/minres);
disp('Folding Done!');

%=== rebin folded data to final binsise
[ex,cnts]=rebin(ex1,cnts_smooth,exmin,exmax,binsize);
disp('Final rebin Done!');

% ==== DO SOME PLOTS OF THE SPECTRA === just for a check that the correct data are analyzed
%figure(1);
%plot(ex_src,cnts_src,'Color','black'); axis tight;
%title(['  Script:' mfilename ' Data: ' fname],'FontSize',fsize);
%set(gcf, 'color', 'white');
%set(gca, 'color', 'white');
%set(gcf, 'InvertHardCopy', 'off');

disp(['Done at ' datestr(now)]);

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



