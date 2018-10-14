{
  TChain *DATAChain = new TChain("DATA","MEGA Tree");
  char name[128];

  // 90Zr
  Int_t nrofruns=6;
  Int_t run_no[128]={2158,2160,2162,2166,2168,2169};


  for(Int_t i=0;i<nrofruns;i++)	{
	  sprintf(name,"/home/chane/K600/Data/PR236/sorted0%4d.root",run_no[i]);
          cout<< name<<endl;
	  DATAChain->Add(name);
  } 
 

}

