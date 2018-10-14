{
  TChain *DATAChain = new TChain("DATA","MEGA Tree");
  char name[128];

  // 58Ni
  Int_t nrofruns=8;
  Int_t run_no[128]={3084, 3092, 3100, 3109, 3116, 3128, 3137, 3145};


  for(Int_t i=0;i<nrofruns;i++)	{
	  sprintf(name,"/home/chane/K600/Data/PR236/sorted0%4d.root",run_no[i]);
          cout<< name<<endl;
	  DATAChain->Add(name);
  } 
 

}

