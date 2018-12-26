function res=smooth_vl3(s, dx)
% smooth 1D-data s with Lorentzian filter having gamma dx
% value for dx should be given in unitsofabscisse/binsize
% Example: if we have uniformly distributed data with binsize 0.01 MeV:
% Ex(MeV) counts
% 0.00 s1
% 0.01 s2
% 0.02 s3
% .....
% then to smooth s with lorentzian having a certain gamma
% one has to give dx = gamma / 0.01 = FWHM / binsize
% where 0.01 = binsize 
% from FWHM
x=1:length(s);
%x=x/100.;

nps=length(s);
res(1:length(s))=0.0;
r(1:length(s))=0.0;
prozk=floor(nps/100.);
fprintf('1 prozent = %d steps...\n',prozk);

dx2sq=(dx/2)^2;
dx2sqin=1/dx2sq;

for ki=1:nps
 if(s(ki)~=0.0)
%  r=((dx/2)^2)/((x(ki)-x).^2 + (dx/2)^2); 
   r=(dx2sq./((x(ki)-x).^2 + dx2sq));
%  r=(dx2sqin*(((x(ki)-x).^2) + dx2sq));
   r=r/sum(r); 
   res=res+s(ki).*r;   
 end

 if(mod(ki,100)==0)
	fprintf('%f percent Done...k=%d of %d\n',ki/prozk, ki,nps);
  end
end
 
return

