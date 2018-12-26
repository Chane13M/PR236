% +============================================================================+
% |   SUBROUTINE GaussFold (NMax, E, Y, YSmooth, FWHM, NChs)                   |
% +============================================================================+
% |   E           (read)  :  Array containing the abscissa values              |
% |   Y           (read)  :  Array containing the unsmoothed ordinate values   |
% |   YSmooth     (write) :  Array containing the smoothed ordinate values     |
% |   FWHM        (read)  :  Full width half maximum of folding width          |
% |   NChS        (read)  :  Number of channels contributing by smoothing      |
% +----------------------------------------------------------------------------+
% |   Purpose: Folds values of channel contents Y with a Gaussian distribution |
% |            of the full width at half maximum FWHM.                         |
% +----------------------------------------------------------------------------+
% |   Author : F. Neumeyer (in Fortran)                                        |
% |   Date   : 11-Apr-1997                                                     |
% |   Author : Y. Kalmykov (in Matlab 6.5)                                     | 
% |   Date   : 26-Jan-2004                                                     | 
% +============================================================================+

function sm = gaussfold(e, y, fwhm, nchs)

pi = 3.1415926;
smallest = 0.000000000001;
nmax = length(e); 

%     +----------------------+
%     |  Clear output field  |
%     +----------------------+

for ii = 1:nmax
    ysmooth(ii) = 0.0;
end

%     +------------------------------------------------------------+
%     |  Set number of channels contributing to smoothed spectrum  |
%     +------------------------------------------------------------+

nsmooth = nchs;

%     +-------------------------------------+
%     |  Calculate Sigma of Gauss-function  |
%     +-------------------------------------+

sigma = fwhm / (sqrt(8.0 * log(2.0)));

%     +---------------------+
%     |  Folding procedure  |
%     +---------------------+

for ii = (nsmooth + 1): (nmax - nsmooth)
    gssn = 0.0;
    x0 = e(ii);
    for kk = (ii - nsmooth):(ii + nsmooth)
        x = e(kk);
        tgss = 1.0 / sqrt(2.0*pi*sigma) * exp(-(x-x0)^2 / (2.0*sigma^2));
        gssn = gssn + tgss * y(ii);
    end
    if (y(ii) == 0.0) 
        gssn = 0.0;
    else
        gssn = gssn / y(ii); 
    end
    for jj = (ii - nsmooth):(ii + nsmooth)
        x = e(jj);
        gss = 1.0 / sqrt(2.0*pi*sigma) * exp(-(x-x0)^2 / (2.0*sigma^2));
        if (gssn == 0.0)
            ysmooth(jj) = ysmooth(jj); 
        else
            ysmooth(jj) = ysmooth(jj) + gss * y(ii) / gssn;
        end
    end
end

%     +---------------------------------+
%     |  Set numbers < Smallest to 0.0  |
%     +---------------------------------+

for ii = 1:nmax
    if (abs(ysmooth(ii)) < smallest)
        ysmooth(ii) = smallest;
    end
end
sm = ysmooth;
return


