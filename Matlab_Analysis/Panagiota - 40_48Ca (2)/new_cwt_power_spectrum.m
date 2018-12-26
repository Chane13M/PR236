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

fname='58Ni_ExCs_10_24_10kev.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_10_24_10keV(1:1400)=ex_src(1:1400); % Excitation energy 12-24 MeV in 10 keV steps  
Ni58_10_24_10keV(1:1400)=cnts_src(1:1400); % Panagiota 40Ca SLy4 NoCont B(E1)


figure (5);
subplot(4,2,2); plot(ex_10_24_10keV,Ni58_10_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 35]);
ylabel('B(E1) (e^2fm^2 / MeV)');
%xlabel('Excitation energy (MeV)');
title('Panagiota 40Ca SLy4 NoCont B(E1)');



%==========================================================================
y1=Ni58_10_24_10keV; % Panagiota 40Ca SLy4 NoCont B(E1)
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

fname='58Ni_ExCs_10_24_10kev.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_10_24_10keV(1:1400)=ex_src(1:1400); % Excitation energy 12-24 MeV in 10 keV steps  
Ni58_10_24_10keV(1:1400)=cnts_src(1:1400); % Panagiota 40Ca SLy4 NoCont B(E1)

% multiply B(E1) by E_x for comparison with photoabsorption spectrum
for x=1:1400;
    Ni58_10_24_10keV(x)=Ni58_10_24_10keV(x)*ex_10_24_10keV(x);
end


subplot(4,2,6); plot(ex_10_24_10keV,Ni58_10_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 650]);
ylabel('B(E1)*E_x (e^2fm^2)');
%xlabel('Excitation energy (MeV)');
title('Panagiota 40Ca SLy4 NoCont B(E1)*E_x');



%==========================================================================
y1x=Ni58_10_24_10keV; % Panagiota 40Ca SLy4 NoCont B(E1)
%==========================================================================

nscales=600;

binsize=10; % 10 keV bin size
scale_min=1*binsize;
scale_max=nscales*binsize;

gdr_min=1; % GDR Ex = 12.0 to 24.0 MeV
gdr_max=1400;

xmev2=(999+gdr_min):(999+gdr_max);  % GDR cut from gdr_min to gdr_max
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

nscales=600;

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
exbin_max=1400; % E_x(max) = 24.0 MeV

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


%===========================================================================
% Check use of Power definition

% Load Panagiota Ca40 Panagiota 40Ca SLy4 NoCont B(E1)

fname='58Ni_ExCs_10_24_10kev.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_10_24_10keV(1:1400)=ex_src(1:1400); % Excitation energy 12-24 MeV in 10 keV steps  
Ni58_10_24_10keV(1:1400)=cnts_src(1:1400); % Panagiota 40Ca SLy4 NoCont B(E1)


figure (10);
subplot(4,2,2); plot(ex_10_24_10keV,Ni58_10_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 35]);
ylabel('B(E1) (e^2fm^2 / MeV)');
%xlabel('Excitation energy (MeV)');
title('Panagiota 40Ca SLy4 NoCont B(E1)');



%==========================================================================
y1=Ni58_10_24_10keV; % Panagiota 40Ca SLy4 NoCont B(E1)
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

fname='58Ni_ExCs_10_24_10kev.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_10_24_10keV(1:1400)=ex_src(1:1400); % Excitation energy 12-24 MeV in 10 keV steps  
Ni58_10_24_10keV(1:1400)=cnts_src(1:1400); % Panagiota 40Ca SLy4 NoCont B(E1)

% multiply B(E1) by E_x for comparison with photoabsorption spectrum
for x=1:1400;
    Ni58_10_24_10keV(x)=Ni58_10_24_10keV(x)*ex_10_24_10keV(x);
end


subplot(4,2,6); plot(ex_10_24_10keV,Ni58_10_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 650]);
ylabel('B(E1)*E_x (e^2fm^2)');
%xlabel('Excitation energy (MeV)');
title('Panagiota 40Ca SLy4 NoCont B(E1)*E_x');



%==========================================================================
y1x=Ni58_10_24_10keV; % Panagiota 40Ca SLy4 NoCont B(E1)
%==========================================================================

nscales=600;

binsize=10; % 10 keV bin size
scale_min=1*binsize;
scale_max=nscales*binsize;

gdr_min=1; % GDR Ex = 12.0 to 24.0 MeV
gdr_max=1400;

xmev2=(999+gdr_min):(999+gdr_max);  % GDR cut from gdr_min to gdr_max
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

nscales=600;

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
exbin_max=1400; % E_x(max) = 24.0 MeV

for i=1:nscales;
    for j=exbin_min:exbin_max;
        projy1cmx(i)=projy1cmx(i)+abs(c1x(i,j))*abs(c1x(i,j));                                    
    end
%projy1cm2Ex(i)=projy1cmx(i)/scalenorm(i); % Power spectrum squared/scale
%projy1cmEx(i)=sqrt(projy1cmx(i))/scalenorm(i); % Power spectrum/scale
%projy1cmx(i)=sqrt(projy1cmx(i)); % Standard power spectrum
projy1cm2Ex(i)=projy1cmx(i)*projy1cmx(i)/scalenorm(i); % Power spectrum squared/scale
projy1cmEx(i)=projy1cmx(i)/scalenorm(i); % Power spectrum/scale
projy1cmx(i)=projy1cmx(i); % Standard power spectrum 

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

%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% 40Ca composite

figure (300);

subplot(4,2,6); plot(ex_10_24_10keV,Ni58_10_24_10keV,'linewidth',1.8,'Color','blue'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 650]);
ylabel('B(E1)*E_x (e^2fm^2)');
%xlabel('Excitation energy (MeV)');
title('Panagiota 40Ca SLy4 NoCont B(E1)*E_x');
hold on;

projy1cmx_max=max(projy1cmx);
subplot(4,2,7); semilogx(scalenorm,projy1cmx/projy1cmx_max,'linewidth',1.8,'color','blue'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power (a.u.)')
title('40Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

projy1cmEx_max=max(projy1cmEx);
subplot(4,2,5); semilogx(scalenorm,projy1cmEx/projy1cmEx_max,'linewidth',1.8,'color','blue'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power / scale (a.u.)')
title('40Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

projy1cm2Ex_max=max(projy1cm2Ex);
subplot(4,2,3); semilogx(scalenorm,projy1cm2Ex/projy1cm2Ex_max,'linewidth',1.8,'color','blue'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power^2 / scale (a.u.)')
title('40Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


%=========================================================================
% 48Ca

fname='58Ni_ExCs_10_24_10kev.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_10_24_10keV(1:1400)=ex_src(1:1400); % Excitation energy 12-24 MeV in 10 keV steps  
Ni58_10_24_10keV(1:1400)=cnts_src(1:1400); % Panagiota 48Ca SLy4 NoCont B(E1)


figure (20);
subplot(4,2,2); plot(ex_10_24_10keV,Ni58_10_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 35]);
ylabel('B(E1) (e^2fm^2 / MeV)');
%xlabel('Excitation energy (MeV)');
title('Panagiota 48Ca SLy4 NoCont B(E1)');



%==========================================================================
y1=Ni58_10_24_10keV; % Panagiota 48Ca SLy4 NoCont B(E1)
%==========================================================================

nscales=600;

binsize=10; % 10 keV bin size
scale_min=1*binsize;
scale_max=nscales*binsize;

gdr_min=1; % GDR Ex = 12.0 to 24.0 MeV
gdr_max=1400;

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

fname='58Ni_ExCs_10_24_10kev.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_10_24_10keV(1:1400)=ex_src(1:1400); % Excitation energy 12-24 MeV in 10 keV steps  
Ni58_10_24_10keV(1:1400)=cnts_src(1:1400); % Panagiota 48Ca SLy4 NoCont B(E1)

% multiply B(E1) by E_x for comparison with photoabsorption spectrum
for x=1:1400;
    Ni58_10_24_10keV(x)=Ni58_10_24_10keV(x)*ex_10_24_10keV(x);
end


subplot(4,2,6); plot(ex_10_24_10keV,Ni58_10_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 650]);
ylabel('B(E1)*E_x (e^2fm^2)');
%xlabel('Excitation energy (MeV)');
title('Panagiota 48Ca SLy4 NoCont B(E1)*E_x');



%==========================================================================
y1x=Ni58_10_24_10keV; % Panagiota 48Ca SLy4 NoCont B(E1)
%==========================================================================

nscales=600;

binsize=10; % 10 keV bin size
scale_min=1*binsize;
scale_max=nscales*binsize;

gdr_min=1; % GDR Ex = 12.0 to 24.0 MeV
gdr_max=1400;

xmev2=(999+gdr_min):(999+gdr_max);  % GDR cut from gdr_min to gdr_max
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

nscales=600;

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
exbin_max=1400; % E_x(max) = 24.0 MeV

for i=1:nscales;
    for j=exbin_min:exbin_max;
        projy1cmx(i)=projy1cmx(i)+abs(c1x(i,j))*abs(c1x(i,j));                                    
    end
%projy1cm2Ex(i)=projy1cmx(i)/scalenorm(i); % Power spectrum squared/scale
%projy1cmEx(i)=sqrt(projy1cmx(i))/scalenorm(i); % Power spectrum/scale
%projy1cmx(i)=sqrt(projy1cmx(i)); % Standard power spectrum
projy1cm2Ex(i)=projy1cmx(i)*projy1cmx(i)/scalenorm(i); % Power spectrum squared/scale
projy1cmEx(i)=projy1cmx(i)/scalenorm(i); % Power spectrum/scale
projy1cmx(i)=projy1cmx(i); % Standard power spectrum
projy1cmsqEx(i)=sqrt(projy1cmx(i))/scalenorm(i); % Square root(Power spectrum)/scale

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

%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% 48Ca composite

figure (310);

subplot(4,2,6); plot(ex_10_24_10keV,Ni58_10_24_10keV,'linewidth',1.8,'Color','blue'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 650]);
ylabel('B(E1)*E_x (e^2fm^2)');
%xlabel('Excitation energy (MeV)');
title('Panagiota 48Ca SLy4 NoCont B(E1)*E_x');
hold on;

projy1cmx_max=max(projy1cmx);
subplot(4,2,7); semilogx(scalenorm,projy1cmx/projy1cmx_max,'linewidth',1.8,'color','blue'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power (a.u.)')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

projy1cmEx_max=max(projy1cmEx);
subplot(4,2,5); semilogx(scalenorm,projy1cmEx/projy1cmEx_max,'linewidth',1.8,'color','blue'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power / scale (a.u.)')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

projy1cm2Ex_max=max(projy1cm2Ex);
subplot(4,2,3); semilogx(scalenorm,projy1cm2Ex/projy1cm2Ex_max,'linewidth',1.8,'color','blue'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power^2 / scale (a.u.)')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% 48Ca composite

figure (312);  % Alter power spectra to absolute

subplot(4,2,6); plot(ex_10_24_10keV,Ni58_10_24_10keV,'linewidth',1.8,'Color','blue'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 650]);
ylabel('B(E1)*E_x (e^2fm^2)');
xlabel('Excitation energy (MeV)');
title('Panagiota 48Ca SLy4 NoCont B(E1)*E_x');
hold on;

projy1cmx_max=max(projy1cmx);
%subplot(4,2,7); semilogx(scalenorm,projy1cmx/projy1cmx_max,'linewidth',1.8,'color','blue'), axis([40 nscales*binsize 0 1.2]);
subplot(4,2,7); semilogx(scalenorm,projy1cmx,'linewidth',1.8,'color','blue'), axis([40 nscales*binsize 0 13e6]);
set(gca,'TickLength',[0.03 0.03]);
xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power')
title('   48Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

projy1cmEx_max=max(projy1cmEx);
%subplot(4,2,5); semilogx(scalenorm,projy1cmEx/projy1cmEx_max,'linewidth',1.8,'color','blue'), axis([40 nscales*binsize 0 1.2]);
subplot(4,2,5); semilogx(scalenorm,projy1cmEx,'linewidth',1.8,'color','blue'), axis([40 nscales*binsize 0 7e3]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power / scale')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

projy1cm2Ex_max=max(projy1cm2Ex);
%subplot(4,2,3); semilogx(scalenorm,projy1cm2Ex/projy1cm2Ex_max,'linewidth',1.8,'color','blue'), axis([40 nscales*binsize 0 1.2]);
%subplot(4,2,3); semilogx(scalenorm,projy1cm2Ex/1e10,'linewidth',1.8,'color','blue'), axis([40 nscales*binsize 0 5]);
subplot(4,2,3); semilogx(scalenorm,sqrt(projy1cmx),'linewidth',1.8,'color','blue'), axis([40 nscales*binsize 0 3.8e3]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
%ylabel('Power^2 / scale (a.u.)')
ylabel('Power^{1/2}')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

projy1cm2Ex_max=max(projy1cm2Ex);
%subplot(4,2,3); semilogx(scalenorm,projy1cm2Ex/projy1cm2Ex_max,'linewidth',1.8,'color','blue'), axis([40 nscales*binsize 0 1.2]);
%subplot(4,2,3); semilogx(scalenorm,projy1cm2Ex/1e10,'linewidth',1.8,'color','blue'), axis([40 nscales*binsize 0 5]);
subplot(4,2,1); semilogx(scalenorm,projy1cmsqEx,'linewidth',1.8,'color','blue'), axis([40 nscales*binsize 0 10]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
%ylabel('Power^2 / scale (a.u.)')
ylabel('Power^{1/2} / scale')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

%==========================================================================
% CRPA results Panagiota


% Load Panagiota 40Ca CRPA B(E1) from 2015

fname='58Ni_ExCs_10_24_10kev.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_10_24_10keV(1:1400)=ex_src(1:1400); % Excitation energy 12-24 MeV in 10 keV steps  
Ni58_10_24_10keV(1:1400)=cnts_src(1:1400); % Panagiota 40Ca CRPA B(E1)


figure (30);
subplot(4,2,2); plot(ex_10_24_10keV,Ni58_10_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 5.5]);
ylabel('B(E1) (e^2fm^2 / MeV)');
%xlabel('Excitation energy (MeV)');
title('Panagiota 40Ca CRPA B(E1)');



%==========================================================================
y1=Ni58_10_24_10keV; % Panagiota 40Ca CRPA B(E1)
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

fname='58Ni_ExCs_10_24_10kev.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_10_24_10keV(1:1400)=ex_src(1:1400); % Excitation energy 12-24 MeV in 10 keV steps  
Ni58_10_24_10keV(1:1400)=cnts_src(1:1400); % Panagiota 40Ca CRPA B(E1)

% multiply B(E1) by E_x for comparison with photoabsorption spectrum
for x=1:1400;
    Ni58_10_24_10keV(x)=Ni58_10_24_10keV(x)*ex_10_24_10keV(x);
end


subplot(4,2,6); plot(ex_10_24_10keV,Ni58_10_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 90]);
ylabel('B(E1)*E_x (e^2fm^2)');
%xlabel('Excitation energy (MeV)');
title('Panagiota 40Ca CRPA B(E1)*E_x');



%==========================================================================
y1x=Ni58_10_24_10keV; % Panagiota 40Ca CRPA B(E1)*E_x
%==========================================================================

nscales=600;

binsize=10; % 10 keV bin size
scale_min=1*binsize;
scale_max=nscales*binsize;

gdr_min=1; % GDR Ex = 12.0 to 24.0 MeV
gdr_max=1400;

xmev2=(999+gdr_min):(999+gdr_max);  % GDR cut from gdr_min to gdr_max
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

nscales=600;

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
exbin_max=1400; % E_x(max) = 24.0 MeV

for i=1:nscales;
    for j=exbin_min:exbin_max;
        projy1cmx(i)=projy1cmx(i)+abs(c1x(i,j))*abs(c1x(i,j));                                    
    end
%projy1cm2Ex(i)=projy1cmx(i)/scalenorm(i); % Power spectrum squared/scale
%projy1cmEx(i)=sqrt(projy1cmx(i))/scalenorm(i); % Power spectrum/scale
%projy1cmx(i)=sqrt(projy1cmx(i)); % Standard power spectrum
projy1cm2Ex(i)=projy1cmx(i)*projy1cmx(i)/scalenorm(i); % Power spectrum squared/scale
projy1cmEx(i)=projy1cmx(i)/scalenorm(i); % Power spectrum/scale
projy1cmx(i)=projy1cmx(i); % Standard power spectrum 
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


%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% 40Ca composite

figure (300);

subplot(4,2,4); plot(ex_10_24_10keV,Ni58_10_24_10keV,'linewidth',1.8,'Color','red'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 90]);
ylabel('B(E1)*E_x (e^2fm^2)');
%xlabel('Excitation energy (MeV)');
title('Panagiota 40Ca CRPA B(E1)*E_x');
hold on;

projy1cmx_max=max(projy1cmx);
subplot(4,2,7); semilogx(scalenorm,projy1cmx/projy1cmx_max,'linewidth',1.8,'color','red'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power (a.u.)')
title('40Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

projy1cmEx_max=max(projy1cmEx);
set(gca,'TickLength',[0.03 0.03]);
subplot(4,2,5); semilogx(scalenorm,projy1cmEx/projy1cmEx_max,'linewidth',1.8,'color','red'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power / scale (a.u.)')
title('40Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

projy1cm2Ex_max=max(projy1cm2Ex);
subplot(4,2,3); semilogx(scalenorm,projy1cm2Ex/projy1cm2Ex_max,'linewidth',1.8,'color','red'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power^2 / scale (a.u.)')
title('40Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


%==========================================================================
% CRPA results Panagiota


% Load Panagiota 48Ca CRPA B(E1) from 2015

fname='58Ni_ExCs_10_24_10kev.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_10_24_10keV(1:1400)=ex_src(1:1400); % Excitation energy 12-24 MeV in 10 keV steps  
Ni58_10_24_10keV(1:1400)=cnts_src(1:1400); % Panagiota 48Ca CRPA B(E1)


figure (40);
subplot(4,2,2); plot(ex_10_24_10keV,Ni58_10_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 5.5]);
ylabel('B(E1) (e^2fm^2 / MeV)');
%xlabel('Excitation energy (MeV)');
title('Panagiota 48Ca CRPA B(E1)');



%==========================================================================
y1=Ni58_10_24_10keV; % Panagiota 48Ca CRPA B(E1)
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

fname='58Ni_ExCs_10_24_10kev.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_10_24_10keV(1:1400)=ex_src(1:1400); % Excitation energy 12-24 MeV in 10 keV steps  
Ni58_10_24_10keV(1:1400)=cnts_src(1:1400); % Panagiota 48Ca CRPA B(E1)

% multiply B(E1) by E_x for comparison with photoabsorption spectrum
for x=1:1400;
    Ni58_10_24_10keV(x)=Ni58_10_24_10keV(x)*ex_10_24_10keV(x);
end


subplot(4,2,6); plot(ex_10_24_10keV,Ni58_10_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 90]);
ylabel('B(E1)*E_x (e^2fm^2)');
%xlabel('Excitation energy (MeV)');
title('Panagiota 48Ca CRPA B(E1)*E_x');



%==========================================================================
y1x=Ni58_10_24_10keV; % Panagiota 48Ca CRPA B(E1)*E_x
%==========================================================================

nscales=600;

binsize=10; % 10 keV bin size
scale_min=1*binsize;
scale_max=nscales*binsize;

gdr_min=1; % GDR Ex = 12.0 to 24.0 MeV
gdr_max=1400;

xmev2=(999+gdr_min):(999+gdr_max);  % GDR cut from gdr_min to gdr_max
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

nscales=600;

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
exbin_max=1400; % E_x(max) = 24.0 MeV

for i=1:nscales;
    for j=exbin_min:exbin_max;
        projy1cmx(i)=projy1cmx(i)+abs(c1x(i,j))*abs(c1x(i,j));                                    
    end
%projy1cm2Ex(i)=projy1cmx(i)/scalenorm(i); % Power spectrum squared/scale
%projy1cmEx(i)=sqrt(projy1cmx(i))/scalenorm(i); % Power spectrum/scale
%projy1cmx(i)=sqrt(projy1cmx(i)); % Standard power spectrum
projy1cm2Ex(i)=projy1cmx(i)*projy1cmx(i)/scalenorm(i); % Power spectrum squared/scale
projy1cmEx(i)=projy1cmx(i)/scalenorm(i); % Power spectrum/scale
projy1cmx(i)=projy1cmx(i); % Standard power spectrum
projy1cmsqEx(i)=sqrt(projy1cmx(i))/scalenorm(i); % Square root(Power spectrum)/scale
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


%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% 48Ca composite

figure (310);

subplot(4,2,4); plot(ex_10_24_10keV,Ni58_10_24_10keV,'linewidth',1.8,'Color','red'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 90]);
ylabel('B(E1)*E_x (e^2fm^2)');
%xlabel('Excitation energy (MeV)');
title('Panagiota 48Ca CRPA B(E1)*E_x');
hold on;

projy1cmx_max=max(projy1cmx);
subplot(4,2,7); semilogx(scalenorm,projy1cmx/projy1cmx_max,'linewidth',1.8,'color','red'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power (a.u.)')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

projy1cmEx_max=max(projy1cmEx);
subplot(4,2,5); semilogx(scalenorm,projy1cmEx/projy1cmEx_max,'linewidth',1.8,'color','red'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power / scale (a.u.)')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

projy1cm2Ex_max=max(projy1cm2Ex);
subplot(4,2,3); semilogx(scalenorm,projy1cm2Ex/projy1cm2Ex_max,'linewidth',1.8,'color','red'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power^2 / scale (a.u.)')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% 48Ca composite

figure (312); % Alter power spectrum to absolute

subplot(4,2,4); plot(ex_10_24_10keV,Ni58_10_24_10keV,'linewidth',1.8,'Color','red'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 90]);
ylabel('B(E1)*E_x (e^2fm^2)');
%xlabel('Excitation energy (MeV)');
title('Panagiota 48Ca CRPA B(E1)*E_x');
hold on;

projy1cmx_max=max(projy1cmx);
%subplot(4,2,7); semilogx(scalenorm,projy1cmx/projy1cmx_max,'linewidth',1.8,'color','red'), axis([40 nscales*binsize 0 1.2]);
subplot(4,2,7); semilogx(scalenorm,projy1cmx,'linewidth',1.8,'color','red'), axis([40 nscales*binsize 0 13e6]);
set(gca,'TickLength',[0.03 0.03]);
xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power')
title('   48Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

projy1cmEx_max=max(projy1cmEx);
%subplot(4,2,5); semilogx(scalenorm,projy1cmEx/projy1cmEx_max,'linewidth',1.8,'color','red'), axis([40 nscales*binsize 0 1.2]);
subplot(4,2,5); semilogx(scalenorm,projy1cmEx,'linewidth',1.8,'color','red'), axis([40 nscales*binsize 0 7e3]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power / scale')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

projy1cm2Ex_max=max(projy1cm2Ex);
%subplot(4,2,3); semilogx(scalenorm,projy1cm2Ex/projy1cm2Ex_max,'linewidth',1.8,'color','red'), axis([40 nscales*binsize 0 1.2]);
%subplot(4,2,3); semilogx(scalenorm,projy1cm2Ex/1e10,'linewidth',1.8,'color','red'), axis([40 nscales*binsize 0 5]);
subplot(4,2,3); semilogx(scalenorm,sqrt(projy1cmx),'linewidth',1.8,'color','red'), axis([40 nscales*binsize 0 3.8e3]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
%ylabel('Power^2 / scale (a.u.)')
ylabel('Power^{1/2}')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

projy1cm2Ex_max=max(projy1cm2Ex);
%subplot(4,2,3); semilogx(scalenorm,projy1cm2Ex/projy1cm2Ex_max,'linewidth',1.8,'color','red'), axis([40 nscales*binsize 0 1.2]);
%subplot(4,2,3); semilogx(scalenorm,projy1cm2Ex/1e10,'linewidth',1.8,'color','red'), axis([40 nscales*binsize 0 5]);
subplot(4,2,1); semilogx(scalenorm,projy1cmsqEx,'linewidth',1.8,'color','red'), axis([40 nscales*binsize 0 10]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
%ylabel('Power^2 / scale (a.u.)')
ylabel('Power^{1/2} / scale')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;


%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


% <===

% ===>

%=========================================================================
% Display experimental dat E_X = 8 - 26 MeV
%
% 40Ca extraction Max

fname='58Ni_ExCs_10_24_10kev.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_10_24_10keV(1:1400)=ex_src(1:1400); % Excitation energy 8-26 MeV in 10 keV steps  
Ni58_cs_10_24_10keV(1:1400)=cnts_src(1:1400); % Max 40Ca(p,p') cross-section (mb/sr MeV)


figure (100);
subplot(4,1,4); stairs(ex_10_24_10keV,Ni58_cs_10_24_10keV,'linewidth',1.0,'Color','black'); axis tight;

set(gca,'TickLength',[0.015 0.015]);
ylim([0 12]);
ylabel('d^2\sigma/d\OmegadE (mb / sr MeV)','FontSize',12);
xlabel('Excitation energy (MeV)','FontSize',14);
title('Max 40Ca(p,p\prime)   E_{Lab} = 200 MeV');



% 42Ca extraction Retief

fname='58Ni_ExCs_10_24_10kev.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

%ex_8_26_10keV(1:1801)=ex_src(1:1801); % Excitation energy 8-26 MeV in 10 keV steps  
Ni58_cs_10_24_10keV(1:1400)=cnts_src(1:1400); % Retief 42Ca(p,p') cross-section (mb/sr MeV)


figure (100);
subplot(4,1,3); stairs(ex_10_24_10keV,Ni58_cs_10_24_10keV,'linewidth',1.0,'Color','black'); axis tight;

set(gca,'TickLength',[0.015 0.015]);
ylim([0 12]);
ylabel('d^2\sigma/d\OmegadE (mb / sr MeV)','FontSize',12);
%xlabel('Excitation energy (MeV)');
title('Retief 42Ca(p,p\prime)   E_{Lab} = 200 MeV');


% 44Ca extraction Retief

fname='58Ni_ExCs_10_24_10kev.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

%ex_8_26_10keV(1:1701)=ex_src(1:1701); % Excitation energy 8-26 MeV in 10 keV steps  
Ni58_cs_10_24_10keV(1:1400)=cnts_src(1:1400); % Retief 44Ca(p,p') cross-section (mb/sr MeV)


figure (100);
subplot(4,1,2); stairs(ex_10_24_10keV,Ni58_cs_10_24_10keV,'linewidth',1.0,'Color','black'); axis tight;

set(gca,'TickLength',[0.015 0.015]);
ylim([0 12]);
ylabel('d^2\sigma/d\OmegadE (mb / sr MeV)','FontSize',12);
%xlabel('Excitation energy (MeV)');
title('Retief 44Ca(p,p\prime)   E_{Lab} = 200 MeV');



% 48Ca new experiment extraction

fname='58Ni_ExCs_10_24_10kev.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

%ex_8_26_10keV(1:1701)=ex_src(1:1701); % Excitation energy 8-26 MeV in 10 keV steps  
Ni58_cs_10_24_10keV(1:1400)=cnts_src(1:1400); % Retief 48Ca(p,p') cross-section (mb/sr MeV)


figure (100);
subplot(4,1,1); stairs(ex_10_24_10keV,Ni58_cs_10_24_10keV,'linewidth',1.0,'Color','black'); axis tight;

set(gca,'TickLength',[0.015 0.015]);
ylim([0 12]);
ylabel('d^2\sigma/d\OmegadE (mb / sr MeV)','FontSize',12);
%xlabel('Excitation energy (MeV)','FontSize',14);
title('Retief 48Ca(p,p\prime)   E_{Lab} = 200 MeV');


%=========================================================================
% Display experimental dat E_X = 12 - 24 MeV
%
% 40Ca extraction Max

%fname='40Ca-cs-BkgSub_12-24MeV_10keV.dat'
fname='58Ni_ExCs_10_24_10kev.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_10_24_10keV(1:1400)=ex_src(1:1400); % Excitation energy 12-24 MeV in 10 keV steps  
%Ca40_cs_BkgSub_12_24_10keV(1:1400)=cnts_src(1:1400); % Max 40Ca(p,p') cross-section BkgSub(mb/sr MeV)
Ni58_cs_10_24_10keV(1:1400)=cnts_src(1:1400); % Max 40Ca(p,p') cross-section BkgSub(mb/sr MeV)


figure (105);
%subplot(4,2,2); stairs(ex_12_24_10keV,Ca40_cs_BkgSub_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
subplot(4,1,4); stairs(ex_10_24_10keV,Ni58_cs_10_24_10keV,'linewidth',1.8,'Color','black'); axis tight;

set(gca,'TickLength',[0.03 0.03]);
ylim([0 12]);
ylabel('d^2\sigma/d\OmegadE (mb / sr MeV)');
%xlabel('Excitation energy (MeV)');
title('Max 40Ca(p,p\prime)   E_{Lab} = 200 MeV');



% 42Ca extraction Retief

%fname='40Ca-cs-BkgSub_12-24MeV_10keV.dat'
fname='58Ni_ExCs_10_24_10kev.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

%ex_12_24_10keV(1:1400)=ex_src(1:1400); % Excitation energy 12-24 MeV in 10 keV steps  
%Ca40_cs_BkgSub_12_24_10keV(1:1400)=cnts_src(1:1400); % Max 40Ca(p,p') cross-section BkgSub(mb/sr MeV)
Ni58_cs_10_24_10keV(1:1400)=cnts_src(1:1400); % Max 40Ca(p,p') cross-section BkgSub(mb/sr MeV)


figure (105);
%subplot(4,2,2); stairs(ex_12_24_10keV,Ca40_cs_BkgSub_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
subplot(4,1,3); stairs(ex_10_24_10keV,Ni58_cs_10_24_10keV,'linewidth',1.8,'Color','black'); axis tight;

set(gca,'TickLength',[0.03 0.03]);
ylim([0 12]);
ylabel('d^2\sigma/d\OmegadE (mb / sr MeV)');
%xlabel('Excitation energy (MeV)');
title('Retief 42Ca(p,p\prime)   E_{Lab} = 200 MeV');


% 44Ca extraction Retief

%fname='40Ca-cs-BkgSub_12-24MeV_10keV.dat'
fname='58Ni_ExCs_10_24_10kev.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

%ex_12_24_10keV(1:1400)=ex_src(1:1400); % Excitation energy 12-24 MeV in 10 keV steps  
%Ca40_cs_BkgSub_12_24_10keV(1:1400)=cnts_src(1:1400); % Max 40Ca(p,p') cross-section BkgSub(mb/sr MeV)
Ni58_cs_10_24_10keV(1:1400)=cnts_src(1:1400); % Max 40Ca(p,p') cross-section BkgSub(mb/sr MeV)


figure (105);
%subplot(4,2,2); stairs(ex_12_24_10keV,Ca40_cs_BkgSub_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
subplot(4,1,2); stairs(ex_10_24_10keV,Ni58_cs_10_24_10keV,'linewidth',1.8,'Color','black'); axis tight;

set(gca,'TickLength',[0.03 0.03]);
ylim([0 12]);
ylabel('d^2\sigma/d\OmegadE (mb / sr MeV)');
%xlabel('Excitation energy (MeV)');
title('Retief 44Ca(p,p\prime)   E_{Lab} = 200 MeV');



% 48Ca new experiment extraction

fname='58Ni_ExCs_10_24_10kev.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

%ex_12_24_10keV(1:1400)=ex_src(1:1400); % Excitation energy 12-24 MeV in 10 keV steps  
Ni58_cs_10_24_10keV(1:1400)=cnts_src(1:1400); % Retief 48Ca(p,p') cross-section (mb/sr MeV)


figure (105);
subplot(4,1,1); stairs(ex_10_24_10keV,Ni58_cs_10_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 12]);
ylabel('d^2\sigma/d\OmegadE (mb / sr MeV)');
xlabel('Excitation energy (MeV)');
title('Retief 48Ca(p,p\prime)   E_{Lab} = 200 MeV');
















%=========================================================================
% 40Ca extraction Max

%fname='40Ca-cs-BkgSub_12-24MeV_10keV.dat'
fname='58Ni_ExCs_10_24_10kev.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_10_24_10keV(1:1400)=ex_src(1:1400); % Excitation energy 12-24 MeV in 10 keV steps  
%Ca40_cs_BkgSub_12_24_10keV(1:1400)=cnts_src(1:1400); % Max 40Ca(p,p') cross-section BkgSub(mb/sr MeV)
Ni58_cs_10_24_10keV(1:1400)=cnts_src(1:1400); % Max 40Ca(p,p') cross-section BkgSub(mb/sr MeV)


figure (120);
%subplot(4,2,2); stairs(ex_12_24_10keV,Ca40_cs_BkgSub_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
subplot(4,2,2); stairs(ex_10_24_10keV,Ni58_cs_10_24_10keV,'linewidth',1.8,'Color','black'); axis tight;

set(gca,'TickLength',[0.03 0.03]);
ylim([0 12]);
ylabel('d^2\sigma/d\OmegadE (mb / sr MeV)');
%xlabel('Excitation energy (MeV)');
title('Max 40Ca(p,p\prime) E_{Lab} = 200 MeV');



%==========================================================================
%y1=Ca40_cs_BkgSub_12_24_10keV; % Max 40Ca(p,p') cross-section BkgSub(mb/sr MeV)
y1=Ni58_cs_10_24_10keV; % Max 40Ca(p,p') cross-section BkgSub(mb/sr MeV)
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

%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% 40Ca composite

figure (300);
subplot(4,2,2); stairs(ex_10_24_10keV,Ni58_cs_10_24_10keV,'linewidth',1.8,'Color','black'); axis tight;

set(gca,'TickLength',[0.03 0.03]);
ylim([0 12]);
ylabel('d^2\sigma/d\OmegadE (mb / sr MeV)');
%xlabel('Excitation energy (MeV)');
title('Max 40Ca(p,p\prime) E_{Lab} = 200 MeV');
hold on;

projy1cmx_max=max(projy1cmx);
subplot(4,2,7); semilogx(scalenorm,projy1cmx/projy1cmx_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power (a.u.)')
title('40Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

projy1cmEx_max=max(projy1cmEx);
subplot(4,2,5); semilogx(scalenorm,projy1cmEx/projy1cmEx_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power / scale (a.u.)')
title('40Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

projy1cm2Ex_max=max(projy1cm2Ex);
subplot(4,2,3); semilogx(scalenorm,projy1cm2Ex/projy1cm2Ex_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power^2 / scale (a.u.)')
title('40Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% 40Ca composite

figure (320);
subplot(4,2,2); stairs(ex_10_24_10keV,Ni58_cs_10_24_10keV,'linewidth',1.8,'Color','black'); axis tight;

set(gca,'TickLength',[0.03 0.03]);
ylim([0 12]);
ylabel('d^2\sigma/d\OmegadE (mb / sr MeV)');
%xlabel('Excitation energy (MeV)');
title('Max 40Ca(p,p\prime) E_{Lab} = 200 MeV');
hold on;

projy1cmx_max=max(projy1cmx);
subplot(4,2,7); semilogx(scalenorm,projy1cmx/projy1cmx_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power (a.u.)')
title('40Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

projy1cmEx_max=max(projy1cmEx);
subplot(4,2,5); semilogx(scalenorm,projy1cmEx/projy1cmEx_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power / scale (a.u.)')
title('40Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

projy1cm2Ex_max=max(projy1cm2Ex);
subplot(4,2,3); semilogx(scalenorm,projy1cm2Ex/projy1cm2Ex_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power^2 / scale (a.u.)')
title('40Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


%=========================================================================
% 48Ca new experiment extraction

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
% 48Ca composite

figure (310);
subplot(4,2,2); stairs(ex_10_24_10keV,Ni58_cs_10_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 12]);
ylabel('d^2\sigma/d\OmegadE (mb / sr MeV)');
%xlabel('Excitation energy (MeV)');
title('Retief 48Ca(p,p\prime)   E_{Lab} = 200 MeV');
hold on;

projy1cmx_max=max(projy1cmx);
subplot(4,2,7); semilogx(scalenorm,projy1cmx/projy1cmx_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power (a.u.)')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

projy1cmEx_max=max(projy1cmEx);
subplot(4,2,5); semilogx(scalenorm,projy1cmEx/projy1cmEx_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power / scale (a.u.)')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

projy1cm2Ex_max=max(projy1cm2Ex);
subplot(4,2,3); semilogx(scalenorm,projy1cm2Ex/projy1cm2Ex_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power^2 / scale (a.u.)')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% 48Ca composite

figure (312); % Alter power spectrum normalise to scale at 1.5 MeV

subplot(4,2,2); stairs(ex_10_24_10keV,Ni58_cs_10_24_10keV,'linewidth',0.25,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 12]);
ylabel('d^2\sigma/d\OmegadE (mb / sr MeV)');
%xlabel('Excitation energy (MeV)');
title('Retief 48Ca(p,p\prime)   E_{Lab} = 200 MeV');
hold on;

projy1cmx_max=max(projy1cmx);
%subplot(4,2,7); semilogx(scalenorm,projy1cmx/projy1cmx_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
subplot(4,2,7); semilogx(scalenorm,projy1cmx*1e3,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 13e6]);
set(gca,'TickLength',[0.03 0.03]);
xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power')
title('   48Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

projy1cmEx_max=max(projy1cmEx);
%subplot(4,2,5); semilogx(scalenorm,projy1cmEx/projy1cmEx_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
subplot(4,2,5); semilogx(scalenorm,projy1cmEx*1e3,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 7e3]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power / scale')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

projy1cm2Ex_max=max(projy1cm2Ex);
%subplot(4,2,3); semilogx(scalenorm,projy1cm2Ex/projy1cm2Ex_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
%subplot(4,2,3); semilogx(scalenorm,projy1cm2Ex/1e4,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 5]);
subplot(4,2,3); semilogx(scalenorm,sqrt(projy1cmx/1e3)*1e3,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 3.8e3]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
%ylabel('Power^2 / scale')
ylabel('Power^{1/2}')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

projy1cm2Ex_max=max(projy1cm2Ex);
%subplot(4,2,3); semilogx(scalenorm,projy1cm2Ex/projy1cm2Ex_max,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 1.2]);
%subplot(4,2,3); semilogx(scalenorm,projy1cm2Ex/1e4,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 5]);
subplot(4,2,1); semilogx(scalenorm,projy1cmsqEx*1e3,'linewidth',1.8,'color','black'), axis([40 nscales*binsize 0 10]);
set(gca,'TickLength',[0.03 0.03]);
%xlabel('Fourier [= Complex Morlet] Scale (keV)');
%ylabel('Power^2 / scale')
ylabel('Power^{1/2} / scale')
title('48Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;



%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

















set(gca,'YTick',0:1000:3000,...
    'YTickLabel',0:1000:3000,...
    'YMinorTick','on',...
    'FontWeight','normal',...
    'FontSize', 8,...
    'XTickLabel',10:2:20,...
    'XTick',10:2:20,...
    'XMinorTick','on',...
    'TickLength',[0.02 0.05]);






