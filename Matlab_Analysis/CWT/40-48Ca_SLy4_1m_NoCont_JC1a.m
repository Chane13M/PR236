% function s=sembwave2(t,y1,y2,nscales)
% *******************************************************
% *** Wavelet semblance analysis
% *** Requires Matlab wavelet toolbox
% *** Type sembwave2; for demo with synthetic data
% *** GRJ Cooper 2005
% *** cooperg@geosciences.wits.ac.za, grcooper@iafrica.com
% *** www.wits.ac.za/science/geophysics/gc.htm
% *******************************************************
% *** Inputs;
% *** t         Time axis 
% *** y1,y2     Datasets to be compared
% *** nscales   No. of scales to use - not more than length(t)...
% *** Output;
% *** s        Semblance
% ******************************************************
%
%if nargin==0                        % demo analysis
% t=1:512;
% y1=sin(t*0.05)+sin(t*0.15);
% y2(1:170)=-sin(t(1:170)*0.05)+sin(t(1:170)*0.15);
% y2(171:340)=sin(t(171:340)*0.05)+cos(t(171:340)*0.15);
% y2(341:512)=cos(t(341:512)*0.05)-sin(t(341:512)*0.15);
% nscales=146;
%end;
%
%
%--------------------------------------------------------------------------

% Load Panagiota Ca40 Panagiota 40Ca SLy4 NoCont B(E1)

fname='Ca40_SLy4_1m_NoCont_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
Ca40_P4NC_12_24_10keV(1:1201)=cnts_src(1:1201); % Panagiota 40Ca SLy4 NoCont B(E1)


figure (10);
subplot(4,2,2); plot(ex_12_24_10keV,Ca40_P4NC_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 35]);
ylabel('B(E1) (e^2fm^2 / MeV)');
%xlabel('Excitation energy (MeV)');
title('Panagiota 40Ca SLy4 NoCont B(E1)');



%==========================================================================
y1=Ca40_P4NC_12_24_10keV; % Panagiota 40Ca SLy4 NoCont B(E1)
%==========================================================================

nscales=400;

binsize=10; % 10 keV bin size
scale_min=1*binsize;
scale_max=nscales*binsize;

gdr_min=1; % GDR Ex = 12.0 to 24.0 MeV
gdr_max=1201;

xmev2=(1199+gdr_min):(1199+gdr_max);  % GDR cut from gdr_min to gdr_max
xmev2=xmev2*binsize/1000;


y1(isnan(y1))=0;
m1=mean(y1(:)); y1=y1-3*m1; 
nscales=round(abs(nscales));
c1=cwt(y1,1:nscales,'cmor1-1'); 


subplot(4,2,4); imagesc(xmev2,[scale_min scale_max],real(c1)); axis xy; axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylabel('Scale (keV)');
%xlabel('Excitation energy (MeV)');
title('CWT');


%--------------------------------------------------------------------------

% Load Panagiota Ca40 Panagiota 40Ca SLy4 NoCont B(E1)

fname='Ca40_SLy4_1m_NoCont_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
Ca40_P4NC_12_24_10keV(1:1201)=cnts_src(1:1201); % Panagiota 40Ca SLy4 NoCont B(E1)

% multiply B(E1) by E_x for comparison with photoabsorption spectrum
for x=1:1201;
    Ca40_P4NCEx_12_24_10keV(x)=Ca40_P4NC_12_24_10keV(x)*ex_12_24_10keV(x);
end


subplot(4,2,6); plot(ex_12_24_10keV,Ca40_P4NCEx_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 650]);
ylabel('B(E1)*E_x (e^2fm^2)');
%xlabel('Excitation energy (MeV)');
title('Panagiota 40Ca SLy4 NoCont B(E1)*E_x');



%==========================================================================
y1x=Ca40_P4NCEx_12_24_10keV; % Panagiota 40Ca SLy4 NoCont B(E1)
%==========================================================================

nscales=400;

binsize=10; % 10 keV bin size
scale_min=1*binsize;
scale_max=nscales*binsize;

gdr_min=1; % GDR Ex = 12.0 to 24.0 MeV
gdr_max=1201;

xmev2=(1199+gdr_min):(1199+gdr_max);  % GDR cut from gdr_min to gdr_max
xmev2=xmev2*binsize/1000;


y1x(isnan(y1x))=0;
m1x=mean(y1x(:)); y1x=y1x-3*m1x; 
nscales=round(abs(nscales));
c1x=cwt(y1x,1:nscales,'cmor1-1'); 


subplot(4,2,8); imagesc(xmev2,[scale_min scale_max],real(c1x)); axis xy; axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylabel('Scale (keV)');
xlabel('Excitation energy (MeV)');
title('CWT');


% ============== MAKING PROJECTIONS FOR IVGDR 12.000 - 24.000 MeV ==================

nscales=400;

% Note that the Wavelet scale is changed here to the Fourier scale!
binsize=10;              % Binsize is 20 keV
scalenorm(1:nscales)=0.; % Rescale as necessary
fourier_factor=1.0;      % Divide Complex Morlet   scale by 1.0 to give equivalent Fourier scale
%fourier_factor=0.3;     % Divide Complex Gaussian scale by 0.3 to give equivalent Fourier scale
for i=1:nscales
    scalenorm(i)=i/fourier_factor * binsize;
end


projy1cmx(1:nscales)=0.; % Panagiota 40Ca SLy4 NoCont B(E1)        %       %  

exbin_min=1;    % E_x(min) = 12.0 MeV 
exbin_max=1201; % E_x(max) = 24.0 MeV

for i=1:nscales;
    for j=exbin_min:exbin_max;
        projy1cmx(i)=projy1cmx(i)+abs(c1x(i,j))*abs(c1x(i,j));                                    
    end
projy1cm2Ex(i)=projy1cmx(i)/scalenorm(i); % Power spectrum squared/scale
projy1cmEx(i)=sqrt(projy1cmx(i))/scalenorm(i); % Power spectrum/scale
projy1cmx(i)=sqrt(projy1cmx(i)); % Standard power spectrum 
end

projy1cmx_max=max(projy1cmx);
subplot(4,2,7); semilogx(scalenorm,projy1cmx/projy1cmx_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power (a.u.)')
title('40Ca IVGDR 12.0 < E_x < 24 MeV');


projy1cmEx_max=max(projy1cmEx);
subplot(4,2,5); semilogx(scalenorm,projy1cmEx/projy1cmEx_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power / scale (a.u.)')
title('40Ca IVGDR 12.0 < E_x < 24 MeV');

projy1cm2Ex_max=max(projy1cm2Ex);
subplot(4,2,3); semilogx(scalenorm,projy1cm2Ex/projy1cm2Ex_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power^2 / scale (a.u.)')
title('40Ca IVGDR 12.0 < E_x < 24 MeV');


%=========================================================================
% 48Ca

fname='Ca48_SLy4_1m_NoCont_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
Ca48_P4NC_12_24_10keV(1:1201)=cnts_src(1:1201); % Panagiota 48Ca SLy4 NoCont B(E1)


figure (20);
subplot(4,2,2); plot(ex_12_24_10keV,Ca48_P4NC_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 35]);
ylabel('B(E1) (e^2fm^2 / MeV)');
%xlabel('Excitation energy (MeV)');
title('Panagiota 48Ca SLy4 NoCont B(E1)');



%==========================================================================
y1=Ca48_P4NC_12_24_10keV; % Panagiota 48Ca SLy4 NoCont B(E1)
%==========================================================================

nscales=400;

binsize=10; % 10 keV bin size
scale_min=1*binsize;
scale_max=nscales*binsize;

gdr_min=1; % GDR Ex = 12.0 to 24.0 MeV
gdr_max=1201;

xmev2=(1199+gdr_min):(1199+gdr_max);  % GDR cut from gdr_min to gdr_max
xmev2=xmev2*binsize/1000;


y1(isnan(y1))=0;
m1=mean(y1(:)); y1=y1-3*m1; 
nscales=round(abs(nscales));
c1=cwt(y1,1:nscales,'cmor1-1'); 


subplot(4,2,4); imagesc(xmev2,[scale_min scale_max],real(c1)); axis xy; axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylabel('Scale (keV)');
%xlabel('Excitation energy (MeV)');
title('CWT');


%--------------------------------------------------------------------------

% Load Panagiota Ca48 Panagiota 48Ca SLy4 NoCont B(E1)

fname='Ca48_SLy4_1m_NoCont_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
Ca48_P4NC_12_24_10keV(1:1201)=cnts_src(1:1201); % Panagiota 48Ca SLy4 NoCont B(E1)

% multiply B(E1) by E_x for comparison with photoabsorption spectrum
for x=1:1201;
    Ca48_P4NCEx_12_24_10keV(x)=Ca48_P4NC_12_24_10keV(x)*ex_12_24_10keV(x);
end


subplot(4,2,6); plot(ex_12_24_10keV,Ca48_P4NCEx_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 650]);
ylabel('B(E1)*E_x (e^2fm^2)');
%xlabel('Excitation energy (MeV)');
title('Panagiota 48Ca SLy4 NoCont B(E1)*E_x');



%==========================================================================
y1x=Ca48_P4NCEx_12_24_10keV; % Panagiota 48Ca SLy4 NoCont B(E1)
%==========================================================================

nscales=400;

binsize=10; % 10 keV bin size
scale_min=1*binsize;
scale_max=nscales*binsize;

gdr_min=1; % GDR Ex = 12.0 to 24.0 MeV
gdr_max=1201;

xmev2=(1199+gdr_min):(1199+gdr_max);  % GDR cut from gdr_min to gdr_max
xmev2=xmev2*binsize/1000;


y1x(isnan(y1x))=0;
m1x=mean(y1x(:)); y1x=y1x-3*m1x; 
nscales=round(abs(nscales));
c1x=cwt(y1x,1:nscales,'cmor1-1'); 


subplot(4,2,8); imagesc(xmev2,[scale_min scale_max],real(c1x)); axis xy; axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylabel('Scale (keV)');
xlabel('Excitation energy (MeV)');
title('CWT');


% ============== MAKING PROJECTIONS FOR IVGDR 12.000 - 24.000 MeV ==================

nscales=400;

% Note that the Wavelet scale is changed here to the Fourier scale!
binsize=10;              % Binsize is 20 keV
scalenorm(1:nscales)=0.; % Rescale as necessary
fourier_factor=1.0;      % Divide Complex Morlet   scale by 1.0 to give equivalent Fourier scale
%fourier_factor=0.3;     % Divide Complex Gaussian scale by 0.3 to give equivalent Fourier scale
for i=1:nscales
    scalenorm(i)=i/fourier_factor * binsize;
end


projy1cmx(1:nscales)=0.; % Panagiota 48Ca SLy4 NoCont B(E1)        %       %  

exbin_min=1;    % E_x(min) = 12.0 MeV 
exbin_max=1201; % E_x(max) = 24.0 MeV

for i=1:nscales;
    for j=exbin_min:exbin_max;
        projy1cmx(i)=projy1cmx(i)+abs(c1x(i,j))*abs(c1x(i,j));                                    
    end
projy1cm2Ex(i)=projy1cmx(i)/scalenorm(i); % Power spectrum squared/scale
projy1cmEx(i)=sqrt(projy1cmx(i))/scalenorm(i); % Power spectrum/scale
projy1cmx(i)=sqrt(projy1cmx(i)); % Standard power spectrum 
end

projy1cmx_max=max(projy1cmx);
subplot(4,2,7); semilogx(scalenorm,projy1cmx/projy1cmx_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power (a.u.)')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');

projy1cmEx_max=max(projy1cmEx);
subplot(4,2,5); semilogx(scalenorm,projy1cmEx/projy1cmEx_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power / scale (a.u.)')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');

projy1cm2Ex_max=max(projy1cm2Ex);
subplot(4,2,3); semilogx(scalenorm,projy1cm2Ex/projy1cm2Ex_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power^2 / scale (a.u.)')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');


%==========================================================================
% CRPA results Panagiota


% Load Panagiota 40Ca CRPA B(E1) from 2015

fname='40Ca_SLy4_CRPA_BE1_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
Ca40_CRPA_12_24_10keV(1:1201)=cnts_src(1:1201); % Panagiota 40Ca CRPA B(E1)


figure (30);
subplot(4,2,2); plot(ex_12_24_10keV,Ca40_CRPA_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 5.5]);
ylabel('B(E1) (e^2fm^2 / MeV)');
%xlabel('Excitation energy (MeV)');
title('Panagiota 40Ca CRPA B(E1)');



%==========================================================================
y1=Ca40_CRPA_12_24_10keV; % Panagiota 40Ca CRPA B(E1)
%==========================================================================

nscales=400;

binsize=10; % 10 keV bin size
scale_min=1*binsize;
scale_max=nscales*binsize;

gdr_min=1; % GDR Ex = 12.0 to 24.0 MeV
gdr_max=1201;

xmev2=(1199+gdr_min):(1199+gdr_max);  % GDR cut from gdr_min to gdr_max
xmev2=xmev2*binsize/1000;


y1(isnan(y1))=0;
m1=mean(y1(:)); y1=y1-3*m1; 
nscales=round(abs(nscales));
c1=cwt(y1,1:nscales,'cmor1-1'); 


subplot(4,2,4); imagesc(xmev2,[scale_min scale_max],real(c1)); axis xy; axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylabel('Scale (keV)');
%xlabel('Excitation energy (MeV)');
title('CWT');


%--------------------------------------------------------------------------

% Load Panagiota Ca40 Panagiota 40Ca CRPA B(E1)

fname='40Ca_SLy4_CRPA_BE1_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
Ca40_CRPA_12_24_10keV(1:1201)=cnts_src(1:1201); % Panagiota 40Ca CRPA B(E1)

% multiply B(E1) by E_x for comparison with photoabsorption spectrum
for x=1:1201;
    Ca40_CRPAEx_12_24_10keV(x)=Ca40_CRPA_12_24_10keV(x)*ex_12_24_10keV(x);
end


subplot(4,2,6); plot(ex_12_24_10keV,Ca40_CRPAEx_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 90]);
ylabel('B(E1)*E_x (e^2fm^2)');
%xlabel('Excitation energy (MeV)');
title('Panagiota 40Ca CRPA B(E1)*E_x');



%==========================================================================
y1x=Ca40_CRPAEx_12_24_10keV; % Panagiota 40Ca CRPA B(E1)*E_x
%==========================================================================

nscales=400;

binsize=10; % 10 keV bin size
scale_min=1*binsize;
scale_max=nscales*binsize;

gdr_min=1; % GDR Ex = 12.0 to 24.0 MeV
gdr_max=1201;

xmev2=(1199+gdr_min):(1199+gdr_max);  % GDR cut from gdr_min to gdr_max
xmev2=xmev2*binsize/1000;


y1x(isnan(y1x))=0;
m1x=mean(y1x(:)); y1x=y1x-3*m1x; 
nscales=round(abs(nscales));
c1x=cwt(y1x,1:nscales,'cmor1-1'); 


subplot(4,2,8); imagesc(xmev2,[scale_min scale_max],real(c1x)); axis xy; axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylabel('Scale (keV)');
xlabel('Excitation energy (MeV)');
title('CWT');


% ============== MAKING PROJECTIONS FOR IVGDR 12.000 - 24.000 MeV ==================

nscales=400;

% Note that the Wavelet scale is changed here to the Fourier scale!
binsize=10;              % Binsize is 20 keV
scalenorm(1:nscales)=0.; % Rescale as necessary
fourier_factor=1.0;      % Divide Complex Morlet   scale by 1.0 to give equivalent Fourier scale
%fourier_factor=0.3;     % Divide Complex Gaussian scale by 0.3 to give equivalent Fourier scale
for i=1:nscales
    scalenorm(i)=i/fourier_factor * binsize;
end


projy1cmx(1:nscales)=0.; % Panagiota 40Ca SLy4 CRPA B(E1)*E_x  

exbin_min=1;    % E_x(min) = 12.0 MeV 
exbin_max=1201; % E_x(max) = 24.0 MeV

for i=1:nscales;
    for j=exbin_min:exbin_max;
        projy1cmx(i)=projy1cmx(i)+abs(c1x(i,j))*abs(c1x(i,j));                                    
    end
projy1cm2Ex(i)=projy1cmx(i)/scalenorm(i); % Power spectrum squared/scale
projy1cmEx(i)=sqrt(projy1cmx(i))/scalenorm(i); % Power spectrum/scale
projy1cmx(i)=sqrt(projy1cmx(i)); % Standard power spectrum 
end

projy1cmx_max=max(projy1cmx);
subplot(4,2,7); semilogx(scalenorm,projy1cmx/projy1cmx_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power (a.u.)')
title('40Ca IVGDR 12.0 < E_x < 24 MeV');

projy1cmEx_max=max(projy1cmEx);
set(gca,'TickLength',[0.03 0.03]);
subplot(4,2,5); semilogx(scalenorm,projy1cmEx/projy1cmEx_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power / scale (a.u.)')
title('40Ca IVGDR 12.0 < E_x < 24 MeV');

projy1cm2Ex_max=max(projy1cm2Ex);
subplot(4,2,3); semilogx(scalenorm,projy1cm2Ex/projy1cm2Ex_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power^2 / scale (a.u.)')
title('40Ca IVGDR 12.0 < E_x < 24 MeV');



%==========================================================================
% CRPA results Panagiota


% Load Panagiota 48Ca CRPA B(E1) from 2015

fname='48Ca_SLy4_CRPA_BE1_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
Ca48_CRPA_12_24_10keV(1:1201)=cnts_src(1:1201); % Panagiota 48Ca CRPA B(E1)


figure (40);
subplot(4,2,2); plot(ex_12_24_10keV,Ca48_CRPA_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 5.5]);
ylabel('B(E1) (e^2fm^2 / MeV)');
%xlabel('Excitation energy (MeV)');
title('Panagiota 48Ca CRPA B(E1)');



%==========================================================================
y1=Ca48_CRPA_12_24_10keV; % Panagiota 48Ca CRPA B(E1)
%==========================================================================

nscales=400;

binsize=10; % 10 keV bin size
scale_min=1*binsize;
scale_max=nscales*binsize;

gdr_min=1; % GDR Ex = 12.0 to 24.0 MeV
gdr_max=1201;

xmev2=(1199+gdr_min):(1199+gdr_max);  % GDR cut from gdr_min to gdr_max
xmev2=xmev2*binsize/1000;


y1(isnan(y1))=0;
m1=mean(y1(:)); y1=y1-3*m1; 
nscales=round(abs(nscales));
c1=cwt(y1,1:nscales,'cmor1-1'); 


subplot(4,2,4); imagesc(xmev2,[scale_min scale_max],real(c1)); axis xy; axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylabel('Scale (keV)');
%xlabel('Excitation energy (MeV)');
title('CWT');


%--------------------------------------------------------------------------

% Load Panagiota Ca48 Panagiota 48Ca CRPA B(E1)

fname='48Ca_SLy4_CRPA_BE1_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
Ca48_CRPA_12_24_10keV(1:1201)=cnts_src(1:1201); % Panagiota 48Ca CRPA B(E1)

% multiply B(E1) by E_x for comparison with photoabsorption spectrum
for x=1:1201;
    Ca48_CRPAEx_12_24_10keV(x)=Ca48_CRPA_12_24_10keV(x)*ex_12_24_10keV(x);
end


subplot(4,2,6); plot(ex_12_24_10keV,Ca48_CRPAEx_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 90]);
ylabel('B(E1)*E_x (e^2fm^2)');
%xlabel('Excitation energy (MeV)');
title('Panagiota 48Ca CRPA B(E1)*E_x');



%==========================================================================
y1x=Ca48_CRPAEx_12_24_10keV; % Panagiota 48Ca CRPA B(E1)*E_x
%==========================================================================

nscales=400;

binsize=10; % 10 keV bin size
scale_min=1*binsize;
scale_max=nscales*binsize;

gdr_min=1; % GDR Ex = 12.0 to 24.0 MeV
gdr_max=1201;

xmev2=(1199+gdr_min):(1199+gdr_max);  % GDR cut from gdr_min to gdr_max
xmev2=xmev2*binsize/1000;


y1x(isnan(y1x))=0;
m1x=mean(y1x(:)); y1x=y1x-3*m1x; 
nscales=round(abs(nscales));
c1x=cwt(y1x,1:nscales,'cmor1-1'); 


subplot(4,2,8); imagesc(xmev2,[scale_min scale_max],real(c1x)); axis xy; axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylabel('Scale (keV)');
xlabel('Excitation energy (MeV)');
title('CWT');


% ============== MAKING PROJECTIONS FOR IVGDR 12.000 - 24.000 MeV ==================

nscales=400;

% Note that the Wavelet scale is changed here to the Fourier scale!
binsize=10;              % Binsize is 20 keV
scalenorm(1:nscales)=0.; % Rescale as necessary
fourier_factor=1.0;      % Divide Complex Morlet   scale by 1.0 to give equivalent Fourier scale
%fourier_factor=0.3;     % Divide Complex Gaussian scale by 0.3 to give equivalent Fourier scale
for i=1:nscales
    scalenorm(i)=i/fourier_factor * binsize;
end


projy1cmx(1:nscales)=0.; % Panagiota 48Ca SLy4 CRPA B(E1)*E_x  

exbin_min=1;    % E_x(min) = 12.0 MeV 
exbin_max=1201; % E_x(max) = 24.0 MeV

for i=1:nscales;
    for j=exbin_min:exbin_max;
        projy1cmx(i)=projy1cmx(i)+abs(c1x(i,j))*abs(c1x(i,j));                                    
    end
projy1cm2Ex(i)=projy1cmx(i)/scalenorm(i); % Power spectrum squared/scale
projy1cmEx(i)=sqrt(projy1cmx(i))/scalenorm(i); % Power spectrum/scale
projy1cmx(i)=sqrt(projy1cmx(i)); % Standard power spectrum 
end

projy1cmx_max=max(projy1cmx);
subplot(4,2,7); semilogx(scalenorm,projy1cmx/projy1cmx_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power (a.u.)')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');

projy1cmEx_max=max(projy1cmEx);
subplot(4,2,5); semilogx(scalenorm,projy1cmEx/projy1cmEx_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power / scale (a.u.)')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');

projy1cm2Ex_max=max(projy1cm2Ex);
subplot(4,2,3); semilogx(scalenorm,projy1cm2Ex/projy1cm2Ex_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power^2 / scale (a.u.)')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');

% <===







set(gca,'YTick',0:1000:3000,...
    'YTickLabel',0:1000:3000,...
    'YMinorTick','on',...
    'FontWeight','normal',...
    'FontSize', 8,...
    'XTickLabel',10:2:20,...
    'XTick',10:2:20,...
    'XMinorTick','on',...
    'TickLength',[0.02 0.05]);







%=========================================================================
% 48Ca CRPA Panagiota

fname='Ca48_SLy4_1m_NoCont_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
Ca48_P4NC_12_24_10keV(1:1201)=cnts_src(1:1201); % Panagiota 48Ca SLy4 NoCont B(E1)


figure (40);
subplot(4,2,2); plot(ex_12_24_10keV,Ca48_P4NC_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
ylim([0 35]);
ylabel('B(E1) (arb. units)');
xlabel('Excitation energy (MeV)');
title('Panagiota 48Ca SLy4 NoCont B(E1)');



%==========================================================================
y1=Ca48_P4NC_12_24_10keV; % Panagiota 48Ca SLy4 NoCont B(E1)
%==========================================================================

nscales=400;

binsize=10; % 10 keV bin size
scale_min=1*binsize;
scale_max=nscales*binsize;

gdr_min=1; % GDR Ex = 12.0 to 24.0 MeV
gdr_max=1201;

xmev2=(1199+gdr_min):(1199+gdr_max);  % GDR cut from gdr_min to gdr_max
xmev2=xmev2*binsize/1000;


y1(isnan(y1))=0;
m1=mean(y1(:)); y1=y1-3*m1; 
nscales=round(abs(nscales));
c1=cwt(y1,1:nscales,'cmor1-1'); 


subplot(4,2,4); imagesc(xmev2,[scale_min scale_max],real(c1)); axis xy; axis tight;
ylabel('Scale (keV)');
xlabel('Excitation energy (MeV)');
title('CWT');


% ============== MAKING PROJECTIONS FOR IVGDR 12.000 - 24.000 MeV ==================

nscales=400;

% Note that the Wavelet scale is changed here to the Fourier scale!
binsize=10;              % Binsize is 20 keV
scalenorm(1:nscales)=0.; % Rescale as necessary
fourier_factor=1.0;      % Divide Complex Morlet   scale by 1.0 to give equivalent Fourier scale
%fourier_factor=0.3;     % Divide Complex Gaussian scale by 0.3 to give equivalent Fourier scale
for i=1:nscales
    scalenorm(i)=i/fourier_factor * binsize;
end


projy1cm(1:nscales)=0.; % Panagiota 48Ca SLy4 NoCont B(E1)        %  

exbin_min=1;    % E_x(min) = 12.0 MeV 
exbin_max=1201; % E_x(max) = 24.0 MeV

for i=1:nscales;
    for j=exbin_min:exbin_max;
        projy1cm(i)=projy1cm(i)+abs(c1(i,j))*abs(c1(i,j));                                    
    end
projy1cm2E(i)=projy1cm(i)/scalenorm(i); % Power spectrum squared/scale
%projy1cmE(i)=sqrt(projy1cm(i))/scalenorm(i); % Power spectrum/scale
projy1cm(i)=sqrt(projy1cm(i)); % Standard power spectrum 
end

projy1cm_max=max(projy1cm);
subplot(4,2,3); semilogx(scalenorm,projy1cm/projy1cm_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power (a.u.)')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');

projy1cm2E_max=max(projy1cm2E);
subplot(4,2,1); semilogx(scalenorm,projy1cm2E/projy1cm2E_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power^2/scale (a.u.)')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');



%--------------------------------------------------------------------------

% Load Panagiota Ca48 Panagiota 48Ca SLy4 NoCont B(E1)

fname='Ca48_SLy4_1m_NoCont_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
Ca48_P4NC_12_24_10keV(1:1201)=cnts_src(1:1201); % Panagiota 48Ca SLy4 NoCont B(E1)

% multiply B(E1) by E_x for comparison with photoabsorption spectrum
for x=1:1201;
    Ca48_P4NCEx_12_24_10keV(x)=Ca48_P4NC_12_24_10keV(x)*ex_12_24_10keV(x);
end


subplot(4,2,6); plot(ex_12_24_10keV,Ca48_P4NCEx_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
ylim([0 650]);
ylabel('B(E1)*E_x (arb. units)');
xlabel('Excitation energy (MeV)');
title('Panagiota 48Ca SLy4 NoCont B(E1)*E_x');



%==========================================================================
y1x=Ca48_P4NCEx_12_24_10keV; % Panagiota 48Ca SLy4 NoCont B(E1)
%==========================================================================

nscales=400;

binsize=10; % 10 keV bin size
scale_min=1*binsize;
scale_max=nscales*binsize;

gdr_min=1; % GDR Ex = 12.0 to 24.0 MeV
gdr_max=1201;

xmev2=(1199+gdr_min):(1199+gdr_max);  % GDR cut from gdr_min to gdr_max
xmev2=xmev2*binsize/1000;


y1x(isnan(y1x))=0;
m1x=mean(y1x(:)); y1x=y1x-3*m1x; 
nscales=round(abs(nscales));
c1x=cwt(y1x,1:nscales,'cmor1-1'); 


subplot(4,2,8); imagesc(xmev2,[scale_min scale_max],real(c1x)); axis xy; axis tight;
ylabel('Scale (keV)');
xlabel('Excitation energy (MeV)');
title('CWT');


% ============== MAKING PROJECTIONS FOR IVGDR 12.000 - 24.000 MeV ==================

nscales=400;

% Note that the Wavelet scale is changed here to the Fourier scale!
binsize=10;              % Binsize is 20 keV
scalenorm(1:nscales)=0.; % Rescale as necessary
fourier_factor=1.0;      % Divide Complex Morlet   scale by 1.0 to give equivalent Fourier scale
%fourier_factor=0.3;     % Divide Complex Gaussian scale by 0.3 to give equivalent Fourier scale
for i=1:nscales
    scalenorm(i)=i/fourier_factor * binsize;
end


projy1cmx(1:nscales)=0.; % Panagiota 48Ca SLy4 NoCont B(E1)        %       %  

exbin_min=1;    % E_x(min) = 12.0 MeV 
exbin_max=1201; % E_x(max) = 24.0 MeV

for i=1:nscales;
    for j=exbin_min:exbin_max;
        projy1cmx(i)=projy1cmx(i)+abs(c1x(i,j))*abs(c1x(i,j));                                    
    end
projy1cm2Ex(i)=projy1cmx(i)/scalenorm(i); % Power spectrum squared/scale
%projy1cmEx(i)=sqrt(projy1cmx(i))/scalenorm(i); % Power spectrum/scale
projy1cmx(i)=sqrt(projy1cmx(i)); % Standard power spectrum 
end

projy1cmx_max=max(projy1cmx);
subplot(4,2,7); semilogx(scalenorm,projy1cmx/projy1cmx_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power (a.u.)')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');

projy1cm2Ex_max=max(projy1cm2Ex);
subplot(4,2,5); semilogx(scalenorm,projy1cm2Ex/projy1cm2Ex_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power^2/scale (a.u.)')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');






%==========================================================================
% RPA results??????????????????????


% Load Panagiota? 40Ca RPA B(E1)- R(Q)RPA from 2015

fname='40ca-rpa-d20_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
Ca40_RPA_12_24_10keV(1:1201)=cnts_src(1:1201); % Panagiota 40Ca RPA B(E1)


figure (30);
subplot(4,2,2); plot(ex_12_24_10keV,Ca40_RPA_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
ylim([0 60]);
ylabel('B(E1) (arb. units)');
xlabel('Excitation energy (MeV)');
title('Panagiota 40Ca RPA B(E1)');



%==========================================================================
y1=Ca40_RPA_12_24_10keV; % Panagiota 40Ca RPA B(E1)
%==========================================================================

nscales=400;

binsize=10; % 10 keV bin size
scale_min=1*binsize;
scale_max=nscales*binsize;

gdr_min=1; % GDR Ex = 12.0 to 24.0 MeV
gdr_max=1201;

xmev2=(1199+gdr_min):(1199+gdr_max);  % GDR cut from gdr_min to gdr_max
xmev2=xmev2*binsize/1000;


y1(isnan(y1))=0;
m1=mean(y1(:)); y1=y1-3*m1; 
nscales=round(abs(nscales));
c1=cwt(y1,1:nscales,'cmor1-1'); 


subplot(4,2,4); imagesc(xmev2,[scale_min scale_max],real(c1)); axis xy; axis tight;
ylabel('Scale (keV)');
xlabel('Excitation energy (MeV)');
title('CWT');


% ============== MAKING PROJECTIONS FOR IVGDR 12.000 - 24.000 MeV ==================

nscales=400;

% Note that the Wavelet scale is changed here to the Fourier scale!
binsize=10;              % Binsize is 20 keV
scalenorm(1:nscales)=0.; % Rescale as necessary
fourier_factor=1.0;      % Divide Complex Morlet   scale by 1.0 to give equivalent Fourier scale
%fourier_factor=0.3;     % Divide Complex Gaussian scale by 0.3 to give equivalent Fourier scale
for i=1:nscales
    scalenorm(i)=i/fourier_factor * binsize;
end


projy1cm(1:nscales)=0.; % Panagiota 40Ca SLy4 NoCont B(E1)        %  

exbin_min=1;    % E_x(min) = 12.0 MeV 
exbin_max=1201; % E_x(max) = 24.0 MeV

for i=1:nscales;
    for j=exbin_min:exbin_max;
        projy1cm(i)=projy1cm(i)+abs(c1(i,j))*abs(c1(i,j));                                    
    end
projy1cm2E(i)=projy1cm(i)/scalenorm(i); % Power spectrum squared/scale
%projy1cmE(i)=sqrt(projy1cm(i))/scalenorm(i); % Power spectrum/scale
projy1cm(i)=sqrt(projy1cm(i)); % Standard power spectrum 
end

projy1cm_max=max(projy1cm);
subplot(4,2,3); semilogx(scalenorm,projy1cm/projy1cm_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power (a.u.)')
title('40Ca IVGDR 12.0 < E_x < 24 MeV');

projy1cm2E_max=max(projy1cm2E);
subplot(4,2,1); semilogx(scalenorm,projy1cm2E/projy1cm2E_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power^2/scale (a.u.)')
title('40Ca IVGDR 12.0 < E_x < 24 MeV');



%--------------------------------------------------------------------------

% Load Panagiota Ca40 Panagiota 40Ca RPA B(E1)

fname='40ca-rpa-d20_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
Ca40_RPA_12_24_10keV(1:1201)=cnts_src(1:1201); % Panagiota 40Ca RPA B(E1)

% multiply B(E1) by E_x for comparison with photoabsorption spectrum
for x=1:1201;
    Ca40_RPAEx_12_24_10keV(x)=Ca40_RPA_12_24_10keV(x)*ex_12_24_10keV(x);
end


subplot(4,2,6); plot(ex_12_24_10keV,Ca40_RPAEx_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
ylim([0 950]);
ylabel('B(E1)*E_x (arb. units)');
xlabel('Excitation energy (MeV)');
title('Panagiota 40Ca RPA B(E1)*E_x');



%==========================================================================
y1x=Ca40_RPAEx_12_24_10keV; % Panagiota 40Ca RPA B(E1)*E_x
%==========================================================================

nscales=400;

binsize=10; % 10 keV bin size
scale_min=1*binsize;
scale_max=nscales*binsize;

gdr_min=1; % GDR Ex = 12.0 to 24.0 MeV
gdr_max=1201;

xmev2=(1199+gdr_min):(1199+gdr_max);  % GDR cut from gdr_min to gdr_max
xmev2=xmev2*binsize/1000;


y1x(isnan(y1x))=0;
m1x=mean(y1x(:)); y1x=y1x-3*m1x; 
nscales=round(abs(nscales));
c1x=cwt(y1x,1:nscales,'cmor1-1'); 


subplot(4,2,8); imagesc(xmev2,[scale_min scale_max],real(c1x)); axis xy; axis tight;
ylabel('Scale (keV)');
xlabel('Excitation energy (MeV)');
title('CWT');


% ============== MAKING PROJECTIONS FOR IVGDR 12.000 - 24.000 MeV ==================

nscales=400;

% Note that the Wavelet scale is changed here to the Fourier scale!
binsize=10;              % Binsize is 20 keV
scalenorm(1:nscales)=0.; % Rescale as necessary
fourier_factor=1.0;      % Divide Complex Morlet   scale by 1.0 to give equivalent Fourier scale
%fourier_factor=0.3;     % Divide Complex Gaussian scale by 0.3 to give equivalent Fourier scale
for i=1:nscales
    scalenorm(i)=i/fourier_factor * binsize;
end


projy1cmx(1:nscales)=0.; % Panagiota 40Ca SLy4 NoCont B(E1)        %       %  

exbin_min=1;    % E_x(min) = 12.0 MeV 
exbin_max=1201; % E_x(max) = 24.0 MeV

for i=1:nscales;
    for j=exbin_min:exbin_max;
        projy1cmx(i)=projy1cmx(i)+abs(c1x(i,j))*abs(c1x(i,j));                                    
    end
projy1cm2Ex(i)=projy1cmx(i)/scalenorm(i); % Power spectrum squared/scale
%projy1cmEx(i)=sqrt(projy1cmx(i))/scalenorm(i); % Power spectrum/scale
projy1cmx(i)=sqrt(projy1cmx(i)); % Standard power spectrum 
end

projy1cmx_max=max(projy1cmx);
subplot(4,2,7); semilogx(scalenorm,projy1cmx/projy1cmx_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power (a.u.)')
title('40Ca IVGDR 12.0 < E_x < 24 MeV');

projy1cm2Ex_max=max(projy1cm2Ex);
subplot(4,2,5); semilogx(scalenorm,projy1cm2Ex/projy1cm2Ex_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power^2/scale (a.u.)')
title('40Ca IVGDR 12.0 < E_x < 24 MeV');


%=========================================================================
% 48Ca need to put in new data file

fname='Ca48_SLy4_1m_NoCont_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
Ca48_P4NC_12_24_10keV(1:1201)=cnts_src(1:1201); % Panagiota 48Ca SLy4 NoCont B(E1)


figure (20);
subplot(4,2,2); plot(ex_12_24_10keV,Ca48_P4NC_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
ylim([0 35]);
ylabel('B(E1) (arb. units)');
xlabel('Excitation energy (MeV)');
title('Panagiota 48Ca SLy4 NoCont B(E1)');



%==========================================================================
y1=Ca48_P4NC_12_24_10keV; % Panagiota 48Ca SLy4 NoCont B(E1)
%==========================================================================

nscales=400;

binsize=10; % 10 keV bin size
scale_min=1*binsize;
scale_max=nscales*binsize;

gdr_min=1; % GDR Ex = 12.0 to 24.0 MeV
gdr_max=1201;

xmev2=(1199+gdr_min):(1199+gdr_max);  % GDR cut from gdr_min to gdr_max
xmev2=xmev2*binsize/1000;


y1(isnan(y1))=0;
m1=mean(y1(:)); y1=y1-3*m1; 
nscales=round(abs(nscales));
c1=cwt(y1,1:nscales,'cmor1-1'); 


subplot(4,2,4); imagesc(xmev2,[scale_min scale_max],real(c1)); axis xy; axis tight;
ylabel('Scale (keV)');
xlabel('Excitation energy (MeV)');
title('CWT');


% ============== MAKING PROJECTIONS FOR IVGDR 12.000 - 24.000 MeV ==================

nscales=400;

% Note that the Wavelet scale is changed here to the Fourier scale!
binsize=10;              % Binsize is 20 keV
scalenorm(1:nscales)=0.; % Rescale as necessary
fourier_factor=1.0;      % Divide Complex Morlet   scale by 1.0 to give equivalent Fourier scale
%fourier_factor=0.3;     % Divide Complex Gaussian scale by 0.3 to give equivalent Fourier scale
for i=1:nscales
    scalenorm(i)=i/fourier_factor * binsize;
end


projy1cm(1:nscales)=0.; % Panagiota 48Ca SLy4 NoCont B(E1)        %  

exbin_min=1;    % E_x(min) = 12.0 MeV 
exbin_max=1201; % E_x(max) = 24.0 MeV

for i=1:nscales;
    for j=exbin_min:exbin_max;
        projy1cm(i)=projy1cm(i)+abs(c1(i,j))*abs(c1(i,j));                                    
    end
projy1cm2E(i)=projy1cm(i)/scalenorm(i); % Power spectrum squared/scale
%projy1cmE(i)=sqrt(projy1cm(i))/scalenorm(i); % Power spectrum/scale
projy1cm(i)=sqrt(projy1cm(i)); % Standard power spectrum 
end

projy1cm_max=max(projy1cm);
subplot(4,2,3); semilogx(scalenorm,projy1cm/projy1cm_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power (a.u.)')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');

projy1cm2E_max=max(projy1cm2E);
subplot(4,2,1); semilogx(scalenorm,projy1cm2E/projy1cm2E_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power^2/scale (a.u.)')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');



%--------------------------------------------------------------------------

% Load Panagiota Ca48 Panagiota 48Ca SLy4 NoCont B(E1)

fname='Ca48_SLy4_1m_NoCont_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
Ca48_P4NC_12_24_10keV(1:1201)=cnts_src(1:1201); % Panagiota 48Ca SLy4 NoCont B(E1)

% multiply B(E1) by E_x for comparison with photoabsorption spectrum
for x=1:1201;
    Ca48_P4NCEx_12_24_10keV(x)=Ca48_P4NC_12_24_10keV(x)*ex_12_24_10keV(x);
end


subplot(4,2,6); plot(ex_12_24_10keV,Ca48_P4NCEx_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
ylim([0 650]);
ylabel('B(E1)*E_x (arb. units)');
xlabel('Excitation energy (MeV)');
title('Panagiota 48Ca SLy4 NoCont B(E1)*E_x');



%==========================================================================
y1x=Ca48_P4NCEx_12_24_10keV; % Panagiota 48Ca SLy4 NoCont B(E1)
%==========================================================================

nscales=400;

binsize=10; % 10 keV bin size
scale_min=1*binsize;
scale_max=nscales*binsize;

gdr_min=1; % GDR Ex = 12.0 to 24.0 MeV
gdr_max=1201;

xmev2=(1199+gdr_min):(1199+gdr_max);  % GDR cut from gdr_min to gdr_max
xmev2=xmev2*binsize/1000;


y1x(isnan(y1x))=0;
m1x=mean(y1x(:)); y1x=y1x-3*m1x; 
nscales=round(abs(nscales));
c1x=cwt(y1x,1:nscales,'cmor1-1'); 


subplot(4,2,8); imagesc(xmev2,[scale_min scale_max],real(c1x)); axis xy; axis tight;
ylabel('Scale (keV)');
xlabel('Excitation energy (MeV)');
title('CWT');


% ============== MAKING PROJECTIONS FOR IVGDR 12.000 - 24.000 MeV ==================

nscales=400;

% Note that the Wavelet scale is changed here to the Fourier scale!
binsize=10;              % Binsize is 20 keV
scalenorm(1:nscales)=0.; % Rescale as necessary
fourier_factor=1.0;      % Divide Complex Morlet   scale by 1.0 to give equivalent Fourier scale
%fourier_factor=0.3;     % Divide Complex Gaussian scale by 0.3 to give equivalent Fourier scale
for i=1:nscales
    scalenorm(i)=i/fourier_factor * binsize;
end


projy1cmx(1:nscales)=0.; % Panagiota 48Ca SLy4 NoCont B(E1)        %       %  

exbin_min=1;    % E_x(min) = 12.0 MeV 
exbin_max=1201; % E_x(max) = 24.0 MeV

for i=1:nscales;
    for j=exbin_min:exbin_max;
        projy1cmx(i)=projy1cmx(i)+abs(c1x(i,j))*abs(c1x(i,j));                                    
    end
projy1cm2Ex(i)=projy1cmx(i)/scalenorm(i); % Power spectrum squared/scale
%projy1cmEx(i)=sqrt(projy1cmx(i))/scalenorm(i); % Power spectrum/scale
projy1cmx(i)=sqrt(projy1cmx(i)); % Standard power spectrum 
end

projy1cmx_max=max(projy1cmx);
subplot(4,2,7); semilogx(scalenorm,projy1cmx/projy1cmx_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power (a.u.)')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');

projy1cm2Ex_max=max(projy1cm2Ex);
subplot(4,2,5); semilogx(scalenorm,projy1cm2Ex/projy1cm2Ex_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power^2/scale (a.u.)')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');































exbin_min=1;    % E_x(min) = 12.0 MeV 
exbin_max=1201; % E_x(max) = 24.0 MeV

for i=1:nscales;
    for j=exbin_min:exbin_max;
        projy1cmx(i)=projy1cmx(i)+abs(c1x(i,j))*abs(c1x(i,j)); % Standard power spectrum                                    
    end
projy1cmx(i)=sqrt(projy1cmx(i));
  
end

projy1cmx_max=max(projy1cmx);

subplot(4,2,7); semilogx(scalenorm,projy1cmx/projy1cmx_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);

xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power (a.u.)')
title('40Ca IVGDR 12.0 < E_x < 24 MeV');























hold on;

% =========================================================================

% Note that the Wavelet scale is changed here to the Fourier scale!
binsize=20;              % Binsize is 20 keV
scalenorm(1:nscales)=0.; % Rescale as necessary
fourier_factor=1.0;      % Divide Complex Morlet   scale by 1.0 to give equivalent Fourier scale
%fourier_factor=0.3;     % Divide Complex Gaussian scale by 0.3 to give equivalent Fourier scale
for i=1:nscales
    scalenorm(i)=i/fourier_factor * binsize;
end


projy1cm01(1:nscales)=0.;         % Spectrum 150NdPb(p,p')  8 deg.  

   
exbin01_min=150; % E_x(min) = 11.0 MeV 
exbin01_max=225; % E_x(max) = 12.5 MeV

for i=1:nscales;
    for j=exbin01_min:exbin01_max;
        projy1cm01(i)=projy1cm01(i)+abs(c1(i,j))*abs(c1(i,j)); % Standard power spectrum                                    
    end
projy1cm01(i)=sqrt(projy1cm01(i));
  
end

projy1cm01_max=max(projy1cm01);

%subplot(5,2,3); loglog(scalenorm,projy1cm/projy1cm_max,'linewidth',1.8,'color','green'), axis([40 2000 0 1.2]);
%JC1 subplot(5,2,3); semilogx(scalenorm,projy1cm/projy1cm_max,'linewidth',1.8,'color','black'), axis([40 2000 0 1.2]);
subplot(6,2,3); semilogx(scalenorm,projy1cm01/projy1cm_max,'linewidth',1.8,'color','red'), axis([40 nscales*binsize 0 1.2]);
%subplot(4,2,3); plot(scalenorm/1000,projy1cm/projy1cm_max,'linewidth',1.8,'color','red'), axis([0.0 3.5 0.0 1.1]);

%xlabel('Fourier [= Complex Morlet] Scale (keV)');
%ylabel('Power (a.u.)')
%title('150Nd ISGQR 10.0 < E_x < 14 MeV');

% =========================================================================






%--------------------------------------------------------------------------
xcut_min=1; % (1199 + 1)*10 keV = 12 MeV
xcut_max=1201; % (1199 + 1201)*10 keV = 24 MeV
xcut_span=xcut_max-xcut_min;
binsize=0.010;
xmev=(1199+xcut_min):(1199+xcut_max);  % GDR from xcut_min to xcut_max

xmev=xmev*binsize;


%--------------------------------------------------------------------------

% Load nd150 8 deg spectrum and plot Ex = 8 - 20 MeV

%fname='nd150_exp.dat'

fname='NoOxygen-150Nd-8deg.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

nd150_8cut_8_20=cnts_src(1:401); % Experimental spectrum 8 deg.



%==========================================================================
y1=nd150_8cut_8_20; % GQR energy spectrum
%==========================================================================

%--------------------------------------------------------------------------

% Load nd150 B(E2) RPA Modern Skryme spectrum and plot Ex = 8 - 20 MeV

%fname='nd150_skyrme.dat'
fname='Nd150_k=sum_RPA_mod_Skyrme.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

nd150_8cut_8_16_s=cnts_src(11:411)/(40*13);
% Theory B(E2) RPA Modern Skryme K=sum
% B(E2)) shifted down by 11 channels (220 keV)

%--------------------------------------------------------------------------
xcut_min=1; % (399 + 1)*20 keV = 8 MeV
xcut_max=401; % (399 + 401)*20 keV = 16 MeV
xcut_span=xcut_max-xcut_min;
binsize=0.02;
xmev=(399+xcut_min):(399+xcut_max);  % GQR from xcut_min to xcut_max

xmev=xmev*binsize;

hold off;

%==========================================================================
y2=nd150_8cut_8_16_s; % BE(2) K=sum
%==========================================================================


%nscales=100;
nscales=150;
t=1:401;

binsize=20; % 20 keV bin size
scale_min=1*binsize;
scale_max=nscales*binsize;

gqr_min=1; % GQR Ex = 8.0 to 16.0 MeV
gqr_max=401;

xmev2=(399+gqr_min):(399+gqr_max);  % GQR cut from gqr_min to gqr_max
xmev2=xmev2*binsize/1000;


y1(isnan(y1))=0; y2(isnan(y2))=0;
%m1=mean(y1(:)); m2=mean(y2(:)); y1=y1-m1; y2=y2-3*m2;
m1=mean(y1(:)); m2=mean(y2(:)); y1=y1-m1; y2=y2-3*m2; 
nscales=round(abs(nscales));
c1=cwt(y1,1:nscales,'cmor1-1'); 
c2=cwt(y2,1:nscales,'cmor1-1'); 
ctc=c1.*conj(c2); ct=abs(ctc);     % Cross wavelet transform amplitude
spt=atan2(imag(ctc),real(ctc));
s=cos(spt);                        % Semblance
%s2=s.*s;                          % cos*3 (theta)
%s3=s2.*s;
%s=s3;
% s=cos(spt).*(ct*25);             % Semblance enhanced
d=s.*ct;                           % Dot product (Expt-RPA)


% Display results

%figure(11);

currfig=get(0,'CurrentFigure'); set(currfig,'numbertitle','off');
set(currfig,'name','Wavelet Semblance Analysis'); 
%y1=y1+m1; y2=y2+3*m2;
y1=y1+m1; y2=y2+3*m2;

fname='NoOxygen-150Nd-8deg.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

nd150_8cut_8_20=cnts_src(1:401); % Experimental spectrum 8 deg.



%--------------------------------------------------------------------------

%figure(2); % 150Nd spectrum at 8 deg for GQR 8 < Ex < 20 MeV

%   Define various constants and plot parameters

% ==== produce X axes for the plots to get the correct values in Ex (MeV)

xcut_min=1; % (399 + 1)*20 keV = 8 MeV
xcut_max=401; % (399 + 601)*20 keV = 16 MeV

xcut_span=xcut_max-xcut_min;
binsize=0.02;
xmev=(399+xcut_min):(399+xcut_max);  % GQR from xcut_min to xcut_max
xmev=xmev*binsize;

subplot(6,2,2); plot(nd150_8cut_8_20(xcut_min:xcut_max),'linewidth',2.0,'Color','black'); axis tight;
ylim([0 500]);
ylabel('counts (20 keV^{ -1})');
xlabel('Energy ([8000 + channel*20] keV)');
title('^{150}Nd 8 deg. ISGQR E_x = 8 - 16 MeV');

hold on;

%



%
% Display K-splitting for B(E2) strength functions Nd isotopes
%


fname='150Nd_K0_bin20keV_fold3000keV.dat'
[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_MeV=ex_src(401:801); % B(E2) K0 smoothed Lorentzian gamma = 2.000 MeV
nd150_K0_8_16_lor3000=cnts_src(401:801); % B(E2) K0 smoothed Lorentzian 2.000 MeV

plot(0.09*nd150_K0_8_16_lor3000,'linewidth',0.8,'Color','red');

fname='150Nd_K1_bin20keV_fold3000keV.dat'
[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_MeV=ex_src(401:801); % B(E2) K1 smoothed Lorentzian 2.000 MeV
nd150_K1_8_16_lor3000=cnts_src(401:801); % B(E2) K1 smoothed Lorentzian 2.000 MeV

plot(0.09*nd150_K1_8_16_lor3000,'linewidth',0.8,'Color','green');

fname='150Nd_K2_bin20keV_fold3000keV.dat'
[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_MeV=ex_src(401:801); % B(E2) K2 smoothed Lorentzian 2.000 MeV
nd150_K2_8_16_lor3000=cnts_src(401:801); % B(E2) K2 smoothed Lorentzian 2.000 MeV

plot(0.09*nd150_K2_8_16_lor3000,'linewidth',0.8,'Color','blue');

for x=1:401;
    nd150_Ksum_8_16_lor3000(x)=nd150_K0_8_16_lor3000(x)+nd150_K1_8_16_lor3000(x)+nd150_K2_8_16_lor3000(x);
end

plot(0.09*nd150_Ksum_8_16_lor3000,'linewidth',2.0,'Color','magenta');

%==========================================================================
y1=nd150_8cut_8_20; % GQR energy spectrum
%==========================================================================


%JC1 subplot(5,2,4); imagesc(xmev2,[scale_min scale_max],real(c1)); axis xy; axis tight;
subplot(6,2,4); imagesc(xmev2,[scale_min scale_max],real(c1)); axis xy; axis tight;
%title('CWT');
ylabel('Scale (keV)');

line([11.0 11.0],[0 3000],'Marker','.','LineStyle','--', 'linewidth',2,'Color','black');
line([12.5 12.5],[0 3000],'Marker','.','LineStyle','--', 'linewidth',2,'Color','black');
line([14.0 14.0],[0 3000],'Marker','.','LineStyle','--', 'linewidth',2,'Color','black');

%subplot(4,2,6); plot(t,y2/40,'linewidth',1.28,'Color','black'); axis tight;
%JC1 subplot(5,2,6); plot(xmev2,y2,'linewidth',2.0,'Color','magenta'); axis tight;
subplot(6,2,6); plot(xmev2,y2,'linewidth',2.0,'Color','magenta'); axis tight;
ylim([0 70]);
ylabel('B(E2) (arb. units)');
%xlabel('Energy ([8000 + Channel*20] keV)');
%title('^{146}Nd B(E2) RPA Modern Skyrme [beta = 0.152]');
text (8.2,50, '^{150}Nd');
text (8.2,30, 'RPA');
legend('k = sum','Orientation','horizontal')%text (14,57,'K = sum');
legend boxoff;
hold on;

% subplot(5,2,6); plot(xmev2,nd146_8cut_8_16_K0,'linewidth',1.28,'Color','red'); axis tight;
% ylim([0 70]);
% text (14,42,'K = 0','Color','red');
% 
% subplot(5,2,6); plot(xmev2,nd146_8cut_8_16_K1,'linewidth',1.28,'Color','green'); axis tight;
% ylim([0 70]);
% text (14,27,'K = 1','Color','green');
% 
% subplot(5,2,6); plot(xmev2,nd146_8cut_8_16_K2,'linewidth',1.28,'Color','blue'); axis tight;
% ylim([0 70]);
% text (14,12,'K = 2','Color','blue');
% set(gca,'XTickLabel',{ });
% %legend(axes_handle,'boxoff');
% hold off;

%JC1 subplot(5,2,8); imagesc(xmev2,[scale_min scale_max],real(c2)); axis xy; axis tight;
subplot(6,2,8); imagesc(xmev2,[scale_min scale_max],real(c2)); axis xy; axis tight;
%title('CWT');
ylabel('Scale (keV)');
%xlabel('E_x (MeV)');

line([11.0 11.0],[0 3000],'Marker','.','LineStyle','--', 'linewidth',2,'Color','black');
line([12.5 12.5],[0 3000],'Marker','.','LineStyle','--', 'linewidth',2,'Color','black');
line([14.0 14.0],[0 3000],'Marker','.','LineStyle','--', 'linewidth',2,'Color','black');


%JC1 subplot(5,2,10); imagesc(xmev2,[scale_min scale_max],s,[-1 1]); axis xy; axis tight; title('Semblance'); ylabel('Wavelength');
subplot(6,2,10); imagesc(xmev2,[scale_min scale_max],s,[-1 1]); axis xy; axis tight; ylabel('Scale (keV)'); colorbar hide;
colormap(jet(256));
%title('Semblance');
%xlabel('Excitation energy (MeV)');

line([11.0 11.0],[0 3000],'Marker','.','LineStyle','--', 'linewidth',2,'Color','black');
line([12.5 12.5],[0 3000],'Marker','.','LineStyle','--', 'linewidth',2,'Color','black');
line([14.0 14.0],[0 3000],'Marker','.','LineStyle','--', 'linewidth',2,'Color','black');

%JC1 subplot(6,2,12); imagesc(xmev2,[scale_min scale_max],d); axis xy; axis tight; title('dot product'); ylabel('Wavelength'); colorbar hide;
subplot(6,2,12); imagesc(xmev2,[scale_min scale_max],d,[0 300]); axis xy; axis tight; ylabel('Scale (keV)'); colorbar hide;
colormap(jet(256));
%title('dot product');
xlabel('Excitation energy (MeV)');

line([11.0 11.0],[0 3000],'Marker','.','LineStyle','--', 'linewidth',2,'Color','black');
line([12.5 12.5],[0 3000],'Marker','.','LineStyle','--', 'linewidth',2,'Color','black');
line([14.0 14.0],[0 3000],'Marker','.','LineStyle','--', 'linewidth',2,'Color','black');


% ============== MAKING PROJECTIONS FOR ISGQR 8.000 - 16.000 MeV ==================

%nscales=100;
nscales=150;

% Note that the Wavelet scale is changed here to the Fourier scale!
binsize=20;              % Binsize is 20 keV
scalenorm(1:nscales)=0.; % Rescale as necessary
fourier_factor=1.0;      % Divide Complex Morlet   scale by 1.0 to give equivalent Fourier scale
%fourier_factor=0.3;     % Divide Complex Gaussian scale by 0.3 to give equivalent Fourier scale
for i=1:nscales
    scalenorm(i)=i/fourier_factor * binsize;
end


projy1cm(1:nscales)=0.;         % Spectrum 150NdPb(p,p')  8 deg.  

   
exbin_min=150; % E_x(min) = 11.0 MeV 
exbin_max=300; % E_x(max) = 14.0 MeV

for i=1:nscales;
    for j=exbin_min:exbin_max;
        projy1cm(i)=projy1cm(i)+abs(c1(i,j))*abs(c1(i,j)); % Standard power spectrum                                    
    end
projy1cm(i)=sqrt(projy1cm(i));
  
end

projy1cm_max=max(projy1cm);

%subplot(5,2,3); loglog(scalenorm,projy1cm/projy1cm_max,'linewidth',1.8,'color','green'), axis([40 2000 0 1.2]);
%JC1 subplot(5,2,3); semilogx(scalenorm,projy1cm/projy1cm_max,'linewidth',1.8,'color','black'), axis([40 2000 0 1.2]);
subplot(6,2,3); semilogx(scalenorm,projy1cm/projy1cm_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
%subplot(4,2,3); plot(scalenorm/1000,projy1cm/projy1cm_max,'linewidth',1.8,'color','red'), axis([0.0 3.5 0.0 1.1]);

%xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power (a.u.)')
%title('150Nd ISGQR 10.0 < E_x < 14 MeV');

hold on;

% =========================================================================

% Note that the Wavelet scale is changed here to the Fourier scale!
binsize=20;              % Binsize is 20 keV
scalenorm(1:nscales)=0.; % Rescale as necessary
fourier_factor=1.0;      % Divide Complex Morlet   scale by 1.0 to give equivalent Fourier scale
%fourier_factor=0.3;     % Divide Complex Gaussian scale by 0.3 to give equivalent Fourier scale
for i=1:nscales
    scalenorm(i)=i/fourier_factor * binsize;
end


projy1cm01(1:nscales)=0.;         % Spectrum 150NdPb(p,p')  8 deg.  

   
exbin01_min=150; % E_x(min) = 11.0 MeV 
exbin01_max=225; % E_x(max) = 12.5 MeV

for i=1:nscales;
    for j=exbin01_min:exbin01_max;
        projy1cm01(i)=projy1cm01(i)+abs(c1(i,j))*abs(c1(i,j)); % Standard power spectrum                                    
    end
projy1cm01(i)=sqrt(projy1cm01(i));
  
end

projy1cm01_max=max(projy1cm01);

%subplot(5,2,3); loglog(scalenorm,projy1cm/projy1cm_max,'linewidth',1.8,'color','green'), axis([40 2000 0 1.2]);
%JC1 subplot(5,2,3); semilogx(scalenorm,projy1cm/projy1cm_max,'linewidth',1.8,'color','black'), axis([40 2000 0 1.2]);
subplot(6,2,3); semilogx(scalenorm,projy1cm01/projy1cm_max,'linewidth',1.8,'color','red'), axis([40 nscales*binsize 0 1.2]);
%subplot(4,2,3); plot(scalenorm/1000,projy1cm/projy1cm_max,'linewidth',1.8,'color','red'), axis([0.0 3.5 0.0 1.1]);

%xlabel('Fourier [= Complex Morlet] Scale (keV)');
%ylabel('Power (a.u.)')
%title('150Nd ISGQR 10.0 < E_x < 14 MeV');

% =========================================================================

% =========================================================================

% Note that the Wavelet scale is changed here to the Fourier scale!
binsize=20;              % Binsize is 20 keV
scalenorm(1:nscales)=0.; % Rescale as necessary
fourier_factor=1.0;      % Divide Complex Morlet   scale by 1.0 to give equivalent Fourier scale
%fourier_factor=0.3;     % Divide Complex Gaussian scale by 0.3 to give equivalent Fourier scale
for i=1:nscales
    scalenorm(i)=i/fourier_factor * binsize;
end


projy1cm2(1:nscales)=0.;         % Spectrum 150NdPb(p,p')  8 deg.  

   
exbin2_min=225; % E_x(min) = 12.5 MeV 
exbin2_max=300; % E_x(max) = 14.0 MeV

for i=1:nscales;
    for j=exbin2_min:exbin2_max;
        projy1cm2(i)=projy1cm2(i)+abs(c1(i,j))*abs(c1(i,j)); % Standard power spectrum                                    
    end
projy1cm2(i)=sqrt(projy1cm2(i));
  
end

projy1cm2_max=max(projy1cm2);

%subplot(5,2,3); loglog(scalenorm,projy1cm/projy1cm_max,'linewidth',1.8,'color','green'), axis([40 2000 0 1.2]);
%JC1 subplot(5,2,3); semilogx(scalenorm,projy1cm/projy1cm_max,'linewidth',1.8,'color','black'), axis([40 2000 0 1.2]);
subplot(6,2,3); semilogx(scalenorm,projy1cm2/projy1cm_max,'linewidth',1.8,'color','blue'), axis([40 nscales*binsize 0 1.2]);
%subplot(4,2,3); plot(scalenorm/1000,projy1cm/projy1cm_max,'linewidth',1.8,'color','red'), axis([0.0 3.5 0.0 1.1]);

%xlabel('Fourier [= Complex Morlet] Scale (keV)');
%ylabel('Power (a.u.)')
%title('150Nd ISGQR 10.0 < E_x < 14 MeV');

hold off;

% ========================================================================


% ============== MAKING PROJECTIONS FOR B(E2) 10.000 - 14.000 MeV ==========

%nscales=100;
nscales=150;

% Note that the Wavelet scale is changed here to the Fourier scale!
binsize=20;              % Binsize is 20 keV
scalenorm(1:nscales)=0.; % Rescale as necessary
fourier_factor=1.0;      % Divide Complex Morlet   scale by 1.0 to give equivalent Fourier scale
%fourier_factor=0.3;     % Divide Complex Gaussian scale by 0.3 to give equivalent Fourier scale
for i=1:nscales
    scalenorm(i)=i/fourier_factor * binsize;
end


projy2cm(1:nscales)=0.;         % Spectrum 150Nd B(E2)    
   
exbin_min=150; % E_x(min) = 11.0 MeV 
exbin_max=300; % E_x(max) = 14.0 MeV

for i=1:nscales;
    for j=exbin_min:exbin_max;
        projy2cm(i)=projy2cm(i)+abs(c2(i,j))*abs(c2(i,j)); % Standard power spectrum                                    
    end
projy2cm(i)=sqrt(projy2cm(i));
  
end

projy2cm_max=max(projy2cm);

%subplot(5,2,7); loglog(scalenorm,projy2cm/projy2cm_max,'linewidth',1.8,'color','blue'), axis([40 2000 0 2]);
%JC1 subplot(5,2,7); semilogx(scalenorm,projy2cm/projy2cm_max,'linewidth',1.8,'color','black'), axis([40 2000 0 1.2]);
subplot(6,2,7); semilogx(scalenorm,projy2cm/projy2cm_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
%subplot(4,2,7); plot(scalenorm/1000,projy2cm/projy2cm_max,'linewidth',1.8,'color','red'), axis([0.0 3.5 0.0 1.1]);

%xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power (a.u.)')
%title('150Nd B(E2) 10.0 < E_x < 14 MeV');

hold on;

% =========================================================================

% Note that the Wavelet scale is changed here to the Fourier scale!
binsize=20;              % Binsize is 20 keV
scalenorm(1:nscales)=0.; % Rescale as necessary
fourier_factor=1.0;      % Divide Complex Morlet   scale by 1.0 to give equivalent Fourier scale
%fourier_factor=0.3;     % Divide Complex Gaussian scale by 0.3 to give equivalent Fourier scale
for i=1:nscales
    scalenorm(i)=i/fourier_factor * binsize;
end


projy2cm01(1:nscales)=0.;         % Spectrum 150Nd B(E2)    
   
exbin01_min=150; % E_x(min) = 11.0 MeV 
exbin01_max=225; % E_x(max) = 12.5 MeV

for i=1:nscales;
    for j=exbin01_min:exbin01_max;
        projy2cm01(i)=projy2cm01(i)+abs(c2(i,j))*abs(c2(i,j)); % Standard power spectrum                                    
    end
projy2cm01(i)=sqrt(projy2cm01(i));
  
end

projy2cm01_max=max(projy2cm01);

%subplot(5,2,7); loglog(scalenorm,projy2cm/projy2cm_max,'linewidth',1.8,'color','blue'), axis([40 2000 0 2]);
%JC1 subplot(5,2,7); semilogx(scalenorm,projy2cm/projy2cm_max,'linewidth',1.8,'color','black'), axis([40 2000 0 1.2]);
subplot(6,2,7); semilogx(scalenorm,projy2cm01/projy2cm_max,'linewidth',1.8,'color','red'), axis([40 nscales*binsize 0 1.2]);
%subplot(4,2,7); plot(scalenorm/1000,projy2cm/projy2cm_max,'linewidth',1.8,'color','red'), axis([0.0 3.5 0.0 1.1]);

%xlabel('Fourier [= Complex Morlet] Scale (keV)');
%ylabel('Power (a.u.)')
%title('150Nd B(E2) 10.0 < E_x < 14 MeV');

% =========================================================================

% =========================================================================

% Note that the Wavelet scale is changed here to the Fourier scale!
binsize=20;              % Binsize is 20 keV
scalenorm(1:nscales)=0.; % Rescale as necessary
fourier_factor=1.0;      % Divide Complex Morlet   scale by 1.0 to give equivalent Fourier scale
%fourier_factor=0.3;     % Divide Complex Gaussian scale by 0.3 to give equivalent Fourier scale
for i=1:nscales
    scalenorm(i)=i/fourier_factor * binsize;
end


projy2cm2(1:nscales)=0.;         % Spectrum 150Nd B(E2)    
   
exbin2_min=225; % E_x(min) = 12.5 MeV 
exbin2_max=300; % E_x(max) = 14.0 MeV

for i=1:nscales;
    for j=exbin2_min:exbin2_max;
        projy2cm2(i)=projy2cm2(i)+abs(c2(i,j))*abs(c2(i,j)); % Standard power spectrum                                    
    end
projy2cm2(i)=sqrt(projy2cm2(i));
  
end

projy2cm2_max=max(projy2cm2);

%subplot(5,2,7); loglog(scalenorm,projy2cm/projy2cm_max,'linewidth',1.8,'color','blue'), axis([40 2000 0 2]);
%JC1 subplot(5,2,7); semilogx(scalenorm,projy2cm/projy2cm_max,'linewidth',1.8,'color','black'), axis([40 2000 0 1.2]);
subplot(6,2,7); semilogx(scalenorm,projy2cm2/projy2cm_max,'linewidth',1.8,'color','blue'), axis([40 nscales*binsize 0 1.2]);
%subplot(4,2,7); plot(scalenorm/1000,projy2cm/projy2cm_max,'linewidth',1.8,'color','red'), axis([0.0 3.5 0.0 1.1]);

%xlabel('Fourier [= Complex Morlet] Scale (keV)');
%ylabel('Power (a.u.)')
%title('150Nd B(E2) 10.0 < E_x < 14 MeV');

hold off;


% ============== MAKING PROJECTIONS FOR SEMBLANCE 10.0 - 14.0 MEV ==========

projs_gqr(1:nscales)=0.;

exbin_min=150; % E_x(min) = 11.0 MeV 
exbin_max=300; % E_x(max) = 14.0 MeV

for i=1:nscales
    for j=exbin_min:exbin_max
        projs_gqr(i)=projs_gqr(i)+s(i,j); % Sum semblance coefficients onto scales axis                
    end
projs_gqr(i)=projs_gqr(i)/(exbin_max-exbin_min +1);    
end

% Note that the Morlet scale is changed here!
binsize=20; % Binsize is 10 keV
scalenorm_gqr(1:nscales)=0.; % Rescale as necessary
fourier_factor=1.0; % Divide Complex Morlet scale by 1.0 to give equivalent Fourier scale
for i=1:nscales
    scalenorm_gqr(i)=i/fourier_factor*binsize;
end

%JC1 subplot(5,2,9); semilogx(scalenorm_gqr(1:nscales),projs_gqr(1:nscales),'linewidth',1.8,'color','black'),  axis([40 2000 -1.2 +1.2]);
subplot(6,2,9); semilogx(scalenorm_gqr(1:nscales),projs_gqr(1:nscales),'linewidth',1.8,'color','black'),  axis([40 nscales*binsize -0.3 +1.2]);
ylabel('Semblance');
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
%title('Semblance 10.0 < E_x < 14 MeV');

hold on;

%--------------------------------------------------------------------------

projs01_gqr(1:nscales)=0.;

exbin01_min=150; % E_x(min) = 11.0 MeV 
exbin01_max=225; % E_x(max) = 12.5 MeV

for i=1:nscales
    for j=exbin01_min:exbin01_max
        projs01_gqr(i)=projs01_gqr(i)+s(i,j); % Sum semblance coefficients onto scales axis                
    end
projs01_gqr(i)=projs01_gqr(i)/(exbin_max-exbin_min +1);    
end

% Note that the Morlet scale is changed here!
binsize=20; % Binsize is 10 keV
scalenorm_gqr(1:nscales)=0.; % Rescale as necessary
fourier_factor=1.0; % Divide Complex Morlet scale by 1.0 to give equivalent Fourier scale
for i=1:nscales
    scalenorm_gqr(i)=i/fourier_factor*binsize;
end

%JC1 subplot(5,2,9); semilogx(scalenorm_gqr(1:nscales),projs_gqr(1:nscales),'linewidth',1.8,'color','black'),  axis([40 2000 -1.2 +1.2]);
subplot(6,2,9); semilogx(scalenorm_gqr(1:nscales),projs01_gqr(1:nscales),'linewidth',1.8,'color','red'),  axis([40 nscales*binsize -0.3 +1.2]);
%ylabel('Semblance');
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
%title('Semblance 10.0 < E_x < 14 MeV');

%--------------------------------------------------------------------------

projs2_gqr(1:nscales)=0.;

exbin2_min=225; % E_x(min) = 12.5 MeV 
exbin2_max=300; % E_x(max) = 14.0 MeV

for i=1:nscales
    for j=exbin2_min:exbin2_max
        projs2_gqr(i)=projs2_gqr(i)+s(i,j); % Sum semblance coefficients onto scales axis                
    end
projs2_gqr(i)=projs2_gqr(i)/(exbin_max-exbin_min +1);    
end

% Note that the Morlet scale is changed here!
binsize=20; % Binsize is 10 keV
scalenorm_gqr(1:nscales)=0.; % Rescale as necessary
fourier_factor=1.0; % Divide Complex Morlet scale by 1.0 to give equivalent Fourier scale
for i=1:nscales
    scalenorm_gqr(i)=i/fourier_factor*binsize;
end

%JC1 subplot(5,2,9); semilogx(scalenorm_gqr(1:nscales),projs_gqr(1:nscales),'linewidth',1.8,'color','black'),  axis([40 2000 -1.2 +1.2]);
subplot(6,2,9); semilogx(scalenorm_gqr(1:nscales),projs2_gqr(1:nscales),'linewidth',1.8,'color','blue'),  axis([40 nscales*binsize -0.3 +1.2]);
%ylabel('Semblance');
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
%title('Semblance 10.0 < E_x < 14 MeV');

hold off;

%--------------------------------------------------------------------------

% ============== MAKING PROJECTIONS FOR DOT PRODUCT 10.0 - 14.0 MEV ==========

projd_gqr(1:nscales)=0.;

exbin_min=150; % E_x(min) = 11.0 MeV 
exbin_max=300; % E_x(max) = 14.0 MeV

for i=1:nscales
    for j=exbin_min:exbin_max
        projd_gqr(i)=projd_gqr(i)+d(i,j); % Sum semblance coefficients onto scales axis                
    end
projd_gqr(i)=projd_gqr(i);
%projd_gqr(i)=projd_gqr(i)/i; % divide through by scale value to enhance small scales
end

% Note that the Morlet scale is changed here!
binsize=20; % Binsize is 10 keV
scalenorm_gqr(1:nscales)=0.; % Rescale as necessary
fourier_factor=1.0; % Divide Complex Morlet scale by 1.0 to give equivalent Fourier scale
for i=1:nscales
    scalenorm_gqr(i)=i/fourier_factor*binsize;
end

projd_gqr_max=max(projd_gqr);

%JC1 subplot(5,2,9); semilogx(scalenorm_gqr(1:nscales),projs_gqr(1:nscales),'linewidth',1.8,'color','black'),  axis([40 2000 -1.2 +1.2]);
subplot(6,2,11); semilogx(scalenorm_gqr(1:nscales),projd_gqr(1:nscales)/projd_gqr_max,'linewidth',1.8,'color','black'),  axis([40 nscales*binsize -0.3 +1.2]);

ylabel('dot product (a.u.)');
xlabel('Fourier [= Complex Morlet] Scale (keV)');
%title('Semblance 10.0 < E_x < 14 MeV');

%--------------------------------------------------------------------------



