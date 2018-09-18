{ //This script subtracts the two background components from the X1position spectrum created in the analysis procedure. Be sure to change the Y limits to the appropriate values for your analysis. 
 
 
gStyle->SetPalette(1,0);

c1 = new TCanvas("c1","c1",800,10,1000,600);
c1->SetFillColor(0);
c1->SetGridy(0);
c1->SetFillColor(0);

//cuts for 26Mg
//TCut CUTYbck1 = "Y1>-40 && Y1<-10";                                     // "Y1>-35 && Y1<-10";//"Y1>-32 && Y1<-12";   
//TCut CUTYbck2 = "Y1>22 && Y1<35";  

//cuts for 24Mg weekend 3
/*
TCut CUTy = "Y1>-4 && Y1<25";
TCut CUTYbck1 = "Y1<-4 && Y1>-24";
TCut CUTYbck2 = "Y1<-24 && Y1>-44";
//TCut CUTYbckg = "Y1>-40 && Y1<-4";
*/

TCut CUTy = "Y1>-3 && Y1<24"; //21
TCut CUTYbck1 = "Y1<-3 && Y1>-43"; //40
TCut CUTYbck2 = "Y1<37 && Y1>24"; //13

// Create 1 dimensional histograms

TH1F *hX1pos = new TH1F("hX1pos","X1 position",3000,0.,30.);
TH1F *hX1back1 = new TH1F("hX1back1","X1 position",3000,0.,30.);
TH1F *hX1back2 = new TH1F("hX1back2","X1 position",3000,0.,30.);
TH1F *hX1backtot = new TH1F("hX1backtot","X1 position",3000,0.,30.);
TH1F *hX1diff = new TH1F("hX1diff","X1 position",3000,0.,30.);

DATA->Draw("X1pos>>hX1pos",CUTbasic && CUTlimits && CUTy,"col");
DATA->Draw("X1pos>>hX1back1",CUTbasic && CUTlimits && CUTYbck1,"col");
DATA->Draw("X1pos>>hX1back2",CUTbasic && CUTlimits && CUTYbck2,"col");

hX1diff->SetTitle("24Mg(#alpha,#alpha) at 0^{o}"); // (background subtracted)");
hX1diff->SetStats(0);
hX1diff->GetXaxis()->SetTitle("X1 position spectrum");
hX1diff->GetXaxis()->CenterTitle(true);
hX1diff->GetYaxis()->SetTitle("Counts");
hX1diff->GetYaxis()->CenterTitle(true);
hX1diff->GetXaxis()->SetTitleOffset(1.1);  
hX1diff->GetYaxis()->SetTitleOffset(1.4); 

hX1diff->Add(hX1pos);
hX1diff->Add(hX1back1,-10.5/40.);
hX1diff->Add(hX1back2,-10.5/13.);
hX1backtot->Add(hX1back1,-10.5/40.);
hX1backtot->Add(hX1back2, -10.5/13.);

hX1pos->SetLineColor(4);
hX1back1->SetLineColor(2);
hX1back2->SetLineColor(3);
hX1diff->SetLineColor(1);
hX1backtot->SetLineColor(6);
hX1pos->Draw();
hX1diff->Draw("same");
hX1back1->Draw("same");
hX1back2->Draw("same");
hX1backtot->Draw("same");


//==============================================
// Uncomment the following to obtain double differential cross sections 
/*
TH1F *hX1posCs = new TH1F("hX1posCs","^{48}Ca Cross-section X1poscitation energy",3000,0.,30.);
hX1posCs->Add(hX1diff);
hX1posCs->GetXaxis()->SetTitle("E_{x} (MeV)");
hX1posCs->GetXaxis()->CenterTitle(true);
hX1posCs->GetYaxis()->SetTitle("Cross-section (mb/sr.MeV)");
hX1posCs->GetYaxis()->CenterTitle(true);


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

hX1posCs->Scale(1000/norm);
hX1posCs->Draw();

//==================================================
*/
//TH1F *hX1posSm150 = new TH1F("hX1posSm150","X1poscitation energy",3100,-1.,30.);
//hX1posSm150 = hX1diff;

//Output a data file in PWD

/*
 ofstream out;
  out.open("datafile-150Sm-X1posCs-pX1posCalib");

  float lut;
  Int_t nbins = hX1posCs->GetNbinsX();

  // Now write to a datafile
  for(Int_t i=0;i<nbins;i++) {
    out << i << "  " << hX1posCs->GetBinContent(i)  << endl;
  }

  out.close();
*/
}


