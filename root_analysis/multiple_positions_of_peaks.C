{
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    //                   This script is used to get the X1 peak position for multiple peaks             //
    //             these peaks will be assigned to well-documented excited states at a later stage      //
    //                                          Chane Moodley                                           //
    //////////////////////////////////////////////////////////////////////////////////////////////////////
  char name[128];

  int nrofpeaks=16;
  Float_t peakposition[nrofpeaks];
  Float_t sigma[nrofpeaks];
  Float_t low[nrofpeaks];
  Float_t high[nrofpeaks];
  Float_t ExNNDC[nrofpeaks];

  //24Mg for weekend 2
  low[0]=685;   high[0]=691; //9.305 MeV
  low[1]=654;   high[1]=658;
  low[2]=643;   high[2]=648;
  low[3]=617;   high[3]=622;
  low[4]=611;   high[4]=615; //11.278 MeV
  low[5]=578;   high[5]=582;
  low[6]=527;   high[6]=530;
  low[7]=500;   high[7]=506; //15.25 MeV
  low[8]=487;   high[8]=493;
  low[9]=447;   high[9]=458;
  low[10]=437;  high[10]=443;
  low[11]=426;  high[11]=431;
  low[12]=627;  high[12]=633;
  low[13]=561;  high[13]=565;
  low[14]=568;  high[14]=573;
  low[15]=517;  high[15]=520; 

//24Mg for weekend 3
/*
  low[0]=679;   high[0]=686; //9.305 MeV
  low[1]=650;   high[1]=653;
  low[2]=637;   high[2]=643;
  low[3]=613;   high[3]=618;
  low[4]=606;   high[4]=610; //11.278 MeV
  low[5]=602;   high[5]=606;
  low[6]=538;   high[6]=547;
  low[7]=495;   high[7]=502; //15.25 MeV
  low[8]=482;   high[8]=487;
  low[9]=441;   high[9]=454;
*/

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
  ExNNDC[10]=1;
  ExNNDC[11]=0;
  ExNNDC[12]=15;
  ExNNDC[13]=16;
  ExNNDC[14]=17;

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


