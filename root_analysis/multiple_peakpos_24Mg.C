{
  char name[128];
  char text[128];

  Int_t peak_no=2;

  Double_t fitgauslow[0]=680;  // to define range where gauss fitting is done
  Double_t fitgaushi[0]=686;   // to define range where gauss fitting is done
  Double_t fitcombinedlow[0]=679;    // range over which fitting is performed
  Double_t fitcombinedhi[0]=687;	  // range over which fitting is performed
  Double_t rangelow[0]=fitcombinedlow[0];    // range of TF1 fit
  Double_t rangehi[0]=fitcombinedhi[0];     // range of TF1 fit


  Double_t fitgauslow[1]=570;  // to define range where gauss fitting is done
  Double_t fitgaushi[1]=576;   // to define range where gauss fitting is done
  Double_t fitcombinedlow[1]=568;    // range over which fitting is performed
  Double_t fitcombinedhi[1]=578;	  // range over which fitting is performed
  Double_t rangelow[1]=fitcombinedlow[1];    // range of TF1 fit
  Double_t rangehi[1]=fitcombinedhi[1];     // range of TF1 fit


  Double_t fitgauslow[2]=492;  // to define range where gauss fitting is done
  Double_t fitgaushi[2]=505;   // to define range where gauss fitting is done
  Double_t fitcombinedlow[2]=489;    // range over which fitting is performed
  Double_t fitcombinedhi[2]=507;	  // range over which fitting is performed
  Double_t rangelow[2]=fitcombinedlow[2];    // range of TF1 fit
  Double_t rangehi[2]=fitcombinedhi[2];     // range of TF1 fit

  Int_t nrofpeaks=2;  
 
  // for first pass fit: only gaussian
  Double_t par[5];
  Double_t peakposition[nrofpeaks];
  Double_t sigma[nrofpeaks];
  Double_t strength[nrofpeaks];

  // for fit with gaussian plus polynomial
  Double_t peakposition2[nrofpeaks];
  Double_t sigma2[nrofpeaks];
  Double_t pol0=100,pol1=0;
  //specify rangelow and rangehi as follows: rangelow[0]
  TF1 *fit = new TF1("fit","gaus(0)+pol2(3)",rangelow,rangehi);
  //TF1 *fit = new TF1("fit","gaus(0)",rangelow,rangehi);
  Double_t par2[5];

  for(Int_t i=0;i<nrofpeaks;i++)	{
	  sprintf(text,"fitting for peak",peak_no[i]);
          cout << text << endl;
	  sprintf(name,"peak number",peak_no[i]);
	  TFile *_file0 = TFile::Open(name);     
      //The above line may not be needed as we are working with only one file

	  cout<<"First fitting a single gaussian..."<<endl;
  	  TH1F *hX1pos = new TH1F("hX1pos","X1 Position",1200,500.,800.);
          DATAChain->Draw("X1posC>>hX1pos",CUTbasic && CUTlimits,"");
	  hX1pos->Fit("gaus","QR","",fitgauslow[i],fitgaushi[i]);  // for Mg run 1064 and earlier
	  //if(run_no[i]<1080)  hX1pos->Fit("gaus","QR","",fitgauslow,fitgaushi);  // for Mg run 1064 and earlier
	  //if(run_no[i]>1080)  hX1pos->Fit("gaus","QR","",fitgauslow+7,fitgaushi+7);  // for Mg run 1064 and after
	  //if(run_no[i]>1150)  hX1pos->Fit("gaus","QR","",fitgauslow+12,fitgaushi+12);  // for Mg run 1064 and after
	  gaus->GetParameters(par);
          strength[i] = par[0];
          peakposition[i] = par[1];
          sigma[i] = par[2];
	  c1->Modified(); c1->Update();
	  //c1->WaitPrimitive();
 
	  cout<<"Now use the gaussian fit as a starting point for a fit of a gaussian and a polynomial"<<endl;
	  fit->SetParameters(strength[i],peakposition[i],sigma[i],pol0,pol1);
          hX1pos->Fit("fit","QR","",fitcombinedlow[i],fitcombinedhi[i]);
          //if(run_no[i]<1080) hX1pos->Fit("fit","QR","",fitcombinedlow,fitcombinedhi);
          //if(run_no[i]>1080) hX1pos->Fit("fit","QR","",fitcombinedlow+5,fitcombinedhi+10);
          fit->GetParameters(par2);
          peakposition2[i] = par2[1];
          sigma2[i] = par2[2];
	  c1->Modified(); c1->Update();
	  //c1->WaitPrimitive(); 
  }
  cout << endl;
  cout << "First pass fit: extract estimates for gaussian position and width: "<< endl;
  for(Int_t i=0;i<nrofpeaks;i++)	{
    	 cout << "Peak number: "<< peak_no[i] <<"  Peak position: "<< peakposition[i] <<"  Peak sigma:"<< sigma[i] << endl;
  }	  
  cout << endl;
  cout << "Final fit: gaussian plus a polynomial: "<< endl;
  for(Int_t i=0;i<nrofpeaks;i++)	{
     cout << "Run nr: "<< peak_no[i] <<"  Peak position: "<< peakposition2[i] <<"  Peak sigma:"<< sigma2[i] << endl;
  }
  cout << endl;
  cout << "Note the difference between fitting a single gaussian compared to a more complete fit... "<< endl;
  cout << "-----------------------------------------------------"<< endl; 
  cout << endl;
  //cout << "Copy the following into your x1 position offset file: "<< endl;
  //cout << endl;
  for(Int_t i=0;i<nrofpeaks;i++)	{
     cout <<  peak_no[i] <<"  "<< peakposition2[0] - peakposition2[i]<< endl;
  }



}
