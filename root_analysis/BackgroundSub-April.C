{ //This script subtracts the two background components from the Excitation Energy spectrum created in the analysis procedure. Be sure to change the Y limits to the appropriate values for your analysis. 
 
 
gStyle->SetPalette(1,0);

c1 = new TCanvas("c1","c1",800,10,1000,600);
c1->SetFillColor(0);
c1->SetGridy(0);
c1->SetFillColor(0);

//cuts for 26Mg
TCut CUTYbck1 = "Y1>-40 && Y1<-10";                                     // "Y1>-35 && Y1<-10";//"Y1>-32 && Y1<-12";   
TCut CUTYbck2 = "Y1>22 && Y1<35";  

// Create 1 dimensional histograms

TH1F *hEx = new TH1F("hEx","Excitation energy",3000,0.,30.);
TH1F *hExback1 = new TH1F("hExback1","Excitation energy",3000,0.,30.);
TH1F *hExback2 = new TH1F("hExback2","Excitation energy",3000,0.,30.);
TH1F *hExbacktot = new TH1F("hExbacktot","Excitation energy",3000,0.,30.);
TH1F *hExdiff = new TH1F("hExdiff","Excitation energy",3000,0.,30.);


//DATA->Draw("(Ex-0.086)>>hEx",CUTbasic && CUTlimits && CUTy,"");
//DATA->Draw("(Ex-0.086)>>hExback1",CUTbasic && CUTlimits && CUTYbck1,"");
//DATA->Draw("(Ex-0.086)>>hExback2",CUTbasic && CUTlimits && CUTYbck2,"");


DATA->Draw("(Ex-0.085)>>hEx",CUTbasic && CUTlimits && CUTy,"");
DATA->Draw("(Ex-0.085)>>hExback1",CUTbasic && CUTlimits && CUTYbck1,"");
DATA->Draw("(Ex-0.085)>>hExback2",CUTbasic && CUTlimits && CUTYbck2,"");


//removed the X2flag==0 since the efficiency of X2 wasn't great and so, including this condition makes us sensitive to anything that isn't quite right with X2.


//hEx->SetTitle("^{24}Mg(#alpha,#alpha') at 0^{o}"); // (background subtracted)");
//hEx->SetStats(0);
//hEx->GetXaxis()->SetTitle("E_{x} (MeV)");
//hEx->GetXaxis()->CenterTitle(true);
//hEx->GetYaxis()->SetTitle("Counts");
//hEx->GetYaxis()->CenterTitle(true);
//hEx->GetXaxis()->SetTitleOffset(1.1);  
//hEx->GetYaxis()->SetTitleOffset(1.4); 

hExdiff->SetTitle("26Mg(#alpha,#alpha) at 0^{o}"); // (background subtracted)");
hExdiff->SetStats(0);
hExdiff->GetXaxis()->SetTitle("E_{x} (MeV)");
hExdiff->GetXaxis()->CenterTitle(true);
hExdiff->GetYaxis()->SetTitle("Counts/10keV");
hExdiff->GetYaxis()->CenterTitle(true);
hExdiff->GetXaxis()->SetTitleOffset(1.1);  
hExdiff->GetYaxis()->SetTitleOffset(1.4); 

hExdiff->Add(hEx);
hExdiff->Add(hExback1,-16/30.);
hExdiff->Add(hExback2,-16/13.);
hExbacktot->Add(hExback1,-16/30.);
hExbacktot->Add(hExback2,16/13.);

hEx->SetLineColor(4);
hExback1->SetLineColor(2);
hExback2->SetLineColor(3);
hExdiff->SetLineColor(1);
hExbacktot->SetLineColor(6);
//hEx->Draw();
hExdiff->Draw();
//hExdiff->Draw("same");
//hExback1->Draw("same");
//hExback2->Draw("same");
//hExbacktot->Draw("same");


//==============================================
// Uncomment the following to obtain double differential cross sections 
/*
TH1F *hExCs = new TH1F("hExCs","^{48}Ca Cross-section Excitation energy",3000,0.,30.);
hExCs->Add(hExdiff);
hExCs->GetXaxis()->SetTitle("E_{x} (MeV)");
hExCs->GetXaxis()->CenterTitle(true);
hExCs->GetYaxis()->SetTitle("Cross-section (mb/sr.MeV)");
hExCs->GetYaxis()->CenterTitle(true);


SA = 3.48; //2.44;// msr  
cii = 13073107;//11281133;//9991792;//13073107;//8062253; 
tgtthick =1.09;//1.315;//0.3; // mg/cm^2 
A=48;//44; //24;
e= 3.20435466; //1.60217733;
eff= 0.6821;//0.7063;
range=20;//6; 
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


