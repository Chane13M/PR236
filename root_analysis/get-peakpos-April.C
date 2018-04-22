{
  // Use CUTbasic, CUTlimits as defined elsewhee 
  char name[128];
  char text[128];

  //PR260, 0degr, 24Mg
/*  Int_t run_no[]={1041,1045,1051,1084,1090,1094,1099,1105,1112,1117,1123,1128,1133,1138,1144,1149};
  //Int_t run_no[]={1041,1165};
  Double_t fitgauslow=675;  // to define range where gauss fitting is done
  Double_t fitgaushi=684;   // to define range where gauss fitting is done
  //Double_t fitgauslow=675;   // to define range where gauss fitting is done
  Double_t fitcombinedlow=670;    // range over which fitting is performed
  Double_t fitcombinedhi=685;	  // range over which fitting is performed
  Double_t rangelow=fitcombinedlow;    // range of TF1 fit
  Double_t rangehi=fitcombinedhi;     // range of TF1 fit
*/

/*
//PR260, 0degr, 24Mg for Mylay and 12C calibration
  Int_t run_no[]={1157,1165};
  Double_t fitgauslow=690;  // to define range where gauss fitting is done
  Double_t fitgaushi=695;   // to define range where gauss fitting is done
  Double_t fitcombinedlow=688;    // range over which fitting is performed
  Double_t fitcombinedhi=696;	  // range over which fitting is performed
  Double_t rangelow=fitcombinedlow;    // range of TF1 fit
  Double_t rangehi=fitcombinedhi;     // range of TF1 fit
*/

//PR236 for 24Mg
  //Int_t run_no[]={3151,3077,3081,3106,3138,3142,3146};
  Int_t run_no[]={1128,1093,1100,1104,1108,1112,1117,1123};
  Double_t fitgauslow=650;  // to define range where gauss fitting is done
  Double_t fitgaushi=655;   // to define range where gauss fitting is done
  Double_t fitcombinedlow=640;    // range over which fitting is performed
  Double_t fitcombinedhi=660;	  // range over which fitting is performed
  Double_t rangelow=fitcombinedlow;    // range of TF1 fit
  Double_t rangehi=fitcombinedhi;     // range of TF1 fit


/*  //PR260, 0 degr, 48Ca
  Int_t run_no[]={1042,1036,1047,1053,1085,1091,1096,1101,1106,1113,1119,1125,1130,1135,1140,1146,1151};
  //Int_t run_no[]={1042};
  Double_t fitgauslow=730;  // to define range where gauss fitting is done
  Double_t fitgaushi=740;   // to define range where gauss fitting is done
  Double_t fitcombinedlow=720;    // range over which fitting is performed
  Double_t fitcombinedhi=745;	  // range over which fitting is performed
  Double_t rangelow=fitcombinedlow;    // range of TF1 fit
  Double_t rangehi=fitcombinedhi;     // range of TF1 fit
*/

/*  //PR260, 0 degr, 44Ca
  Int_t run_no[]={1043,1037,1048,1054,1087,1092,1097,1102,1107,1114,1115,1120,1126,1131,1136,1141,1147}; //1038 removed
  //Int_t run_no[]={1102,1107,1136};
  Double_t fitgauslow=592;  // to define range where gauss fitting is done
 Double_t fitgaushi=599;   // to define range where gauss fitting is done
  Double_t fitcombinedlow=590;    // range over which fitting is performed
  Double_t fitcombinedhi=600;	  // range over which fitting is performed
  Double_t rangelow=fitcombinedlow;    // range of TF1 fit
  Double_t rangehi=fitcombinedhi;     // range of TF1 fit
*/

/*  //PR260, 0 degr, 42Ca
  Int_t run_no[]={1044,1039,1049,1050,1089,1093,1098,1103,1108,1116,1122,1127,1132,1137,1143,1148};  //1142 too short to care about
  //Int_t run_no[]={1050};
  Double_t fitgauslow=591;  // to define range where gauss fitting is done
  Double_t fitgaushi=599;   // to define range where gauss fitting is done
  Double_t fitcombinedlow=590;    // range over which fitting is performed
  Double_t fitcombinedhi=600;	  // range over which fitting is performed
  Double_t rangelow=fitcombinedlow;    // range of TF1 fit
  Double_t rangehi=fitcombinedhi;     // range of TF1 fit
*/

  //PR260, 0 degr, mylar
  //Int_t run_no[]={1153,1154,1159,1160,1162};

  //PR260, 0 degr, 12C
  //Int_t run_no[]={1155,1156,1163};


  Int_t nrofruns=sizeof(run_no)/sizeof(run_no[0]);  
 
  // for first pass fit: only gaussian
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

  for(Int_t i=0;i<nrofruns;i++)	{
	  sprintf(text,"-------- Fitting run nr %4d:",run_no[i]);
          cout << text << endl;
	  sprintf(name,"~/K600/Data/PR236/sorted0%4d.root",run_no[i]);
	  TFile *_file0 = TFile::Open(name);     

	  cout<<"First fitting a single gaussian..."<<endl;
  	  TH1F *hX1pos = new TH1F("hX1pos","X1 Position",1200,500.,800.);
          DATA->Draw("X1posC>>hX1pos",CUTbasic && CUTlimits,"");
	  hX1pos->Fit("gaus","QR","",fitgauslow,fitgaushi);  // for Mg run 1064 and earlier
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
          hX1pos->Fit("fit","QR","",fitcombinedlow,fitcombinedhi);
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




