{
  
  //char name[128];
	char *name2; 
	name2 = new char[128];

  // Make sure that the run numbers below are applicable to your experiment. Also make sure that the nrofruns matches the number of run numbers you put in when you list them. 
  Int_t nrofruns=10;
  Int_t run_no[128]={2128,1069,1072,1078,1085,1090,1091,1098,1103,1109};
//run 02128 is just a copy of run 00128 
 
  float *peakposition;
  float *sigma;
  peakposition = new float[nrofruns];
  sigma = new float[nrofruns]; 

// You see below that you make use of CUTs which you made previously. Have you remembered to read them in? Also make sure that the values below are suitable for your data as well. Check the Y limits and remove any references to CUTs you might not use (i.e. (a,a') experiments won't have CUTpad2tof and CUTpad1pad2)

// Note: I do not have an "X2flag==0" condition. This is because, in my case, the efficiency of X2 was bad. This meant that I could not use any information from X2 so including any condition related to it would have made my data vulnerable to that. 

  TCut CUTbasic = "CUTpad1tof & CUTpad2tof && CUTpad1pad2 && CUTtofX1 && X1flag==0 && U2flag==0 && U1flag==0";
  TCut CUTlimits = "X1pos>-100 && ThSCAT>-3.0 && ThSCAT<3.0";
  TCut CUTY = "Y1>-25 && Y1<15"; 
 
  for(Int_t i=0;i<nrofruns;i++)	{
	  sprintf(name2,"/home/lindsay/DATA2/ROOT/run0%4d.root",run_no[i]);
          cout << name2 << endl;
	  TFile *_file0 = TFile::Open(name2); 
	  TTree *smokey_oakie = (TTree*)_file0->FindObjectAny("DATA"); //Courtesy of Padsley
	  smokey_oakie->Print(); 		    
 	  TH1F *hX1pos = new TH1F("hX1pos","X1 Position",4000,0.,800.);
	  smokey_oakie->Draw("X1posC>>hX1pos",CUTbasic && CUTlimits && CUTY,""); 
// (Coding note to myself: This used to be DATA->Draw() but that is what caused the issues. When it opens the first file, it finds a TTree called 'DATA' and so whenever we try to use 'DATA' afterwards, it will refer to that same TTree. So by sourcing the TTree from the open file (smokey_oakie = (TTree*)...), you ensure that you are using the TTree in the current file for the calculation rather than the previous one.)

// It is important that you make sure that the region defined below (i.e. 645 -> 655 in this example) is valid for your own spectra. You need to fit the same peak in each run so pick a prominent peak and note its position and limits you can use to fit it. Do not make this region too narrow since you must allow for the fact that some spectra might have shifted and so a very narrow region might mean that you no longer find the peak you're looking for depending on the run.  
	  
          hX1pos->Fit("gaus","","",645,655);
          peakposition[i] = hX1pos->GetFunction("gaus")->GetParameter(1);
          sigma[i] = hX1pos->GetFunction("gaus")->GetParameter(2);
	 // c1->Modified(); c1->Update(); c1->WaitPrimitive();
  }
  for(Int_t i=0;i<nrofruns;i++)	{
     cout << " "<< run_no[i] <<" "<< peakposition[i] <<" "<< sigma[i] << endl;
  }
  for(Int_t i=0;i<nrofruns;i++)	{
     cout << ""<< run_no[i] <<"  Difference compared with run "<<run_no[0] <<"  "<< peakposition[i]-peakposition[0] << endl;
  }

delete name2;
}

