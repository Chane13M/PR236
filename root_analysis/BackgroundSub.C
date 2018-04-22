{ //This script subtracts the two background components from the Excitation Energy spectrum created in the analysis procedure. Be sure to change the Y limits to the appropriate values for your analysis. 
 
 
gStyle->SetPalette(1,0);

c1 = new TCanvas("c1","c1",800,10,1000,600);
c1->SetFillColor(0);
c1->SetGridy(0);
c1->SetFillColor(0);

// Create 1 dimensional histograms

TH1F *hEx = new TH1F("hEx","Excitation energy",3100,-1.,30.);
TH1F *hExback1 = new TH1F("hExback1","Excitation energy",3100,-1.,30.);
TH1F *hExback2 = new TH1F("hExback2","Excitation energy",3100,-1.,30.);
TH1F *hExbacktot = new TH1F("hExbacktot","Excitation energy",3100,-1.,30.);
TH1F *hExdiff = new TH1F("hExdiff","Excitation energy",3100,-1.,30.);


//chain-150SmGroup
//Note that we use X1posC

DATA->Draw("31.3106-0.0316805*X1posC-3.5533e-07*X1posC*X1posC>>hEx",CUTbasic && CUTflags && CUTlimits && CUTy,"");
DATA->Draw("31.3106-0.0316805*X1posC-3.5533e-07*X1posC*X1posC>>hExback2",CUTbasic && CUTflags && CUTlimits && CUTyback2,"");
DATA->Draw("31.3106-0.0316805*X1posC-3.5533e-07*X1posC*X1posC>>hExback1",CUTbasic && CUTflags && CUTlimits && CUTyback1,"");

/*
DATA->Draw("32.0702-(0.03575*X1posC)+(0.00000411451*X1posC*X1posC)>>hEx","CUTtofX1 && CUTpad1tof && CUTpad2tof && CUTpad1pad2 && X1flag==0 && U1flag==0 && U2flag==0 && ThSCAT<1.91 && ThSCAT>-1.91 && Y1<15 && Y1>-25","");
DATA->Draw("32.0702-(0.03575*X1posC)+(0.00000411451*X1posC*X1posC)>>hExback2","CUTtofX1 && CUTpad1tof && CUTpad2tof && CUTpad1pad2 && X1flag==0 && U1flag==0 && U2flag==0 && ThSCAT<1.91 && ThSCAT>-1.91 && Y1<35 && Y1>25","");
DATA->Draw("32.0702-(0.03575*X1posC)+(0.00000411451*X1posC*X1posC)>>hExback1","CUTtofX1 && CUTpad1tof && CUTpad2tof && CUTpad1pad2 && X1flag==0 && U1flag==0 && U2flag==0 && ThSCAT<1.91 && ThSCAT>-1.91 && Y1<25 && Y1>15","");
*/

//removed the X2flag==0 since the efficiency of X2 wasn't great and so, including this condition makes us sensitive to anything that isn't quite right with X2.

//remember to change the axis title
hExdiff->SetTitle("^{26}Mg(#alpha,#alpha') at 0^{o} (background subtracted)"); //figure out how to insert alpha,alpha'
hExdiff->SetStats(0);
hExdiff->GetXaxis()->SetTitle("E_{x} (MeV)");
hExdiff->GetXaxis()->CenterTitle(true);
hExdiff->GetYaxis()->SetTitle("Counts/10keV");
hExdiff->GetYaxis()->CenterTitle(true);

hExdiff->Add(hEx);
hExdiff->Add(hExback1,-0.77778);
hExdiff->Add(hExback2,-0.77778);
hExbacktot->Add(hExback1,0.77778);
hExbacktot->Add(hExback2,0.77778);

hEx->SetLineColor(4);
hExback1->SetLineColor(2);
hExback2->SetLineColor(3);
hExdiff->SetLineColor(1);
hExbacktot->SetLineColor(6);

hEx->Draw();//58Ni for chained data - this needs to be chained per isotope
//this is for 24Mg data
TCut CUTy = "Y1>-4 && Y1<20";
TCut CUTyback1 = "Y1<-4 && Y1>-22";
TCut CUTyback2 = "Y1<-22 && Y1>-40";     
TCut CUTybckg = "Y1>-40 && Y1<-4";
hExdiff->Draw("same");
hExback1->Draw("same");
hExback2->Draw("same");
hExbacktot->Draw("same");


//==============================================
// Uncomment the following to obtain double differential cross sections 
 /* 
TH1F *hExCs = new TH1F("hExCs","^{150}Sm Cross-section Excitation energy",3100,-1.,30.);
hExCs->Add(hExdiff);
hExCs->GetXaxis()->SetTitle("E_{x} (MeV)");
hExCs->GetXaxis()->CenterTitle(true);
hExCs->GetYaxis()->SetTitle("(mb/sr.MeV)");
hExCs->GetYaxis()->CenterTitle(true);


SA = 3.48; // msr  
cii = 8062253; 
tgtthick = 3.76; // mg/cm^2 
A=150;
e=1.60217733;
eff=0.7063;
range=6;
NA=6.0221367;
elecdead=0.9935; 
ebin=0.01;

incidentflux=(cii*range)/e;
scatterers=(tgtthick*NA)/A;
temp=elecdead*eff*ebin*SA;
norm=incidentflux*scatterers*temp;

cout <<"cii = " << cii << endl;
cout <<"Incident flux = "<< incidentflux << endl;
cout <<"scatterers = "<< scatterers << endl;
cout <<"temp = "<< temp << endl;

hExCs->Scale(1000/norm);
hExCs->Draw();

//==================================================
*/

//TH1F *hExSm150 = new TH1F("hExSm150","Excitation energy",3100,-1.,30.);
//hExSm150 = hExdiff;

//Output a data file in PWD

/*
 ofstream out;
  out.open("datafile-150Sm-ExCs-pExCalib");

  float lut;
  Int_t nbins = hExCs->GetNbinsX();

  // Now write to a datafile
  for(Int_t i=0;i<nbins;i++) {
    out << i << "  " << hExCs->GetBinContent(i)  << endl;
  }

  out.close();
*/
}


