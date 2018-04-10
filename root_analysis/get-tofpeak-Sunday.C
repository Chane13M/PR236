{
  // Use CUTbasic, CUTlimits as defined in read-gates-we?.C
 
  char name[128];

  Int_t run_no[]={3151,3077,3081,3106,3138,3142,3146}; //WE1 26Mg
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
	  htof->Fit("gaus","QR","",4600,4800);  

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




