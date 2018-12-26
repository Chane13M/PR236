function [data,fnameout]=read_dat(fnamein,column);
% function to take data from some ascii DAt-file
% to be called from other m-files

if(length(fnamein)==0)
    [filename, pathname] = uigetfile('*.dat', 'Select DAT-file to take data from...');
    if isequal(filename,0)|isequal(pathname,0)
        disp('File not found');
    end
   fnamein=strcat(pathname,filename);
end
[fid,message] = fopen(fnamein,'r');
if fid == -1
   disp(message);
   stop;
end
disp(['File ' fnamein ' opened...']);
y = 0;
% ========= detect the header lines if any ============
skip=1;
while ((feof(fid) == 0) & (skip>0))
   tline = fgetl(fid);
   disp([tline]);
   matches = findstr(tline, '!');
   skip = length(matches);
   y=y+1;
end

% Define how many columns of data are there in the file
fl_stop=0;
columns_num=0;
remstr='sdfgsfdg'; % just not to stop at the start
while (length(strtok(tline))>0)
    [token,remstr]=strtok(tline);
    tline=remstr;
    columns_num=columns_num+1;
end
fclose(fid);
y=y-1;
disp(['Detected ' num2str(y) ' header lines and ' num2str(columns_num) ' columns of data']);

% now skip the detected number of header lines
[fid,message] = fopen(fnamein,'r');
if fid == -1
   disp(message);
end
while ((feof(fid) == 0) & (y>0))
   tline = fgetl(fid);
   y=y-1;
end

[datei] = fscanf(fid,'%e',[columns_num,inf]);
fclose(fid); 

if (column==0)
    column = input('Column to extract: '); 
end
data = datei(column,:);
fnameout=fnamein;
