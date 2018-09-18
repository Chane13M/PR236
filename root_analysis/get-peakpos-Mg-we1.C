{
  // Use CUTbasic, CUTlimits as defined in read-gates-we?.C
 
  char name[128];

  // mylar runs, WE1
  //Int_t nrofruns=2; 
  //Int_t run_no[128]={1071,1102};
  //Int_t run_no[128]={1021,1030,1031,1071,1102};

  // 26Mg runs, WE1
  //Int_t nrofruns=8; 
  //Int_t run_no[128]={1093,1100,1104,1108,1112,1117,1123,1128};

  // WE3, 24Mg
  Int_t nrofruns=7; 
  Int_t run_no[]={3151,3077,3081,3106,3138,3142,3146};

  // WE3, 13C
  //Int_t nrofruns=1; 
  //Int_t run_no[128]={1104};

  //TF1 *fit = new TF1("fit","gaus(0) + pol1(3)",1,800);

  Double_t a0,a1,a2,a3,a4,norm;
  Double_t width = 5.;
  Double_t par[5];


  Float_t peakposition[nrofruns];
  Float_t sigma[nrofruns];

  for(Int_t i=0;i<nrofruns;i++)	{
	  sprintf(name,"~/K600/Data/PR236/sorted0%4d.root",run_no[i]);
          cout << name << endl;
	  TFile *_file0 = TFile::Open(name);     
  	  TH1F *hX1pos = new TH1F("hX1pos","X1 Position",4000,0.,800.);
          DATA->Draw("X1posC>>hX1pos",CUTbasic && CUTlimits,"");

/*
	  norm = hX1pos->Integral(3000,3300);
	  norm=norm/300.;
          cout << "norm" << norm << endl;
	  fit->SetParameters(1.*norm,592.,1.,norm,0.);
	  fit->SetParLimits(0,0,1e9);
*/

	  //hX1pos->Fit("gaus","R","",649,656);       // for 24Mg
	  hX1pos->Fit("gaus","R","",678,688);       // for Mg run 1064 and after
	  //hX1pos->Fit("gaus","R","",610,616);    // for mylar run 1071 and after


//	  fit->GetParameters(par);

	  gaus->GetParameters(par);

	  //a0=par[0];a1=par[1];a2=par[2];a3=par[3];
          //cout << endl << " par0 " << a0 <<"; par1 " << a1 <<"; par2 " << a2 << "; par3 "<< a3 << "; par4 "<< a4<< endl << endl;

          peakposition[i] = par[1];
          sigma[i] = par[2];

	  c1->Modified(); c1->Update();
	  c1->WaitPrimitive(); 
  }
  for(Int_t i=0;i<nrofruns;i++)	{
     cout << " "<< run_no[i] <<" "<< peakposition[i] <<" "<< sigma[i] << endl;
  }
  for(Int_t i=0;i<nrofruns;i++)	{
     cout << ""<< run_no[i] <<"  Difference compared with run "<<run_no[0] <<"  "<< peakposition[i]-peakposition[0] << endl;
  }
 
  for(Int_t i=0;i<nrofruns;i++)	{
     cout << "        case "<< run_no[i] <<": x1offset="<< peakposition[i]-peakposition[0] <<"\; printf(\"run %d: x1 offset= %f \\n\",runinfo2.run_number,x1offset); break;   "<< endl;
  }



}




