{

  char name[128];

  // 13C; we3
  Int_t nrofruns=5;
  Int_t run_no[128]={1128,1093,1100,1104,1108,1112,1117,1123};

  Int_t CI_cnt[nrofruns];
  Int_t Clock_cnt[nrofruns];

  for(Int_t i=0;i<nrofruns;i++)	{
	  sprintf(name,"~/K600/Data/PR236/run0%4d.root",run_no[i]);
          cout<< name<<endl;
	  TFile *_file0 = TFile::Open(name);          
	  cout<< Scaler_CIU->GetEntries() <<endl;
	  CI_cnt[i]=Scaler_CIU->GetEntries();
	  Clock_cnt[i]=Scaler_ClockU->GetEntries();
	  //_file0->Close();
  }

  Int_t sumci=0;
  Int_t sumclock=0;
  for(Int_t i=0;i<nrofruns;i++)	{
    //cout<< CI_cnt[i] <<endl;
    sumci=sumci+CI_cnt[i];	
    sumclock=sumclock+Clock_cnt[i];	
  }
  cout<<" Total CI =" << sumci << endl;
  cout<<" Total time =" << sumclock << endl;

}


