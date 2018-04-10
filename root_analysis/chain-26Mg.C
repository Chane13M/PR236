{
  TChain *DATAChain = new TChain("DATA","MEGA Tree");
  char name[128];

  // 26Mg
  Int_t nrofruns=8;
  Int_t run_no[128]={1128,1093,1100,1104,1108,1112,1117,1123};


  for(Int_t i=0;i<nrofruns;i++)	{
	  sprintf(name,"/home/chane/K600/Data/PR236/sorted0%4d.root",run_no[i]);
          cout<< name<<endl;
	  DATAChain->Add(name);
  } 
 

}

