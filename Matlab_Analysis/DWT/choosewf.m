% get a name of a mother wavelet function
choicewf = menu('Mother Wavelet?',...
                'Haar',...
                'Gauss2','Mexican Hat','Gauss4',...
                'Morlet','Complex Morlet'...
                'bior2.8','bior3.9','bior6.8');
if (choicewf == 1)
	mwf='haar';
elseif (choicewf == 2)
	mwf='gaus2';
elseif (choicewf == 3)
	mwf='mexh';
elseif (choicewf == 4)
    mwf = 'gaus4';
elseif (choicewf == 5)
    mwf = 'morl';
elseif (choicewf == 6)
	mwf='bior2.8';
elseif (choicewf == 7)
	mwf='bior3.9';
elseif (choicewf == 8)
	mwf='bior6.8';
else
    fprintf(1,'\a');
end
% convert scales in bins into scales in MeV
fwhm_factor=set_mwf(mwf);
% clear postprocess variables if any
zvar = exist('zd2s');
if (zvar == 1)
    clear zexc zd2s zcoefs zproy zscale;
end
% disable postprocessing and enable CWT
set(pospb,'Enable','off');
zoomed = 0;
set(rcwtb,'String','Run/Plot');
cwtdone = 0;
% write commands to asci file
fprintf(outa,'%s\tselected\n', mwf);
