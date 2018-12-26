[mfname,mpname] = uiputfile('*.mat', 'Mat file to save?',200,200);
if (mfname ~= 0)
    mfpname = strcat(mpname,mfname);
    rawvar = exist('stored2s');
    if (rawvar == 1)
        save(mfpname,'stored2s','storeexc');
    end
    % preprocessed variables: signal
    ppvar = exist('d2s');
    if (ppvar == 1)
        save(mfpname,'exc','d2s','-append');
    end
    % postprocessed variables: input and output of CWT
    cwtvar = exist('coefs');
    if (cwtvar == 1)
        save(mfpname,'coefs','scale','proy','-append');
    end
    % zoomed input and output variables
    zvar = exist('zd2s');
    if (zvar == 1)
        save(mfpname,'zexc','zd2s','zcoefs','zscale','zproy','-append');
    end
%    fprintf(outa,'Variables are saved in %s\n',mfpname);
end