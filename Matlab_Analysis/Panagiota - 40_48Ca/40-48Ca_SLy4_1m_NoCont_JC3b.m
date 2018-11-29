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


%=========================================================================
% Display experimental dat E_X = 8 - 26 MeV
%
% 40Ca extraction Max

fname='40Ca-cs-8_26MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_8_26_10keV(1:1801)=ex_src(1:1801); % Excitation energy 8-26 MeV in 10 keV steps  
Ca40_cs_8_26_10keV(1:1801)=cnts_src(1:1801); % Max 40Ca(p,p') cross-section (mb/sr MeV)


figure (700);
subplot(4,2,7); stairs(ex_8_26_10keV,Ca40_cs_8_26_10keV,'linewidth',0.25,'Color','black'); axis tight;

set(gca,'TickLength',[0.015 0.015]);
ylim([0 12]);
ylabel('d^2\sigma/d\OmegadE (mb / sr MeV)','FontSize',12);
xlabel('Excitation energy (MeV)','FontSize',14);
title('Max 40Ca(p,p\prime)');



% 42Ca extraction Retief

fname='42Ca-cs-8_26MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

%ex_8_26_10keV(1:1801)=ex_src(1:1801); % Excitation energy 8-26 MeV in 10 keV steps  
Ca42_cs_8_26_10keV(1:1801)=cnts_src(1:1801); % Retief 42Ca(p,p') cross-section (mb/sr MeV)


figure (700);
subplot(4,2,5); stairs(ex_8_26_10keV,Ca42_cs_8_26_10keV,'linewidth',0.25,'Color','black'); axis tight;

set(gca,'TickLength',[0.015 0.015]);
ylim([0 12]);
ylabel('d^2\sigma/d\OmegadE (mb / sr MeV)','FontSize',12);
%xlabel('Excitation energy (MeV)');
title('Retief 42Ca(p,p\prime)');


% 44Ca extraction Retief

fname='44Ca-cs-8_26MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

%ex_8_26_10keV(1:1701)=ex_src(1:1701); % Excitation energy 8-26 MeV in 10 keV steps  
Ca44_cs_8_26_10keV(1:1801)=cnts_src(1:1801); % Retief 44Ca(p,p') cross-section (mb/sr MeV)


figure (700);
subplot(4,2,3); stairs(ex_8_26_10keV,Ca44_cs_8_26_10keV,'linewidth',0.25,'Color','black'); axis tight;

set(gca,'TickLength',[0.015 0.015]);
ylim([0 12]);
ylabel('d^2\sigma/d\OmegadE (mb / sr MeV)','FontSize',12);
%xlabel('Excitation energy (MeV)');
title('Retief 44Ca(p,p\prime)');



% 48Ca new experiment extraction

fname='48Ca-cs-8_26MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

%ex_8_26_10keV(1:1701)=ex_src(1:1701); % Excitation energy 8-26 MeV in 10 keV steps  
Ca48_cs_8_26_10keV(1:1801)=cnts_src(1:1801); % Retief 48Ca(p,p') cross-section (mb/sr MeV)


figure (700);
subplot(4,2,1); stairs(ex_8_26_10keV,Ca48_cs_8_26_10keV,'linewidth',0.25,'Color','black'); axis tight;

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
fname='40Ca-cs_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
%Ca40_cs_BkgSub_12_24_10keV(1:1201)=cnts_src(1:1201); % Max 40Ca(p,p') cross-section BkgSub(mb/sr MeV)
Ca40_cs_12_24_10keV(1:1201)=cnts_src(1:1201); % Max 40Ca(p,p') cross-section BkgSub(mb/sr MeV)


figure (700);
%subplot(4,2,2); stairs(ex_12_24_10keV,Ca40_cs_BkgSub_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
subplot(4,2,8); stairs(ex_12_24_10keV,Ca40_cs_12_24_10keV,'linewidth',0.25,'Color','black'); axis tight;

set(gca,'TickLength',[0.03 0.03]);
ylim([0 12]);
ylabel('d^2\sigma/d\OmegadE (mb / sr MeV)','FontSize',12);
xlabel('Excitation energy (MeV)','FontSize',14);
title('Max 40Ca(p,p\prime)');



% 42Ca extraction Retief

%fname='40Ca-cs-BkgSub_12-24MeV_10keV.dat'
fname='42Ca-cs_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

%ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
%Ca40_cs_BkgSub_12_24_10keV(1:1201)=cnts_src(1:1201); % Max 40Ca(p,p') cross-section BkgSub(mb/sr MeV)
Ca42_cs_12_24_10keV(1:1201)=cnts_src(1:1201); % Max 40Ca(p,p') cross-section BkgSub(mb/sr MeV)


figure (700);
%subplot(4,2,2); stairs(ex_12_24_10keV,Ca40_cs_BkgSub_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
subplot(4,2,6); stairs(ex_12_24_10keV,Ca42_cs_12_24_10keV,'linewidth',0.25,'Color','black'); axis tight;

set(gca,'TickLength',[0.03 0.03]);
ylim([0 12]);
ylabel('d^2\sigma/d\OmegadE (mb / sr MeV)','FontSize',12);
%xlabel('Excitation energy (MeV)');
title('Retief 42Ca(p,p\prime)');


% 44Ca extraction Retief

%fname='40Ca-cs-BkgSub_12-24MeV_10keV.dat'
fname='44Ca-cs_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

%ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
%Ca40_cs_BkgSub_12_24_10keV(1:1201)=cnts_src(1:1201); % Max 40Ca(p,p') cross-section BkgSub(mb/sr MeV)
Ca44_cs_12_24_10keV(1:1201)=cnts_src(1:1201); % Max 40Ca(p,p') cross-section BkgSub(mb/sr MeV)


figure (700);
%subplot(4,2,2); stairs(ex_12_24_10keV,Ca40_cs_BkgSub_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
subplot(4,2,4); stairs(ex_12_24_10keV,Ca44_cs_12_24_10keV,'linewidth',0.25,'Color','black'); axis tight;

set(gca,'TickLength',[0.03 0.03]);
ylim([0 12]);
ylabel('d^2\sigma/d\OmegadE (mb / sr MeV)','FontSize',12);
%xlabel('Excitation energy (MeV)');
title('Retief 44Ca(p,p\prime)');



% 48Ca new experiment extraction

fname='48Ca-cs-12_24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

%ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
Ca48_cs_12_24_10keV(1:1201)=cnts_src(1:1201); % Retief 48Ca(p,p') cross-section (mb/sr MeV)


figure (700);
subplot(4,2,2); stairs(ex_12_24_10keV,Ca48_cs_12_24_10keV,'linewidth',0.25,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 12]);
ylabel('d^2\sigma/d\OmegadE (mb / sr MeV)','FontSize',12);
%xlabel('Excitation energy (MeV)');
title('Retief 48Ca(p,p\prime)   E_{Lab} = 200 MeV');

%=========================================================================



%=========================================================================
% Display experimental dat E_X = 12 - 24 MeV
% 
% 40Ca extraction Max

%fname='40Ca-cs-BkgSub_12-24MeV_10keV.dat'
fname='40Ca-cs_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
%Ca40_cs_BkgSub_12_24_10keV(1:1201)=cnts_src(1:1201); % Max 40Ca(p,p') cross-section BkgSub(mb/sr MeV)
Ca40_cs_12_24_10keV(1:1201)=cnts_src(1:1201); % Max 40Ca(p,p') cross-section BkgSub(mb/sr MeV)


figure (700);
%subplot(4,2,2); stairs(ex_12_24_10keV,Ca40_cs_BkgSub_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
subplot(4,2,8); stairs(ex_12_24_10keV,Ca40_cs_12_24_10keV,'linewidth',0.25,'Color','black'); axis tight;

set(gca,'TickLength',[0.03 0.03]);
ylim([0 12]);
ylabel('d^2\sigma/d\OmegadE (mb / sr MeV)','FontSize',12);
xlabel('Excitation energy (MeV)','FontSize',14);
title('Max 40Ca(p,p\prime)');



% 42Ca extraction Retief

%fname='40Ca-cs-BkgSub_12-24MeV_10keV.dat'
fname='42Ca-cs_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

%ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
%Ca40_cs_BkgSub_12_24_10keV(1:1201)=cnts_src(1:1201); % Max 40Ca(p,p') cross-section BkgSub(mb/sr MeV)
Ca42_cs_12_24_10keV(1:1201)=cnts_src(1:1201); % Max 40Ca(p,p') cross-section BkgSub(mb/sr MeV)


figure (700);
%subplot(4,2,2); stairs(ex_12_24_10keV,Ca40_cs_BkgSub_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
subplot(4,2,6); stairs(ex_12_24_10keV,Ca42_cs_12_24_10keV,'linewidth',0.25,'Color','black'); axis tight;

set(gca,'TickLength',[0.03 0.03]);
ylim([0 12]);
ylabel('d^2\sigma/d\OmegadE (mb / sr MeV)','FontSize',12);
%xlabel('Excitation energy (MeV)');
title('Retief 42Ca(p,p\prime)');


% 44Ca extraction Retief

%fname='40Ca-cs-BkgSub_12-24MeV_10keV.dat'
fname='44Ca-cs_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

%ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
%Ca40_cs_BkgSub_12_24_10keV(1:1201)=cnts_src(1:1201); % Max 40Ca(p,p') cross-section BkgSub(mb/sr MeV)
Ca44_cs_12_24_10keV(1:1201)=cnts_src(1:1201); % Max 40Ca(p,p') cross-section BkgSub(mb/sr MeV)


figure (700);
%subplot(4,2,2); stairs(ex_12_24_10keV,Ca40_cs_BkgSub_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
subplot(4,2,4); stairs(ex_12_24_10keV,Ca44_cs_12_24_10keV,'linewidth',0.25,'Color','black'); axis tight;

set(gca,'TickLength',[0.03 0.03]);
ylim([0 12]);
ylabel('d^2\sigma/d\OmegadE (mb / sr MeV)','FontSize',12);
%xlabel('Excitation energy (MeV)');
title('Retief 44Ca(p,p\prime)');



% 48Ca new experiment extraction

fname='48Ca-cs-12_24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

%ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
Ca48_cs_12_24_10keV(1:1201)=cnts_src(1:1201); % Retief 48Ca(p,p') cross-section (mb/sr MeV)


figure (700);
subplot(4,2,2); stairs(ex_12_24_10keV,Ca48_cs_12_24_10keV,'linewidth',0.25,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 12]);
ylabel('d^2\sigma/d\OmegadE (mb / sr MeV)','FontSize',12);
%xlabel('Excitation energy (MeV)');
title('Retief 48Ca(p,p\prime)   E_{Lab} = 200 MeV');

%=========================================================================

% Use virtual1_40Ca_R1.2_Rs0_1.9deg_10keV.dat for 40,42,44,48Ca

%=========================================================================
% Display experimental data E_X = 12 - 24 MeV
% Divide by virtual gamma production and multiply by E_x


% 48Ca new experiment extraction

fname='48Ca-cs-12_24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column
 
Ca48_cs_12_24_10keV(1:1201)=cnts_src(1:1201); % Retief 48Ca(p,p') cross-section (mb/sr MeV)


figure (730);
subplot(4,2,1); stairs(ex_12_24_10keV,Ca48_cs_12_24_10keV,'linewidth',0.25,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 12]);
ylabel('d^2\sigma/d\OmegadE (mb / sr MeV)','FontSize',12);
%xlabel('Excitation energy (MeV)');
title('Retief 48Ca(p,p\prime)   E_{Lab} = 200 MeV');
hold on;

fname='virtual1_40Ca_R1.2_Rs0_1.9deg_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column
 
Ca48_V1_12_24_10keV(1:1201)=cnts_src(1:1201); % Virtual 1 40Ca

for x=1:301
    Ca48_Bk(x)=1.4-0.1*x/301;    
    Ca48_Eg_12_24_10keV(x)=(Ca48_cs_12_24_10keV(x)-Ca48_Bk(x))*ex_12_24_10keV(x)/Ca48_V1_12_24_10keV(x);
end

for x=301:801
    Ca48_Bk(x)=1.3+1.7*(x-301)/500;    
    Ca48_Eg_12_24_10keV(x)=(Ca48_cs_12_24_10keV(x)-Ca48_Bk(x))*ex_12_24_10keV(x)/Ca48_V1_12_24_10keV(x);
end

for x=801:1201
    Ca48_Bk(x)=3.0-0.4*(x-801)/400;    
    Ca48_Eg_12_24_10keV(x)=(Ca48_cs_12_24_10keV(x)-Ca48_Bk(x))*ex_12_24_10keV(x)/Ca48_V1_12_24_10keV(x);
end

% Mathworks Demo code from their Help
% x = 0:10;
% y = sin(x);
% xx = 0:.25:10;
% yy = spline(x,y,xx);
% plot(x,y,'o',xx,yy)

ex_12_24_1keV=12:0.001:24;
Ca48_Bks=spline(ex_12_24_10keV,Ca48_Bk,ex_12_24_1keV);

%subplot(4,2,1); stairs(ex_12_24_10keV,Ca48_Bk,'linewidth',1.8,'Color','blue'); axis tight;
subplot(4,2,1); plot(ex_12_24_1keV,Ca48_Bks,'linewidth',1.8,'Color','blue'); axis tight;
ylim([0 12]);

figure (730);
subplot(4,2,2); stairs(ex_12_24_10keV,Ca48_Eg_12_24_10keV*0.7,'linewidth',0.25,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 150]);
xlim([12 24]);
ylabel('\sigma (mb)','FontSize',12);
%xlabel('Excitation energy (MeV)');
title('Retief 48Ca - equiv. gamma');
hold on;

%fname='48Ca(g_abs)_OKeefe NPA469(1987)239.dat'
%fname='48Ca(g_n)_OKeefe NPA469(1987)239.dat'
fname='48Ca_sigma_abs_RCNP.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

Ca48_Ga=cnts_src; % O'Keefe 48Ca(g,abs)
ex_Ca48_Ga=ex_src;

%subplot(4,2,2); plot(ex_Ca48_Ga,Ca48_Ga,'linewidth',1.5,'Color','red'); axis tight;
subplot(4,2,2); scatter(ex_Ca48_Ga,Ca48_Ga,35,[1 0 0],'filled'); axis tight;
ylim([0 150]);
xlim([12 24]);
hold off;


% 44Ca extraction Retief

fname='44Ca-cs_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

Ca44_cs_12_24_10keV(1:1201)=cnts_src(1:1201); % Retief 44Ca(p,p') cross-section (mb/sr MeV)


figure (730);

subplot(4,2,3); stairs(ex_12_24_10keV,Ca44_cs_12_24_10keV+1.0,'linewidth',0.25,'Color','black'); axis tight;

set(gca,'TickLength',[0.03 0.03]);
ylim([0 12]);
ylabel('d^2\sigma/d\OmegadE (mb / sr MeV)','FontSize',12);
%xlabel('Excitation energy (MeV)');
title('Retief 44Ca(p,p\prime)  + 1.0 (mb / sr MeV)');
hold on;

%subplot(4,2,3); stairs(ex_12_24_10keV,Ca48_Bk,'linewidth',1.8,'Color','blue'); axis tight;
subplot(4,2,3); plot(ex_12_24_1keV,Ca48_Bks,'linewidth',1.8,'Color','blue'); axis tight;
ylim([0 12]);

for x=1:1201
    Ca44_Eg_12_24_10keV(x)=(Ca44_cs_12_24_10keV(x)+1.0-Ca48_Bk(x))*ex_12_24_10keV(x)/Ca48_V1_12_24_10keV(x);
end

subplot(4,2,1); stairs(ex_12_24_10keV,Ca48_Bk,'linewidth',1.8,'Color','blue'); axis tight;
ylim([0 12]);

figure (730);
subplot(4,2,4); stairs(ex_12_24_10keV,Ca44_Eg_12_24_10keV*0.7,'linewidth',0.25,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 150]);
ylabel('\sigma (mb)','FontSize',12);
%xlabel('Excitation energy (MeV)');
title('Retief 44Ca - equiv. gamma');



% 42Ca extraction Retief

fname='42Ca-cs_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

Ca42_cs_12_24_10keV(1:1201)=cnts_src(1:1201); % Retief 42Ca(p,p') cross-section (mb/sr MeV)


figure (730);

subplot(4,2,5); stairs(ex_12_24_10keV,Ca42_cs_12_24_10keV,'linewidth',0.25,'Color','black'); axis tight;

set(gca,'TickLength',[0.03 0.03]);
ylim([0 12]);
ylabel('d^2\sigma/d\OmegadE (mb / sr MeV)','FontSize',12);
%xlabel('Excitation energy (MeV)');
title('Retief 42Ca(p,p\prime)');
hold on;

%subplot(4,2,5); stairs(ex_12_24_10keV,Ca48_Bk,'linewidth',1.8,'Color','blue'); axis tight;
subplot(4,2,5); plot(ex_12_24_1keV,Ca48_Bks,'linewidth',1.8,'Color','blue'); axis tight;
ylim([0 12]);

for x=1:1201
    Ca42_Eg_12_24_10keV(x)=(Ca42_cs_12_24_10keV(x)-Ca48_Bk(x))*ex_12_24_10keV(x)/Ca48_V1_12_24_10keV(x);
end

figure (730);
subplot(4,2,6); stairs(ex_12_24_10keV,Ca42_Eg_12_24_10keV*0.7,'linewidth',0.25,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 150]);
ylabel('\sigma (mb)','FontSize',12);
%xlabel('Excitation energy (MeV)');
title('Retief 42Ca - equiv. gamma');



% 40Ca extraction Max

fname='40Ca-cs_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column
 
Ca40_cs_12_24_10keV(1:1201)=cnts_src(1:1201); % Max 40Ca(p,p') cross-section


figure (730);
subplot(4,2,7); stairs(ex_12_24_10keV,Ca40_cs_12_24_10keV+2.0,'linewidth',0.25,'Color','black'); axis tight;

set(gca,'TickLength',[0.03 0.03]);
ylim([0 12]);
ylabel('d^2\sigma/d\OmegadE (mb / sr MeV)','FontSize',12);
xlabel('Excitation energy (MeV)','FontSize',14);
title('Max 40Ca(p,p\prime)  + 2.0 (mb / sr MeV)');
hold on;

%subplot(4,2,7); stairs(ex_12_24_10keV,Ca48_Bk,'linewidth',1.8,'Color','blue'); axis tight;
subplot(4,2,7); plot(ex_12_24_1keV,Ca48_Bks,'linewidth',1.8,'Color','blue'); axis tight;
ylim([0 12]);

for x=1:1201
%    Ca48_Bk(x)=1.0+x*(1/1201);
    Ca40_Eg_12_24_10keV(x)=(Ca40_cs_12_24_10keV(x)+2.0-Ca48_Bk(x))*ex_12_24_10keV(x)/Ca48_V1_12_24_10keV(x);
end

figure (730);
subplot(4,2,8); stairs(ex_12_24_10keV,Ca40_Eg_12_24_10keV*0.7,'linewidth',0.25,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 150]);
ylabel('\sigma (mb)','FontSize',12);
xlabel('Excitation energy (MeV)','FontSize',14);
title('Max 40Ca - equiv. gamma');



%========================================================================














%=========================================================================
% 40Ca extraction Max

%fname='40Ca-cs-BkgSub_12-24MeV_10keV.dat'
fname='40Ca-cs_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
%Ca40_cs_BkgSub_12_24_10keV(1:1201)=cnts_src(1:1201); % Max 40Ca(p,p') cross-section BkgSub(mb/sr MeV)
Ca40_cs_12_24_10keV(1:1201)=cnts_src(1:1201); % Max 40Ca(p,p') cross-section BkgSub(mb/sr MeV)


figure (120);
%subplot(4,2,2); stairs(ex_12_24_10keV,Ca40_cs_BkgSub_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
subplot(4,2,2); stairs(ex_12_24_10keV,Ca40_cs_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;

set(gca,'TickLength',[0.03 0.03]);
ylim([0 12]);
ylabel('d^2\sigma/d\OmegadE (mb / sr MeV)');
%xlabel('Excitation energy (MeV)');
title('Max 40Ca(p,p\prime) E_{Lab} = 200 MeV');



%==========================================================================
%y1=Ca40_cs_BkgSub_12_24_10keV; % Max 40Ca(p,p') cross-section BkgSub(mb/sr MeV)
y1=Ca40_cs_12_24_10keV; % Max 40Ca(p,p') cross-section BkgSub(mb/sr MeV)
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
m1=mean(y1(:)); y1=y1-1*m1; 
nscales=round(abs(nscales));
c1=cwt(y1,1:nscales,'cmor1-1'); 


subplot(4,2,4); imagesc(xmev2,[scale_min scale_max],real(c1)); axis xy; axis tight;
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


projy1cmx(1:nscales)=0.; % Retief 48Ca(p,p') cross-section (mb/sr MeV) 

exbin_min=1;    % E_x(min) = 12.0 MeV 
exbin_max=1201; % E_x(max) = 24.0 MeV

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
subplot(4,2,2); stairs(ex_12_24_10keV,Ca40_cs_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;

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
subplot(4,2,2); stairs(ex_12_24_10keV,Ca40_cs_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;

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

fname='48Ca-cs-12_24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

%ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
Ca48_cs_12_24_10keV(1:1201)=cnts_src(1:1201); % Retief 48Ca(p,p') cross-section (mb/sr MeV)


figure (130);
subplot(4,2,2); stairs(ex_12_24_10keV,Ca48_cs_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 12]);
ylabel('d^2\sigma/d\OmegadE (mb / sr MeV)');
%xlabel('Excitation energy (MeV)');
title('Retief 48Ca(p,p\prime)   E_{Lab} = 200 MeV');



%==========================================================================
y1=Ca48_cs_12_24_10keV; % Retief 48Ca(p,p') cross-section (mb/sr MeV)
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
m1=mean(y1(:)); y1=y1-1*m1; 
nscales=round(abs(nscales));
c1=cwt(y1,1:nscales,'cmor1-1'); 


subplot(4,2,4); imagesc(xmev2,[scale_min scale_max],real(c1)); axis xy; axis tight;
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


projy1cmx(1:nscales)=0.; % Retief 48Ca(p,p') cross-section (mb/sr MeV) 

exbin_min=1;    % E_x(min) = 12.0 MeV 
exbin_max=1201; % E_x(max) = 24.0 MeV

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
subplot(4,2,2); stairs(ex_12_24_10keV,Ca48_cs_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
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

figure (330);
subplot(4,2,2); stairs(ex_12_24_10keV,Ca48_cs_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
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

% <===



%==========================================================================

% Load Ca40 R(Q)TBA B(E1)

fname='40ca-tba-d20_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
Ca40_TBA_12_24_10keV(1:1201)=cnts_src(1:1201); % 40Ca R(Q)TBA B(E1)


figure (150);
subplot(4,2,2); plot(ex_12_24_10keV,Ca40_TBA_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 60]);
ylabel('B(E1) (e^2fm^2 / MeV)');
%xlabel('Excitation energy (MeV)');
title('40Ca R(Q)TBA B(E1)');



%==========================================================================
y1=Ca40_TBA_12_24_10keV; % 40Ca R(Q)TBA B(E1)
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

% Load Ca40 R(Q)TBA B(E1)

fname='40ca-tba-d20_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
Ca40_TBA_12_24_10keV(1:1201)=cnts_src(1:1201); % 40Ca SLy4 R(Q)TBA B(E1)

% multiply B(E1) by E_x for comparison with photoabsorption spectrum
for x=1:1201;
    Ca40_TBAEx_12_24_10keV(x)=Ca40_TBA_12_24_10keV(x)*ex_12_24_10keV(x);
end


subplot(4,2,6); plot(ex_12_24_10keV,Ca40_TBAEx_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 850]);
ylabel('B(E1)*E_x (e^2fm^2)');
%xlabel('Excitation energy (MeV)');
title('40Ca R(Q)TBA B(E1)*E_x');



%==========================================================================
y1x=Ca40_TBAEx_12_24_10keV; % 40Ca R(Q)TBA B(E1)*E_x
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


projy1cmx(1:nscales)=0.; % 40Ca R(Q)TBA B(E1)        %       %  

exbin_min=1;    % E_x(min) = 12.0 MeV 
exbin_max=1201; % E_x(max) = 24.0 MeV

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

figure (320);

subplot(4,2,4); plot(ex_12_24_10keV,Ca40_TBAEx_12_24_10keV,'linewidth',1.8,'Color','red'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 850]);
ylabel('B(E1)*E_x (e^2fm^2)');
%xlabel('Excitation energy (MeV)');
title('40Ca R(Q)TBA B(E1)*E_x');
hold on;

projy1cmx_max=max(projy1cmx);
subplot(4,2,7); semilogx(scalenorm,projy1cmx/projy1cmx_max,'linewidth',1.8,'color','red'), axis([40 nscales*binsize 0 1.2]);
set(gca,'TickLength',[0.03 0.03]);
xlabel('Fourier [= Complex Morlet] Scale (keV)');
ylabel('Power (a.u.)')
title('40Ca IVGDR 12.0 < E_x < 24 MeV');
hold on;

projy1cmEx_max=max(projy1cmEx);
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

% Load Ca40 R(Q)RPA B(E1)

fname='40ca-rpa-d20_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
Ca40_RPA_12_24_10keV(1:1201)=cnts_src(1:1201); % 40Ca R(Q)RPA B(E1)


figure (160);
subplot(4,2,2); plot(ex_12_24_10keV,Ca40_RPA_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 60]);
ylabel('B(E1) (e^2fm^2 / MeV)');
%xlabel('Excitation energy (MeV)');
title('40Ca R(Q)RPA B(E1)');



%==========================================================================
y1=Ca40_RPA_12_24_10keV; % 40Ca R(Q)RPA B(E1)
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

% Load Ca40 R(Q)RPA B(E1)

fname='40ca-rpa-d20_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
Ca40_RPA_12_24_10keV(1:1201)=cnts_src(1:1201); % 40Ca SLy4 R(Q)TBA B(E1)

% multiply B(E1) by E_x for comparison with photoabsorption spectrum
for x=1:1201;
    Ca40_RPAEx_12_24_10keV(x)=Ca40_RPA_12_24_10keV(x)*ex_12_24_10keV(x);
end


subplot(4,2,6); plot(ex_12_24_10keV,Ca40_RPAEx_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 1100]);
ylabel('B(E1)*E_x (e^2fm^2)');
%xlabel('Excitation energy (MeV)');
title('40Ca R(Q)RPA B(E1)*E_x');



%==========================================================================
y1x=Ca40_RPAEx_12_24_10keV; % 40Ca R(Q)RPA B(E1)*E_x
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


projy1cmx(1:nscales)=0.; % 40Ca R(Q)TBA B(E1)        %       %  

exbin_min=1;    % E_x(min) = 12.0 MeV 
exbin_max=1201; % E_x(max) = 24.0 MeV

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

figure (320);

subplot(4,2,6); plot(ex_12_24_10keV,Ca40_RPAEx_12_24_10keV,'linewidth',1.8,'Color','blue'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 1100]);
ylabel('B(E1)*E_x (e^2fm^2)');
%xlabel('Excitation energy (MeV)');
title('40Ca R(Q)RPA B(E1)*E_x');
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



%==========================================================================

% Load Ca48 R(Q)TBA B(E1)

fname='48ca-tba-d20_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
Ca48_TBA_12_24_10keV(1:1201)=cnts_src(1:1201); % 48Ca R(Q)TBA B(E1)


figure (170);
subplot(4,2,2); plot(ex_12_24_10keV,Ca48_TBA_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 15]);
ylabel('B(E1) (e^2fm^2 / MeV)');
%xlabel('Excitation energy (MeV)');
title('48Ca R(Q)TBA B(E1)');



%==========================================================================
y1=Ca48_TBA_12_24_10keV; % 48Ca R(Q)TBA B(E1)
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

% Load Ca48 R(Q)TBA B(E1)

fname='48ca-tba-d20_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
Ca48_TBA_12_24_10keV(1:1201)=cnts_src(1:1201); % 48Ca SLy4 R(Q)TBA B(E1)

% multiply B(E1) by E_x for comparison with photoabsorption spectrum
for x=1:1201;
    Ca48_TBAEx_12_24_10keV(x)=Ca48_TBA_12_24_10keV(x)*ex_12_24_10keV(x);
end


subplot(4,2,6); plot(ex_12_24_10keV,Ca48_TBAEx_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 250]);
ylabel('B(E1)*E_x (e^2fm^2)');
%xlabel('Excitation energy (MeV)');
title('48Ca R(Q)TBA B(E1)*E_x');



%==========================================================================
y1x=Ca48_TBAEx_12_24_10keV; % 48Ca R(Q)TBA B(E1)*E_x
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


projy1cmx(1:nscales)=0.; % 48Ca R(Q)TBA B(E1)        %       %  

exbin_min=1;    % E_x(min) = 12.0 MeV 
exbin_max=1201; % E_x(max) = 24.0 MeV

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

figure (330);

subplot(4,2,4); plot(ex_12_24_10keV,Ca48_TBAEx_12_24_10keV,'linewidth',1.8,'Color','red'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 250]);
ylabel('B(E1)*E_x (e^2fm^2)');
%xlabel('Excitation energy (MeV)');
title('48Ca R(Q)TBA B(E1)*E_x');
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





%==========================================================================

% Load Ca48 R(Q)RPA B(E1)

fname='48ca-rpa-d20_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
Ca48_RPA_12_24_10keV(1:1201)=cnts_src(1:1201); % 48Ca R(Q)RPA B(E1)


figure (180);
subplot(4,2,2); plot(ex_12_24_10keV,Ca48_RPA_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 60]);
ylabel('B(E1) (e^2fm^2 / MeV)');
%xlabel('Excitation energy (MeV)');
title('48Ca R(Q)RPA B(E1)');



%==========================================================================
y1=Ca48_RPA_12_24_10keV; % 48Ca R(Q)RPA B(E1)
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

% Load Ca48 R(Q)RPA B(E1)

fname='48ca-rpa-d20_12-24MeV_10keV.dat'

[ex_src,fname_taken]=read_dat(fname,1); % take 1st column
[cnts_src,fname_taken]=read_dat(fname,2); % take 2nd column

ex_12_24_10keV(1:1201)=ex_src(1:1201); % Excitation energy 12-24 MeV in 10 keV steps  
Ca48_RPA_12_24_10keV(1:1201)=cnts_src(1:1201); % 48Ca SLy4 R(Q)TBA B(E1)

% multiply B(E1) by E_x for comparison with photoabsorption spectrum
for x=1:1201;
    Ca48_RPAEx_12_24_10keV(x)=Ca48_RPA_12_24_10keV(x)*ex_12_24_10keV(x);
end


subplot(4,2,6); plot(ex_12_24_10keV,Ca48_RPAEx_12_24_10keV,'linewidth',1.8,'Color','black'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 1100]);
ylabel('B(E1)*E_x (e^2fm^2)');
%xlabel('Excitation energy (MeV)');
title('48Ca R(Q)RPA B(E1)*E_x');



%==========================================================================
y1x=Ca48_RPAEx_12_24_10keV; % 48Ca R(Q)RPA B(E1)*E_x
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


projy1cmx(1:nscales)=0.; % 48Ca R(Q)TBA B(E1)        %       %  

exbin_min=1;    % E_x(min) = 12.0 MeV 
exbin_max=1201; % E_x(max) = 24.0 MeV

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

figure (330);

subplot(4,2,6); plot(ex_12_24_10keV,Ca48_RPAEx_12_24_10keV,'linewidth',1.8,'Color','blue'); axis tight;
set(gca,'TickLength',[0.03 0.03]);
ylim([0 1100]);
ylabel('B(E1)*E_x (e^2fm^2)');
%xlabel('Excitation energy (MeV)');
title('48Ca R(Q)RPA B(E1)*E_x');
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

















set(gca,'YTick',0:1000:3000,...
    'YTickLabel',0:1000:3000,...
    'YMinorTick','on',...
    'FontWeight','normal',...
    'FontSize', 8,...
    'XTickLabel',10:2:20,...
    'XTick',10:2:20,...
    'XMinorTick','on',...
    'TickLength',[0.02 0.05]);






