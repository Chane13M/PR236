function res=smooth_v3(s, dx)
% smooth 1D-data s with gaussian filter having standard deviation dx
% value for dx should be given in unitsofabscisse/binsize
% Example: if we have uniformly distributed data with binsize 0.01 MeV:
% Ex(MeV) counts
% 0.00 s1
% 0.01 s2
% 0.02 s3
% .....
% then to smooth s with gaussian having a certain FWHM
% one has to give dx = FWHM / 2.35 / 0.01 = FWHM / 2.35 / binsize
% where 0.01 = binsize and factor 2.35 is used to get standard deviation
% from FWHM
x=1:length(s);
%x=x/100.;

nps=length(s);
res(1:length(s))=0.0;
r(1:length(s))=0.0;
prozk=floor(nps/100.);
fprintf('1 prozent = %d steps...\n',prozk);

for ki=1:nps
 if(s(ki)~=0.0)
   r=exp(-0.5 * ((x(ki)-x)/dx).^2);
   r=r/sum(r); 
   res=res+s(ki).*r;   
 end

 if(mod(ki,100)==0)
	fprintf('%f percent Done...k=%d of %d\n',ki/prozk, ki,nps);
  end
end
 
return

