{
  TChain *DATAChain = new TChain("DATA","MEGA Tree");
  char name[128];

  // 58Ni
  Int_t nrofruns=7;
  Int_t run_no[128]={1097,1103,1107,1111,1118,1121,1127};


  for(Int_t i=0;i<nrofruns;i++)	{
	  sprintf(name,"/home/chane/K600/Data/PR236/sorted0%4d.root",run_no[i]);
          cout<< name<<endl;
	  DATAChain->Add(name);
  } 
 

}

