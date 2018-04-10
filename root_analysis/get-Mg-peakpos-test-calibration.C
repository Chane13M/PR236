{
  char name[128];

  int nrofpeaks=6;
  Float_t peakposition[nrofpeaks];
  Float_t sigma[nrofpeaks];
  Float_t low[nrofpeaks];
  Float_t high[nrofpeaks];
  Float_t ExNNDC[nrofpeaks];

  low[0]=9.25;   high[0]=9.35;
  low[1]=10.61;  high[1]=10.75;
  low[2]=11.66;   high[2]=11.79;
  low[3]=13.8;   high[3]=13.92;
  low[4]=15.17;   high[4]=15.31;
  low[5]=16.75;   high[5]=16.94;
  //low[6]=12.77;   high[6]=12.86;
  //low[7]=12.91;   high[7]=13.;
  //low[8]=13.84;   high[8]=13.92;

  ExNNDC[0]=9.30539;
  ExNNDC[1]=10.6797;
  ExNNDC[2]=11.7281;
  ExNNDC[3]=13.85;
  ExNNDC[4]=15.25;
  ExNNDC[5]=16.88;
  //ExNNDC[6]=12.8159;
  //ExNNDC[7]=12.9549;
  //ExNNDC[8]=13.879;

  for(Int_t i=0;i<nrofpeaks;i++){
    sprintf(name,"hEx->Fit(\"gaus\",\"\",\"\",%f,%f);",low[i],high[i]);
    gROOT->ProcessLine(name);
    peakposition[i] = hEx->GetFunction("gaus")->GetParameter(1);
    sigma[i] = hEx->GetFunction("gaus")->GetParameter(2);

	c1->Modified(); c1->Update();
	c1->WaitPrimitive();    // if you want to use see event by event, by using 'enter' 
  }    

  for(Int_t i=0;i<nrofpeaks;i++){
    cout << "peak #"<< i+1 << ":   position = " << peakposition[i] <<"      sigma = " << sigma[i] << endl;
  }

  for(Int_t i=0;i<nrofpeaks;i++){
    cout << "peak #"<< i+1 << ":   ExNNDC = " << ExNNDC[i] <<"      ExNNDC-ExEXP (keV) = " << 1000*(ExNNDC[i]-peakposition[i])<< endl;
  }



}


