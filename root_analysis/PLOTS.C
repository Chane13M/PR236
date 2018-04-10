///////////////////////////////////////////////////////////////////////////
// Macro for plotting all plots of interest per specific run             //
//                    	  	                                         //
//									 //
//  The run file of interest should be read in to root			 //
//  before implementing this script 					 //
//									 //
///////////////////////////////////////////////////////////////////////////

{

//Scintillator 1 vs Time of flight
//TH2F *hpad1vstof = new TH2F("hpad1vstof","Scint 1 vs time of flight",1000,4000.,6000.,2000,0.,4000.);
  //TCanvas *C2 = new TCanvas;
  //DATA->Draw("pad1:tof>>hpad1vstof","","col");
  //C2 -> Update();

//Scintillator 2 vs Time of Flight
//TH2F *hpad2vstof = new TH2F("hpad2vstof","Scint 2 vs time of flight",1500,4000.,5500.,2000,0.,4000.);
  //TCanvas *C3 = new TCanvas;
  //DATA->Draw("pad2:tof>>hpad2vstof","","col");
  //C3 -> Update();
  //C3 -> Modified();

//Scintillator 1 vs Scintilattor 2
//TH2F *hpad1vspad2 = new TH2F("hpad1vspad2","Scint 1 vs Scint 2",800,0.,4000.,800,0.,4000.);
  //TCanvas *C4 = new TCanvas;
  //DATA->Draw("pad1:pad2>>hpad1vspad2","","col");
  //C4 -> Update();
  //C4 -> Modified();

//X1 position, 1D histogram
//TH1F *hX1pos = new TH1F("hX1pos","X1 Position",4000,0.,800.);
  //TCanvas *C5 = new TCanvas;
  //DATA->Draw("X1pos>>hX1pos","","col");
  //C5 -> Update();
  //C5 -> Modified();

//ToF vs X1 position
//TH2F *htofvsX1 = new TH2F("htofvsX1","time of flight vs X position",1600,0.,800.,500,4400.,5400.);
  //TCanvas *C6 = new TCanvas;
  //DATA->Draw("tof:X1pos>>htofvsX1","","col");
  //C6 -> Update();
  //C6 -> Modified();

//scattering angle vs X1 position
//TH2F *hThSCATvsX1 = new TH2F("hThSCATvsX1","SCATTERING Theta vs X position",6400,0.,800.,800,-4.,4.);
  //TCanvas *C7 = new TCanvas;
  //DATA->Draw("thetaSCAT:X1pos>>hThSCATvsX1","X1flag==0 && X2flag==0 && U1flag==0 && U2flag==0","col");
  //gPad->SetLogz();
  //C7 -> Update();
  //C7 -> Modified();

//scattering angle vs X1 position cut
//TH2F *hThSCATvsX1pos = new TH2F("hThSCATvsX1pos","SCATTERING Theta vs X position",400,530,690,800,-2.1,2.3);
  //TCanvas *C8 = new TCanvas;
  //DATA->Draw("thetaSCAT:X1pos>>hThSCATvsX1pos","","col");
  //gPad->SetGridx(1);
  //gPad->SetLogz();
  //C8 -> Update();
  //C8 -> Modified();


//scattering angle vs X1 position cut1
//TH2F *hThSCATvsX1pos1 = new TH2F("hThSCATvsX1pos1","SCATTERING Theta vs X position",200,600,680,800,-2.1,2.3);
  //TCanvas *C13 = new TCanvas;
  //DATA->Draw("thetaSCAT:X1pos>>hThSCATvsX1pos1","X1flag==0 && X2flag==0 && U1flag==0 && U2flag==0","col");
  //gPad->SetGridx(1);
  //gPad->SetLogz();
  //C13 -> Update();
  //C13 -> Modified();


//weekend 3 corrections
//first trial
//scattering angle vs X1 position cut with lineshape deg 3
//TH2F *hThSCATvsX1ls = new TH2F("hThSCATvsX1ls","SCATTERING Theta vs X position",400,580,700,800,-2,2.5); //where ls is the line shape correction
  //TCanvas *C9 = new TCanvas;
  //DATA->Draw("thetaSCAT:X1pos-((3.04565)*thetaSCAT+(0.659034)*thetaSCAT^2+(-0.217611)*thetaSCAT^3)>>hThSCATvsX1ls","","col"); //no cuts at play yet
  //gPad->SetGridx(1);
  //gPad->SetLogz();
  //C9 -> Update();
  //C9 -> Modified();


//scattering angle vs X1 position cut with lineshape deg 4
//TH2F *hThSCATvsX1ls2 = new TH2F("hThSCATvsX1ls2","SCATTERING Theta vs X position",400,580,700,800,-2,2.5);
  //TCanvas *C10 = new TCanvas;
  //DATA->Draw("thetaSCAT:X1pos-((2.94906)*thetaSCAT+(1.01983)*thetaSCAT^2+(-0.141724)*thetaSCAT^3+(-0.13877)*thetaSCAT^4)>>hThSCATvsX1ls2","","col"); //again not cuts have been made yet
  //gPad->SetGridx(1);
  //gPad->SetLogz();
  //C10 -> Update();
  //C10 -> Modified();


//second trial with new points
//scattering angle vs X1 position cut with lineshape deg 3
//TH2F *hThSCATvsX1ls = new TH2F("hThSCATvsX1ls","SCATTERING Theta vs X position",400,580,700,800,-2,2.5); //where ls is the line shape correction
  //TCanvas *C9 = new TCanvas;
  //DATA->Draw("thetaSCAT:X1pos-((2.70768)*thetaSCAT+(0.688965)*thetaSCAT^2+(-0.085651)*thetaSCAT^3)>>hThSCATvsX1ls","","col"); //no cuts at play yet
  //gPad->SetGridx(1);
  //gPad->SetLogz();
  //C9 -> Update();
  //C9 -> Modified();


//scattering angle vs X1 position cut with lineshape deg 4
//TH2F *hThSCATvsX1ls2 = new TH2F("hThSCATvsX1ls2","SCATTERING Theta vs X position",400,580,700,800,-2,2.5);
  //TCanvas *C10 = new TCanvas;
  //DATA->Draw("thetaSCAT:X1pos-((2.6150)*thetaSCAT+(1.04387)*thetaSCAT^2+(-0.0138676)*thetaSCAT^3+(-0.140311)*thetaSCAT^4)>>hThSCATvsX1ls2","","col");
//again not cuts have been made yet
  //gPad->SetGridx(1);
  //gPad->SetLogz();
  //C10 -> Update();
  //C10 -> Modified();


//scattering angle vs X1 position cut with lineshape deg 5
//TH2F *hThSCATvsX1ls3 = new TH2F("hThSCATvsX1ls3","SCATTERING Theta vs X position",400,580,700,800,-2,2.5);
  //TCanvas *C11 = new TCanvas;
  //DATA->Draw("thetaSCAT:X1pos-((2.72374)*thetaSCAT+(1.12143)*thetaSCAT^2+(-0.189927)*thetaSCAT^3+(-0.178172)*thetaSCAT^4+(0.0548845)*thetaSCAT^5)>>hThSCATvsX1ls3","","col");
//again not cuts have been made yet
  //gPad->SetGridx(1);
  //gPad->SetLogz();
  //C11 -> Update();
  //C11 -> Modified();


//weekend 1 corrections
//version 1
//scattering angle vs X1 position cut with lineshape deg 3
//TH2F *hThSCATvsX1ls = new TH2F("hThSCATvsX1ls","SCATTERING Theta vs X position",200,600,680,800,-2.1,2.3); //where ls is the line shape correction
  //TCanvas *C9 = new TCanvas;
  //DATA->Draw("thetaSCAT:X1pos-((2.94367)*thetaSCAT+(0.837529)*thetaSCAT^2+(-0.148639)*thetaSCAT^3)>>hThSCATvsX1ls","","col"); //no cuts at play yet
  //gPad->SetGridx(1);
  //gPad->SetLogz();
  //C9 -> Update();
  //C9 -> Modified();


//scattering angle vs X1 position cut with lineshape deg 4
//TH2F *hThSCATvsX1ls2 = new TH2F("hThSCATvsX1ls2","SCATTERING Theta vs X position",200,600,680,800,-2.1,2.3);
  //TCanvas *C10 = new TCanvas;
  //DATA->Draw("thetaSCAT:X1pos-((2.87386)*thetaSCAT+(1.35947)*thetaSCAT^2+(-0.091479)*thetaSCAT^3+(-0.197402)*thetaSCAT^4)>>hThSCATvsX1ls2","","col");
//again not cuts have been made yet
  //gPad->SetGridx(1);
  //gPad->SetLogz();
  //C10 -> Update();
  //C10 -> Modified();


//scattering angle vs X1 position cut with lineshape deg 5
//TH2F *hThSCATvsX1ls3 = new TH2F("hThSCATvsX1ls3","SCATTERING Theta vs X position",200,600,680,800,-2.1,2.3);
  //TCanvas *C11 = new TCanvas;
  //DATA->Draw("thetaSCAT:X1pos-((3.13852)*thetaSCAT+(1.48315)*thetaSCAT^2+(-0.520678)*thetaSCAT^3+(-0.25651)*thetaSCAT^4+(0.129682)*thetaSCAT^5)>>hThSCATvsX1ls3","X1flag==0 && X2flag==0 && U1flag==0 && U2flag==0","col");
//again no cuts have been made yet
  //gPad->SetGridx(1);
  //gPad->SetLogz();
  //C11 -> Update();
  //C11 -> Modified();


//version 2
//scattering angle vs X1 position cut with lineshape deg 4
TH2F *hThSCATvsX1ls2 = new TH2F("hThSCATvsX1ls2","SCATTERING Theta vs X position",200,600,680,800,-2.1,2.3);
  TCanvas *C10 = new TCanvas;
  DATA->Draw("thetaSCAT:X1pos-((2.78291)*thetaSCAT+(1.19987)*thetaSCAT^2+(-0.0317344)*thetaSCAT^3+(-0.151792)*thetaSCAT^4)>>hThSCATvsX1ls2","","col");
//again not cuts have been made yet
  //gPad->SetGridx(1);
  gPad->SetLogz();
  C10 -> Update();
  C10 -> Modified();


//scattering angle vs X1 position cut with lineshape deg 5
TH2F *hThSCATvsX1ls3 = new TH2F("hThSCATvsX1ls3","SCATTERING Theta vs X position",200,600,680,800,-2.1,2.3);
  TCanvas *C11 = new TCanvas;
  DATA->Draw("thetaSCAT:X1pos-((2.98158)*thetaSCAT+(1.29616)*thetaSCAT^2+(-0.351466)*thetaSCAT^3+(-0.196324)*thetaSCAT^4+(-0.0975482)*thetaSCAT^5)>>hThSCATvsX1ls3","","col");
//again not cuts have been made yet
  //gPad->SetGridx(1);
  gPad->SetLogz();
  C11 -> Update();
  C11 -> Modified();


//corrected X1pos vs scattering angle
//scattering angle vs X1 position
TH2F *hThSCATvsX1C = new TH2F("hThSCATvsX1C","SCATTERING Theta vs X position",6400,0.,800.,800,-4.,4.);
  TCanvas *C15 = new TCanvas;
  DATA->Draw("thetaSCAT:X1posC>>hThSCATvsX1C","X1flag==0 && X2flag==0 && U1flag==0 && U2flag==0","col");
  gPad->SetLogz();
  //C15 -> Update();
  //C15 -> Modified();


//X1position corrected
TH1F *hX1pos = new TH1F("hX1pos","X1 Position",4000,0.,800.);
  TCanvas *C16 = new TCanvas;
  DATA->Draw("X1posC>>hX1pos","X1flag==0 && X2flag==0 && U1flag==0 && U2flag==0","col");







}
