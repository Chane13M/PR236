
{
  TChain *DATAChain = new TChain("DATA","MEGA Tree");
  char name[128];    

  // 26Mg
  Int_t nrofruns=24;
  Int_t run_no[128]={3151,3073,3077,3081,3086,3090,3094,3098,3102,3106,3111,3119,3124,3125,3129,3133,3138,3142,3146,3155,3159,3163,3167,3171};


  for(Int_t i=0;i<nrofruns;i++)	{
	  sprintf(name,"/home/chane/K600/Data/PR236/sorted0%4d.root",run_no[i]);
          cout<< name<<endl;
	  DATAChain->Add(name);
  } 
 

}


