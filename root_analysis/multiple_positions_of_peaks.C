{
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    //                   This script is used to get the X1 peak position for multiple peaks             //
    //             these peaks will be assigned to well-documented excited states at a later stage      //
    //                                          Chane Moodley                                           //
    //////////////////////////////////////////////////////////////////////////////////////////////////////
  char name[128];

  int nrofpeaks=10;
  Float_t peakposition[nrofpeaks];
  Float_t sigma[nrofpeaks];
  Float_t low[nrofpeaks];
  Float_t high[nrofpeaks];
  Float_t ExNNDC[nrofpeaks];

  low[0]=680;   high[0]=686; //9.305 MeV
  low[1]=648;   high[1]=652;
  low[2]=637;   high[2]=642;
  low[3]=612;   high[3]=617;
  low[4]=606;   high[4]=611; //11.278 MeV
  low[5]=601;   high[5]=606;
  low[6]=538;   high[6]=550;
  low[7]=495;   high[7]=505; //15.25 MeV
  low[8]=480;   high[8]=488;
  low[9]=442;   high[9]=454;

  ExNNDC[0]=9.30539;
  ExNNDC[1]=11.7281;
  ExNNDC[2]=15.25;
  ExNNDC[3]=8;
  ExNNDC[4]=7;
  ExNNDC[5]=6;
  ExNNDC[6]=5;
  ExNNDC[7]=4;
  ExNNDC[8]=3;
  ExNNDC[9]=2;

  for(Int_t i=0;i<nrofpeaks;i++){
    sprintf(name,"hExdiff->Fit(\"gaus\",\"\",\"\",%f,%f);",low[i],high[i]);
    gROOT->ProcessLine(name);
    peakposition[i] = hExdiff->GetFunction("gaus")->GetParameter(1);
    sigma[i] = hExdiff->GetFunction("gaus")->GetParameter(2);

	//c1->Modified(); c1->Update();
	//c1->WaitPrimitive(); 
  }    

  for(Int_t i=0;i<nrofpeaks;i++){
    cout << "peak #"<< i+1 << ":   position = " << peakposition[i] <<"      sigma = " << sigma[i] << endl;
  }

  for(Int_t i=0;i<nrofpeaks;i++){
    cout << "peak #"<< i+1 << ":   ExNNDC = " << ExNNDC[i] <<"      ExNNDC-ExEXP (keV) = " << 1000*(ExNNDC[i]-peakposition[i])<< endl;
  }



}


