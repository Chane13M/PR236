{
  TChain *DATAChain = new TChain("DATA","MEGA Tree");
  char name[128];

  // 90Zr
  Int_t nrofruns=7;
  Int_t run_no[128]={1095,1101,1106,1110,1116,1120,1126};


  for(Int_t i=0;i<nrofruns;i++)	{
	  sprintf(name,"/home/chane/K600/Data/PR236/sorted0%4d.root",run_no[i]);
          cout<< name<<endl;
	  DATAChain->Add(name);
  } 
 

}

