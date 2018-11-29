{

  char name2[128];

  // 24Mg for weekend 3
  Int_t nrofruns=6;
  Int_t run_no[128]={2158,2160,2162,2166,2168,2169};


  //Int_t CIU_cnt[nrofruns];
  //Int_t CII_cnt[nrofruns];
  //Int_t TRIGU_cnt[nrofruns];
  //Int_t TRIGI_cnt[nrofruns];

	float *CIU_cnt = new float[nrofruns];
	float *CII_cnt = new float[nrofruns];
	float *TRIGU_cnt = new float[nrofruns];
	float *TRIGI_cnt = new float[nrofruns];


  for(Int_t i=0;i<nrofruns;i++)	{
	  sprintf(name2,"~/K600/Data/PR236/sorted0%4d.root",run_no[i]);
          cout<< name2<<endl;  		//displays the file name it is looking in while script is running
	  TFile *_file0 = TFile::Open(name2);          
	  cout<< Scaler_CIU->GetEntries() <<endl;	//displays CIU value for that file
	  cout<< Scaler_CII->GetEntries() <<endl;	//displays CII value for that file
	  cout<< Scaler_TriggerU->GetEntries() <<endl;	//displays TRIGU value for that file
	  cout<< Scaler_TriggerI->GetEntries() <<endl;	//displays TRIGI value for that file
	  CIU_cnt[i]=Scaler_CIU->GetEntries();
	  CII_cnt[i]=Scaler_CII->GetEntries();
	  TRIGU_cnt[i]=Scaler_TriggerU->GetEntries();
	  TRIGI_cnt[i]=Scaler_TriggerI->GetEntries();
	  //_file0->Close();
  }

  Int_t sumciu=0;
  Int_t sumcii=0;
  Int_t sumtrigu=0;
  Int_t sumtrigi=0;
 
  for(Int_t i=0;i<nrofruns;i++)	{
    
    sumciu=sumciu+CIU_cnt[i];
    sumcii=sumcii+CII_cnt[i];
    sumtrigu=sumtrigu+TRIGU_cnt[i];
    sumtrigi=sumtrigi+TRIGI_cnt[i];
  

  }


  cout<<" Total CIU = " << sumciu << endl;
  cout<<" Total CII = " << sumcii << endl;
  cout<<" Total TRIGU = " << sumtrigu << endl;
  cout<<" Total TRIGI = " << sumtrigi << endl;
  
  

}


