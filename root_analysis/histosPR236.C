#include <TH1.h>
#include <TH2.h>
#include <TCutG.h>

void histosPR236()
{

// TCanvas *MyCanvas = new TCanvas();
// gStyle->SetOptLogz(Int_t logz = 1);
// gStyle->SetOptLogy(Int_t logy = 0);
// gStyle->SetPalette(1,0);
// MyCanvas ->Divide(1,1);
// MyCanvas->cd(1);
// gPad->SetFillColor(0);

//gStyle->SetPalette(1,0);
//gStyle->SetOptStat(1110111);

// BASICS: Create 1 dimensional histograms
TH1F *hpr = new TH1F("hpr","Pattern Register",20,0.,20.);
TH1F *htof = new TH1F("htof","Time of Flight",1000,0.,5500.);
TH1F *hpad1 = new TH1F("hpad1","Paddle 1",700,100.,1500.);
TH1F *hpad2 = new TH1F("hpad2","Paddle 2",550,100.,1200.);
TH1F *hpad3 = new TH1F("hpad3","Paddle 3",1024,0.,4096.);

TH1F *hX1pos = new TH1F("hX1pos","X1 Position",4000,0.,800.);
TH1F *hX1th = new TH1F("hX1th","X1 Theta",300,20.,50.);
TH1F *hX1flag = new TH1F("hX1flag","X1 Flags",7,0.,7.);
TH1F *hX1chisq = new TH1F("hX1chisq","X1 Chi squared",1000,0.,1.);
TH1F *hX1res1 = new TH1F("hX1res1","X1 Resolution",320,-8.,8.);
TH1F *hX1eff = new TH1F("hX1eff","X1 Efficiency",100,0,100);
TH1F *hX1hits = new TH1F("hX1hits","X1 Hits",20,0.,20.);

TH1F *hU1pos = new TH1F("hU1pos","U1 Position",4000,0.,800.);
TH1F *hU1th = new TH1F("hU1th","U1 Theta",160,20.,60.);
TH1F *hU1flag = new TH1F("hU1flag","U1 Flags",7,0.,7.);
TH1F *hU1chisq = new TH1F("hU1chisq","U1 Chi squared",50,0.,50.);
TH1F *hU1res1 = new TH1F("hU1res1","U1 Resolution",320,-8.,8.);
TH1F *hU1eff = new TH1F("hU1eff","U1 Efficiency",100,-0.5,0.5);
TH1F *hU1hits = new TH1F("hU1hits","U1 Hits",12,0.,12.);

TH1F *hX2pos = new TH1F("hX2pos","X2 Position",4000,0.,800.);
TH1F *hX2th = new TH1F("hX2th","X2 Theta",120,20.,50.);
TH1F *hX2flag = new TH1F("hX2flag","X2 Flags",7,0.,7.);
TH1F *hX2chisq = new TH1F("hX2chisq","X2 Chi squared",50,0.,50.);
TH1F *hX2res1 = new TH1F("hX2res1","X2 Resolution",320,-8.,8);
TH1F *hX2eff = new TH1F("hX2eff","X2 Efficiency",100,0,100);
TH1F *hX2hits = new TH1F("hX2hits","X2 Hits",20,0.,20.);
TH1F *hX2dt = new TH1F("hX2dt","X2 offset corrected drifttime",1200,0.,15000.);

TH1F *hU2pos = new TH1F("hU2pos","U2 Position",4000,0.,800.);
TH1F *hU2th = new TH1F("hU2th","U2 Theta",120,20.,50.);
TH1F *hU2flag = new TH1F("hU2flag","U2 Flags",7,0.,7.);
TH1F *hU2chisq = new TH1F("hU2chisq","U2 Chi squared",50,0.,50.);
TH1F *hU2res1 = new TH1F("hU2res1","U2 Resolution",320,-8.,8);
TH1F *hU2eff = new TH1F("hU2eff","U2 Efficiency",100,0,100);
TH1F *hU2hits = new TH1F("hU2hits","U2 Hits",20,0.,20.);
TH1F *hU2dt = new TH1F("hU2dt","U2 offset corrected drifttime",1200,0.,15000.);

TH1F *hThFP = new TH1F("hThFP","Focal Plane Theta",4000,20.,60.);
TH1F *hThSCAT = new TH1F("hThSCAT","Scattering angle",200,-5.,5.);
TH1F *hPhiFP = new TH1F("hPhiFP","Focal Plane Phi",500,-5.,5.);
TH1F *hPhiSCAT = new TH1F("hPhiSCAT","SCAT Phi (from Y)",400,-4.,4.);
TH1F *hY1 = new TH1F("hY1","Y1",420,-60.,80.);
TH1F *hY2 = new TH1F("hY2","Y2",420,-60.,80.);


// fanciers stuff: create 1dim histogramsof

TH1F *hX1dt = new TH1F("hX1dt","X1 offset corrected drifttime",1200,0.,15000.);
TH1F *hX2dt = new TH1F("hX2dt","X2 offset corrected drifttime",1200,0.,15000.);
TH1F *hX1TimeDiff = new TH1F("hX1TimeDiff","X1 diff in drifttime",800,-4000.,4000.);

TH1F *hX1res1a = new TH1F("hX1res1a","X1 Resolution",400,-8.,8.);
TH1F *hX1res1b = new TH1F("hX1res1b","X1 Resolution",400,-8.,8.);
TH1F *hX1res1c = new TH1F("hX1res1c","X1 Resolution",400,-8.,8.);
TH1F *hX1res1d = new TH1F("hX1res1d","X1 Resolution",400,-8.,8.);

TH1F *hX1posa = new TH1F("hX1posa","X1 Position",4000,0.,800.);
TH1F *hX1posb = new TH1F("hX1posb","X1 Position",4000,0.,800.);
TH1F *hX1posc = new TH1F("hX1posc","X1 Position",4000,0.,800.);
TH1F *hX1posd = new TH1F("hX1posd","X1 Position",4000,0.,800.);

TH1F *hX1back1 = new TH1F("hX1back1","X1 background",1600,0.,800.);
TH1F *hX1back2 = new TH1F("hX1back2","X1 background",1600,0.,800.);
TH1F *hX1diff = new TH1F("hX1diff","X1 difference plot",1600,0.,800.);
TH1F *hX1pos2 = new TH1F("hX1pos2","X1 Position",4000,0.,800.);
TH1F *hX1pos3 = new TH1F("hX1pos3","X1 Position",1600,0.,800.);
TH1F *hX1posLoRes = new TH1F("hX1posLoRes","X1 Position",800,0.,800.);
TH1F *hX1posHiRes = new TH1F("hX1posHiRes","X1 Position",4000,0.,800.);

TH1F *hEx = new TH1F("hEx","Excitation energy",3100,-1.,30.);
TH1F *hExback = new TH1F("hExback","Excitation energy",3000,0.,30.);
TH1F *hExdiff = new TH1F("hExdiff","Excitation energy",3000,0.,30.);
TH1F *hEx1p5to2 = new TH1F("hEx1p5to2","Excitation energy",3100,-1.,30.);
TH1F *hEx1to1p5 = new TH1F("hEx1to1p5","Excitation energy",3100,-1.,30.);
TH1F *hExp5to1 = new TH1F("hExp5to1","Excitation energy",3100,-1.,30.);
TH1F *hEx0top5 = new TH1F("hEx0top5","Excitation energy",3100,-1.,30.);
  hEx0top5->SetLineColor(1);
  hExp5to1->SetLineColor(2);
  hEx1to1p5->SetLineColor(3);
  hEx1p5to2->SetLineColor(4);

TH1F *hruntime = new TH1F("hruntime","runtime",4000,0.,4000.);
TH1F *hevtcounter = new TH1F("hevtcounter","evtcounter",10000,0.,10000.);

TH1F *hdt = new TH1F("hdt","drifttime",3000,0.,15000.);


// 2 dimensional histogram definitions

TH2F *hpad1vstof = new TH2F("hpad1vstof","Scint 1 vs time of flight",1000,4000.,6000.,2000,0.,4000.);
TH2F *hpad1vstoftdc2 = new TH2F("hpad1vstoftdc2","Scint 1 vs time of flight: TDC2",1500,3500.,5000.,2000,0.,4000.);
TH2F *hpad1vstoftdc3 = new TH2F("hpad1vstoftdc3","Scint 1 vs time of flight: TDC3",1500,3500.,5000.,2000,0.,4000.);
TH2F *hpad1vstoftdc4 = new TH2F("hpad1vstoftdc4","Scint 1 vs time of flight: TDC4",1500,3500.,5000.,2000,0.,4000.);
TH2F *hpad1vstoftdc5 = new TH2F("hpad1vstoftdc5","Scint 1 vs time of flight: TDC5",1500,3500.,5000.,2000,0.,4000.);
TH2F *hpad1vstoftdc6 = new TH2F("hpad1vstoftdc6","Scint 1 vs time of flight: TDC6",1500,3500.,5000.,2000,0.,4000.);
TH2F *hpad1vstoftdc7 = new TH2F("hpad1vstoftdc7","Scint 1 vs time of flight: TDC7",1500,3500.,5000.,2000,0.,4000.);
TH2F *hpad2vstof = new TH2F("hpad2vstof","Scint 2 vs time of flight",1500,4000.,5500.,2000,0.,4000.);
TH2F *hpad1vspad2 = new TH2F("hpad1vspad2","Scint 1 vs Scint 2",800,0.,4000.,800,0.,4000.);
TH2F *hpad1vspad3 = new TH2F("hpad1vspad3","Scint 1 vs Scint 3",800,0.,4000.,800,0.,4000.);

TH2F *htofvsX1 = new TH2F("htofvsX1","time of flight vs X position",1600,0.,800.,500,4400.,5400.);
TH2F *hpadvsX1 = new TH2F("hpadvsX1","pad vs X",1600,0.,800.,1000,0.,4000.);

TH2F *hThFPvsX1 = new TH2F("hThFPvsX1","Focal Plane Theta vs X position",3200,0.,800.,600,20.,50.);
TH2F *hThFPvstof = new TH2F("hThFPvstof","ThFP vs tof",600,5100.,5700.,250,25.,50.);
TH2F *hThFPvstof2 = new TH2F("hThFPvstof2","ThFP vs tof",600,5100.,5700.,250,25.,50.);

TH2F *hY1vsX1 = new TH2F("hY1vsX1","Y1 vs X1",2400,0.,800.,720,-80.,80.);
TH2F *hY2vsX1 = new TH2F("hY2vsX1","Y2 vs X1",2400,0.,800.,280,-70.,70.);
TH2F *hY1vsY2 = new TH2F("hY1vsY2","Y1 vs Y2",480,-60.,60.,480,-60.,60.);
TH2F *hY1vsThFP = new TH2F("hY1vsThFP","Y vs Theta Focal Plane",1000,10.,60.,480,-60.,60.);
TH2F *hY1vsThSCAT = new TH2F("hY1vsThSCAT","Y vs Theta_scat ",1000,-5.,5.,480,-60.,60.);
TH2F *hY1vsPhiFP = new TH2F("hY1vsPhiFP","Y vs Phi",800,-20.,20.,560,-70.,70.);
TH2F *hY1vsPhiSCAT = new TH2F("hY1vsPhiSCAT","Y vs Phi",800,-20.,20.,500,-5.,5.);
TH2F *hY1vsX1Ex = new TH2F("hY1vsX1Ex","Y vs X",1500,0.,30.,280,-70.,70.);
TH2F *hY1vsEx = new TH2F("hY1vsEx","Y1 vs Ex",2200,5.,27.,280,-70.,70.);
TH2F *hY1vsExLowres = new TH2F("hY1vsExLowres","Y1 vs Ex",200,5.,25.,70,-70.,70.);

TH2F *hPhiFPvsX1 = new TH2F("hPhiFPvsX1","Focal Plane Phi vs X position",1600,0.,800.,200,-10.,10.);
TH2F *hPhiFPvsThFP = new TH2F("hPhiFPvsThFP","Phi vs ThFP",1000,25.,50.,800,-10.,10.);
TH2F *hPhiFPvsThSCAT = new TH2F("hPhiFPvsThSCAT","PhiFP vs ThSCAT",500,-5.,5.,500,-5.,5.);
TH2F *hPhiFPvsY1 = new TH2F("hPhiFPvsY1","Phi vs Y Focal Plane",560,-70.,70.,400,-10.,10.);
TH2F *hPhiFPvsY1z = new TH2F("hPhiFPvsY1z","Phi vs Y Focal Plane",250,-50.,50.,400,-2.,2.);

TH2F *hPhiSCATvsThSCAT = new TH2F("hPhiSCATvsThSCAT","PhiSCAT vs ThSCAT",500,-5.,5.,500,-5.,5.);

TH2F *hThSCATvsX1 = new TH2F("hThSCATvsX1","SCATTERING Theta vs X position",1600,0.,800.,400,-4.,4.);
TH2F *hThSCATvsX1c = new TH2F("hThSCATvsX1c","SCATTERING Theta vs corrected X position",1600,0.,800.,400,-4.,4.);
TH2F *hThSCATvsX1v2 = new TH2F("hThSCATvsX1v2","SCATTERING Theta vs X position",1600,0.,800.,400,-4.,4.);
TH2F *hThSCATvsEx = new TH2F("hThSCATvsEx","SCATTERING Theta vs Ex",3100,-1.,30.,400,-4.,4.);
TH2F *hThSCATvsTOF = new TH2F("hThSCATvsTOF","SCATTERING Theta vs TOF",400,4800.,5200.,300,-6.,6.);
TH2F *hThSCATvsExLowres = new TH2F("hThSCATvsExLowres","SCATTERING Theta vs Ex",200,5.,25.,100,-4.,4.);

TH2F *hX1Res2d = new TH2F("hX1Res2d","iTL style resolution plot for X1 (xaxis=pos-int(pos)) ", 200,-0.1,1.1,200,-3.,3.);
TH2F *hX2Res2d = new TH2F("hX2Res2d","iTL style resolution plot for X2 (xaxis=pos-int(pos)) ", 200,-0.1,1.1,200,-3.,3.);
TH2F *hU1Res2d = new TH2F("hU1Res2d","iTL style resolution plot for U1 (xaxis=pos-int(pos)) ", 200,-0.1,1.1,200,-3.,3.);
TH2F *hU2Res2d = new TH2F("hU2Res2d","iTL style resolution plot for U2 (xaxis=pos-int(pos)) ", 200,-0.1,1.1,200,-3.,3.);
TH2F *hX1Res2da = new TH2F("hX1Res2da","iTL style resolution plot for X1 (xaxis=pos-int(pos)) ", 200,-0.1,1.1,200,-3.,3.);
TH2F *hX2Res2da = new TH2F("hX2Res2da","iTL style resolution plot for X2 (xaxis=pos-int(pos)) ", 200,-0.1,1.1,200,-3.,3.);
TH2F *hU1Res2da = new TH2F("hU1Res2da","iTL style resolution plot for U1 (xaxis=pos-int(pos)) ", 200,-0.1,1.1,200,-3.,3.);
TH2F *hU2Res2da = new TH2F("hU2Res2da","iTL style resolution plot for U2 (xaxis=pos-int(pos)) ", 200,-0.1,1.1,200,-3.,3.);

//TH2F *hX1Res2da = new TH2F("hX1Res2da","iTL style resolution plot for X1 (xaxis=pos-int(pos)) ", 200,-0.1,1.1,200,-3.,3.);
TH2F *hX1Res2db = new TH2F("hX1Res2db","iTL style resolution plot for X1 (xaxis=pos-int(pos)) ", 200,-0.1,1.1,200,-3.,3.);
TH2F *hX1Res2dc = new TH2F("hX1Res2dc","iTL style resolution plot for X1 (xaxis=pos-int(pos)) ", 200,-0.1,1.1,200,-3.,3.);
TH2F *hX1Res2dd = new TH2F("hX1Res2dd","iTL style resolution plot for X1 (xaxis=pos-int(pos)) ", 200,-0.1,1.1,200,-3.,3.);

TH2F *hX1ResvsX1 = new TH2F("hX1ResvsX1","Res vs X1", 1600,0,800,120,-6.,6.);
TH2F *hX1ResvsThFP = new TH2F("hX1ResvsThFP","Res vs ThFP", 600,0,60,120,-6.,6.);


TH2F *hESivsX = new TH2F("hESivsX","ESi vs X",800,0,800,1000,0.,10000.);
TH2F *hESivsEx = new TH2F("hESivsEx","ESi vs Ex",1000,7,27,1000,0.,10000.);
TH2F *hEHAGARvsEx = new TH2F("hEHAGARvsEx","EHAGAR vs Ex",1000,7,27,100,0.,10.);
TH2F *hESivsSiTheta = new TH2F("hESivsSiTheta","ESi vs SilicontTheta",1000,0.,200.,1000.,0.,10000.);
TH2F *hSiPhivsSiTheta = new TH2F("hSiPhivsSiTheta","SiPhi vs SiTheta",360,100.,180.,380.,-10.,370.);
TH2F *hSiSAvsSiTheta = new TH2F("hSiSAvsSiTheta","SiSA vs SiTheta",400,100.,200.,4000.,0.,14.);

}


