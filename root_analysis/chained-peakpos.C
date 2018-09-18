{////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                //  
//                                 Chane Moodley                                                                 //
//                                                                                                              //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  char name[128];
  char text[128];

  Double_t fitgauslow=650;  // to define range where gauss fitting is done
  Double_t fitgaushi=655;   // to define range where gauss fitting is done
  Double_t fitcombinedlow=640;    // range over which fitting is performed
  Double_t fitcombinedhi=660;	  // range over which fitting is performed
  Double_t rangelow=fitcombinedlow;    // range of TF1 fit
  Double_t rangehi=fitcombinedhi;     // range of TF1 fit

  Double_t par[5];
  Double_t peakposition[nrofruns];
  Double_t sigma[nrofruns];
  Double_t strength[nrofruns];

  // for fit with gaussian plus polynomial
  Double_t peakposition2[nrofruns];
  Double_t sigma2[nrofruns];
  Double_t pol0=100,pol1=0;
  TF1 *fit = new TF1("fit","gaus(0)+pol2(3)",rangelow,rangehi);
  //TF1 *fit = new TF1("fit","gaus(0)",rangelow,rangehi);
  Double_t par2[5];
  cout<<"First fitting a single gaussian..."<<endl;
  TH1F *hX1pos = new TH1F("hX1pos","X1 Position",1200,500.,800.);
  DATA->Draw("X1posC>>hX1pos",CUTbasic && CUTlimits,"");
  hX1pos->Fit("gaus","QR","",fitgauslow,fitgaushi);  // for Mg run 1064 and earlier
      gaus->GetParameters(par);
          strength[i] = par[0];
          peakposition[i] = par[1];
          sigma[i] = par[2];
	  c1->Modified(); c1->Update();
	  //c1->WaitPrimitive();
 
    cout<<"Now use the gaussian fit as a starting point for a fit of a gaussian and a polynomial"<<endl;
	  fit->SetParameters(strength[i],peakposition[i],sigma[i],pol0,pol1);
          hX1pos->Fit("fit","QR","",fitcombinedlow,fitcombinedhi);
          fit->GetParameters(par2);
          peakposition2[i] = par2[1];
          sigma2[i] = par2[2];
	  c1->Modified(); c1->Update();
	  //c1->WaitPrimitive(); 
  }
  cout << endl;
  cout << "First pass fit: extract estimates for gaussian position and width: "<< endl;
  for(Int_t i=0;i<nrofruns;i++)	{
    	 cout << "Run nr: "<< run_no[i] <<"  Peak position: "<< peakposition[i] <<"  Peak sigma:"<< sigma[i] << endl;
  }	  
  cout << endl;
  cout << "Final fit: gaussian plus a polynomial: "<< endl;
  for(Int_t i=0;i<nrofruns;i++)	{
     cout << "Run nr: "<< run_no[i] <<"  Peak position: "<< peakposition2[i] <<"  Peak sigma:"<< sigma2[i] << endl;
  }
  cout << endl;
  cout << "Note the difference between fitting a single gaussian compared to a more complete fit... "<< endl;
  cout << "-----------------------------------------------------"<< endl; 
  cout << endl;
  cout << "Copy the following into your x1 position offset file: "<< endl;
  cout << endl;
  for(Int_t i=0;i<nrofruns;i++)	{
     cout <<  run_no[i] <<"  "<< peakposition2[0] - peakposition2[i]<< endl;
  }



}




