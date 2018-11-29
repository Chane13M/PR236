function [datei]=read_file(fname);
% versatile tool to read data in
% works for mat and dat files
%returns [datei];

if length(fname)>0
   [fid,message] = fopen(fname,'r');
   pathname='';
   filename=fname;
   if fid == -1
     disp(message);
   end
else
  fid=0;
  while fid < 1
    [filename, pathname] = uigetfile('*.*', 'Select a datafile to be plotted...');
    if isequal(filename,0)|isequal(pathname,0)
        disp('File not found');
    else
        disp(['File ', pathname, filename, ' found']);
    end
   fname=[pathname filename];
   [fid,message] = fopen(fname,'r');
  end
end

if fid == -1
  disp(message);
end

disp(['Reading data from file ' fname]);

% check if it is a DAT or MAT file
if (size(strfind(fname,'.mat'))~=0)
    S=load(fname);
    eval(['whos -file ' fname]);

  else

   y = 0;
  % detect the header lines if any
  skip=1;
  while ((feof(fid) == 0) & (skip>0))
     tline = fgetl(fid);
     disp(['First line: ' tline]);
     matches = findstr(tline, '!');
     skip = length(matches);
     y=y+1;
  end

  % Define how many columns of data are there in the file
  fl_stop=0;
  columns_num=0;
  remstr='notemptystring'; % just not to stop at the start
  while (length(strtok(tline))>0)
    [token,remstr]=strtok(tline);
    disp(['Token=' token]);
    tline=remstr;
    columns_num=columns_num+1;
  end
  fclose(fid);
  y=y-1;
  disp(['Detected ' num2str(y) ' header lines and ' num2str(columns_num) ' columns of data']);

  % now skip the detected number of header lines
  [fid,message] = fopen(fname,'r');
  if fid == -1
    disp(message);
  end
  while ((feof(fid) == 0) & (y>0))
     tline = fgetl(fid);
     y=y-1;
  end

  [datei] = fscanf(fid,'%e',[columns_num,inf]);
  fclose(fid);

end   % of reading in .dat-file

