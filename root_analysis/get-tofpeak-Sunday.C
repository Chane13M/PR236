{
  // Use CUTbasic, CUTlimits as defined in read-gates-we?.C
 
  char name[128];

  Int_t run_no[]={3151,3077,3081,3106,3138,3142,3146}; //WE1 26Mg
  //weekend 1 all
  //Int_t run_no[]={1128,1093,1100,1104,1108,1112,1117,1123,1097,1103,1107,1111,1118,1121,1127,1023,1095,1101,1106,1110,1116,1120,1126};
  Int_t nrofruns=sizeof(run_no)/sizeof(run_no[0]);  
  cout<<" Total nr of runs to peakfit: "<< nrofruns<<endl;

  Double_t par[5];
  Float_t peakposition[nrofruns];
  Float_t sigma[nrofruns];

  for(Int_t i=0;i<nrofruns;i++)	{
          cout<<" Run nr  "<< i<<endl;
	  sprintf(name,"~/K600/Data/PR236/sorted0%4d.root",run_no[i]);
          //cout << name << endl;
	  TFile *_file0 = TFile::Open(name);     
  	  TH1F *htof = new TH1F("htof","TOF",1000,4500.,5500.);
          DATA->Draw("tof>>htof","pad1<500","");
	  htof->Fit("gaus","QR","",4630,4745);  

	  gaus->GetParameters(par);
          peakposition[i] = par[1];
          sigma[i] = par[2];

	  TCanvas *c1 = new TCanvas;
	  c1->Modified(); c1->Update();
	  c1->WaitPrimitive(); 
  }
  for(Int_t i=0;i<nrofruns;i++)	{
     cout << " "<< run_no[i] <<" "<< peakposition[i] <<" "<< sigma[i] << endl;
  }
 
  for(Int_t i=0;i<nrofruns;i++)	{
     cout << run_no[i] <<"  "<< int(peakposition[0]-peakposition[i]) << endl;
  }


}




