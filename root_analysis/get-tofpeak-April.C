{
  // Use CUTbasic, CUTlimits as defined in read-gates-we?.C
 
  char name[128];
 Int_t run_no[]={3151,3077,3081,3106,3138,3142,3146}; //WE3 24Mg
 //3077,3081,3106,3138,3142
 //3086,3094,3098,3102, useful
  //Int_t run_no[]={1128,1097,1103,1107,1111,1118,1121,1127};  //WE1 26Mg
  //Int_t run_no[]={1153,1154,1159,1160,1162};//Mylar
  //Int_t run_no[]={1044,1039,1049,1050,1089,1093,1098,1103,1108,1116,1122,1127,1132,1137,1143,1148};//42Ca
  //Int_t run_no[]={1043,1037,1048,1054,1087,1092,1097,1102,1107,1114,1115,1120,1126,1131,1136,1141,1147}; //44Ca
  //Int_t run_no[]={1041,1045,1051,1084,1090,1094,1099,1105,1112,1117,1123,1128,1133,1138,1144,1149}; //24Mg
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
  	  TH1F *htof = new TH1F("htof","TOF",700,2000.,6000.);
	  DATA->Draw("tof>>htof","","");
          //DATA->Draw("tof>>htof","pad1<1000","");
	  htof->Fit("gaus","QR","",4800,4860);  

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




