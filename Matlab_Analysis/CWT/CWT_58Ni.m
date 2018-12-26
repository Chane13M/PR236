%=========================================================================
% 58Ni ISGMR

fname='58Ni_ExCs_10_24_10kev.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

%ex_12_24_10keV(1:1400)=ex_src(1:1400); % Excitation energy 12-24 MeV in 10 keV steps  
Ni58_cs_10_24_10keV(1:1400)=cnts_src(1:1400); % Retief 48Ca(p,p') cross-section (mb/sr MeV)


figure (130);
subplot(4,2,2); stairs(ex_10_24_10keV,Ni58_cs_10_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 35]);
ylabel('d^2\sigma/d\OmegadE (mb / sr MeV)');
%xlabel('Excitation energy (MeV)');
title('{}^{58}Ni(\alpha,\alpha\prime)   E_{Lab} = 200 MeV');



%==========================================================================
y1=Ni58_cs_10_24_10keV; % Retief 48Ca(p,p') cross-section (mb/sr MeV)
%==========================================================================

nscales=600;

binsize=10; % 10 keV bin size
scale_min=1*binsize;
scale_max=nscales*binsize;

gdr_min=1; % GDR Ex = 12.0 to 24.0 MeV
gdr_max=1400;

xmev2=(999+gdr_min):(999+gdr_max);  % GDR cut from gdr_min to gdr_max
xmev2=xmev2*binsize/1000;


y1(isnan(y1))=0;
m1=mean(y1(:)); y1=y1-1*m1; 
nscales=round(abs(nscales));
c1=cwt(y1,1:nscales,'cmor1-1'); 


subplot(4,2,4); imagesc(xmev2,[scale_min scale_max],real(c1)); axis xy; axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylabel('Scale (keV)');
xlabel('Excitation energy (MeV)');
title('CWT');



% ============== MAKING PROJECTIONS FOR IVGDR 12.000 - 24.000 MeV ==================

nscales=600;

% Note that the Wavelet scale is changed here to the Fourier scale!
binsize=10;              % Binsize is 20 keV
scalenorm(1:nscales)=0.; % Rescale as necessary
fourier_factor=1.0;      % Divide Complex Morlet   scale by 1.0 to give equivalent Fourier scale
%fourier_factor=0.3;     % Divide Complex Gaussian scale by 0.3 to give equivalent Fourier scale
for i=1:nscales
    scalenorm(i)=i/fourier_factor * binsize;
end


projy1cmx(1:nscales)=0.; % Retief 48Ca(p,p') cross-section (mb/sr MeV) 

exbin_min=1;    % E_x(min) = 12.0 MeV 
exbin_max=1400; % E_x(max) = 24.0 MeV

for i=1:nscales;
    for j=exbin_min:exbin_max;
        projy1cmx(i)=projy1cmx(i)+abs(c1(i,j))*abs(c1(i,j));
%       projy1cmx(i)=projy1cmx(i)+abs(c1x(i,j))*abs(c1x(i,j));        
    end
%projy1cm2Ex(i)=projy1cmx(i)/scalenorm(i); % Power spectrum squared/scale
%projy1cmEx(i)=sqrt(projy1cmx(i))/scalenorm(i); % Power spectrum/scale
%projy1cmx(i)=sqrt(projy1cmx(i)); % Standard power spectrum
projy1cm2Ex(i)=projy1cmx(i)*projy1cmx(i)/scalenorm(i); % Power spectrum squared/scale
projy1cmEx(i)=projy1cmx(i)/scalenorm(i); % Power spectrum/scale
projy1cmx(i)=projy1cmx(i); % Standard power spectrum
projy1cmsqEx(i)=sqrt(projy1cmx(i)/1e3)/scalenorm(i); % Square root(Power spectrum)/scale
end

projy1cmx_max=max(projy1cmx);
subplot(4,2,7); semilogx(scalenorm,projy1cmx/projy1cmx_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power (a.u.)')
title('{}^{58}Ni ISGMR 10.0 < E_x < 24 MeV');

projy1cmEx_max=max(projy1cmEx);
subplot(4,2,5); semilogx(scalenorm,projy1cmEx/projy1cmEx_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power / scale (a.u.)')
title('{}^{58}Ni ISGMR 10.0 < E_x < 24 MeV');

projy1cm2Ex_max=max(projy1cm2Ex);
subplot(4,2,3); semilogx(scalenorm,projy1cm2Ex/projy1cm2Ex_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power^2 / scale (a.u.)')
title('{}^{58}Ni ISGMR 10.0 < E_x < 24 MeV');

projy1cm2Ex_max=max(projy1cm2Ex);
%subplot(4,2,3); semilogx(scalenorm,projy1cm2Ex/projy1cm2Ex_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
%subplot(4,2,3); semilogx(scalenorm,projy1cm2Ex/1e4,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 5]);
subplot(4,2,1); semilogx(scalenorm,sqrt(projy1cmx/1e3)*1e3,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 3.8e3]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
%ylabel('Power^2 / scale')
ylim([0 25000]);
ylabel('Power^{1/2}')
title('{}^{58}Ni ISGMR 10.0 < E_x < 24 MeV');
hold on;


%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++