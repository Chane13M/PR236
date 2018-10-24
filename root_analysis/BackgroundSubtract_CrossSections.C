{ 
gStyle->SetPalette(1,0);

c3 = new TCanvas("c3","c3",800,10,1000,600);
c3->SetFillColor(0);
c3->SetGridy(0);
c3->SetFillColor(0);

//for 24Mg weekend 3
//TCut CUTYbck1 = "Y1>-25 && Y1<-7";   
//TCut CUTYbck2 = "Y1>-43 && Y1<-25";  
 
 //for 90Zr weekend 2
TCut CUTYbck1 = "Y1>-28 && Y1<-12.5";   
TCut CUTYbck2 = "Y1>-43.5 && Y1<-28";

//for 58Ni weekend 3
//TCut CUTYbck1 = "Y1>-20 && Y1<-10";
//TCut CUTYbck2 = "Y1>-30 && Y1<-20";

//for 24Mg weekend 2
//TCut CUTYbck1 = "Y1<-3 && Y1>-22";
//TCut CUTYbck2 = "Y1<-22 && Y1>-41";

// Create 1 dimensional histograms for Position
TH1F *hEx = new TH1F("hEx","Excitation energy",3000,0,30);
TH1F *hExback1 = new TH1F("hExback1","Excitation energy",3000,0,30);
TH1F *hExback2 = new TH1F("hExback2","Excitation energy",3000,0,30);
TH1F *hExbacktot = new TH1F("hExbacktot","Excitation energy",3000,0,30);
TH1F *hExdiff = new TH1F("hExdiff","Excitation energy",3000,0,30);

DATAChain->Draw("Ex>>hEx",CUTbasic && CUTflags && CUTlimits && CUTy,"");
DATAChain->Draw("Ex>>hExback2",CUTbasic && CUTflags && CUTlimits && CUTYbck1,"");
DATAChain->Draw("Ex>>hExback1",CUTbasic && CUTflags && CUTlimits && CUTYbck2,"");

hExdiff->SetTitle("^{58}Ni(#alpha,#alpha) at 0^{o} (background subtracted)");
hExdiff->SetStats(0);
hExdiff->GetXaxis()->SetTitle("E_{x} (MeV)");
hExdiff->GetXaxis()->CenterTitle(true);
hExdiff->GetYaxis()->SetTitle("Counts/10keV");
hExdiff->GetYaxis()->CenterTitle(true);
hExdiff->GetXaxis()->SetTitleOffset(1.1);  
hExdiff->GetYaxis()->SetTitleOffset(1.4); 

hExdiff->Add(hEx);
hExdiff->Add(hExback1, -1);
hExdiff->Add(hExback2, -1);
hExbacktot->Add(hExback1);
hExbacktot->Add(hExback2);

hEx->SetLineColor(4);
hExback1->SetLineColor(2);
hExback2->SetLineColor(3);
hExdiff->SetLineColor(1);
hExbacktot->SetLineColor(6);

hEx->Draw();
hExdiff->Draw("same");
hExback1->Draw("same");
hExback2->Draw("same");
hExbacktot->Draw("same");

leg = new TLegend(0.1,0.7,0.48,0.9);
//leg->SetHeader("Legend",""); // option "C" allows to center the header
leg->AddEntry(hEx,"Raw data","l");
leg->AddEntry(hExback1,"Background 1","l");
leg->AddEntry(hExback2,"Background 2","l");
leg->AddEntry(hExbacktot,"Total background","l");
leg->AddEntry(hExdiff,"Background subtracted data","l");
//leg->SetLegendFont(16);
leg->Draw();

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