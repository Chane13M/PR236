{
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    //                   This script is used to get the X1 peak position for multiple peaks             //
    //             these peaks will be assigned to well-documented excited states at a later stage      //
    //                                          Chane Moodley                                           //
    //////////////////////////////////////////////////////////////////////////////////////////////////////
  char name[128];

  int nrofpeaks=3;
  Float_t peakposition[nrofpeaks];
  Float_t sigma[nrofpeaks];
  Float_t low[nrofpeaks];
  Float_t high[nrofpeaks];
  Float_t ExNNDC[nrofpeaks];

  low[0]=680;   high[0]=686;
  low[1]=571.5;   high[1]=579;
  low[2]=495;   high[2]=505;

  ExNNDC[0]=9.30539;
  ExNNDC[1]=11.7281;
  ExNNDC[2]=15.25;
    
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


