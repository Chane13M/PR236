{
  TChain *DATAChain = new TChain("DATA","MEGA Tree");
  char name[128];    

  // 26Mg
  Int_t nrofruns=7;
  Int_t run_no[128]={3151,3077,3081,3106,3138,3142,3146};


  for(Int_t i=0;i<nrofruns;i++)	{
	  sprintf(name,"/home/chane/K600/Data/PR236/sorted0%4d.root",run_no[i]);
          cout<< name<<endl;
	  DATAChain->Add(name);
  } 
 

}


