{
  // For PR236 WE2 run 2155 which is a 24Mg run  
 
  
    Float_t centroids[]= {440.2, 491.8, 536.8, 604.3, 636.7, 680.6};
   //Float_t centroids[]= {453.3, 503., 547.5, 614.2, 646.4, 689.};
  //Float_t centroids[]= {503., 547.5, 614.2, 646.4, 689.};
  Int_t nrofpeaks=sizeof(centroids)/sizeof(centroids[0]);  
  cout<< "We will fit "<<nrofpeaks<<" peaks!"<<endl;

  Float_t peakwidths[]= {3., 2., 1., 1., 1., 1.};
  //Float_t peakwidths[]= {2., 1., 1., 1., 1.};
  Int_t nrofpeakwidths=sizeof(peakwidths)/sizeof(peakwidths[0]);
  if(nrofpeaks != nrofpeakwidths) cout<< "The peakwidth array is of different length!"<<endl;

  Float_t ExNNDC[]= {16.88, 15.25, 13.85, 11.727, 10.680, 9.30539 };
  //Float_t ExNNDC[]= {15.25, 13.85, 11.727, 10.680, 9.305 };
  Int_t nrofExNNDC=sizeof(ExNNDC)/sizeof(ExNNDC[0]);
  if(nrofpeaks != nrofExNNDC) cout<< "The ExNNDC array is of wrong length!"<<endl;

  Float_t Rigidity[]= {3944.661905996,3962.7473541235,3978.2093104017,4001.5201361728,4012.9833390216,4027.9563887701};

  Int_t nrofRigidity=sizeof(Rigidity)/sizeof(Rigidity[0]);
  if(nrofpeaks != nrofRigidity) cout<< "The Rigidity array is of wrong length!"<<endl;

//---------------------------------------------------------------------------

  Double_t par[5];
  //Double_t peakposition[nrofpeaks];
  Float_t peakposition[nrofpeaks];
  //Double_t sigma[nrofpeaks];
  Float_t sigma[nrofpeaks];

  Float_t peakmin=0.0;
  Float_t peakmax=0.0;
TCanvas *c3= new TCanvas("c3","c3",1700,10,1100,500);

  for(Int_t i=0;i<nrofpeaks;i++)	{

	  peakmin= centroids[i]-2.5*peakwidths[i]/2.;
	  peakmax= centroids[i]+2.5*peakwidths[i]/2.;
          cout << endl << " peakmin " << peakmin <<"; peakmax " << peakmax <<endl;

	  hX1pos1->Fit("gaus","R","",peakmin,peakmax);    

	  gaus->GetParameters(par);
          peakposition[i] = par[1];
          sigma[i] = par[2];

	  c3->Modified(); c3->Update();
	  c3->WaitPrimitive(); 
  }

  for(Int_t i=0;i<nrofpeaks;i++)	{
     cout << " "<<ExNNDC[i] <<"  "<< peakposition[i] <<" "<< sigma[i] << endl;
  }
  if(nrofpeaks != nrofExNNDC) cout<< "The ExNNDC array is of wrong length!"<<endl;
  if(nrofpeaks != nrofpeakwidths) cout<< "The peakwidth array is of different length!"<<endl;

//---------------------------------------------------------------------

  TCanvas *c2= new TCanvas("c2","c2",1700,10,1100,500);
  c2->cd();

  TGraph * GREx;
  GREx = new TGraph(nrofpeaks,peakposition,ExNNDC);
  //GREx = new TGraph(nrofpeaks,peakposition,Rigidity);
  GREx->SetMarkerColor(1);
  GREx->SetMarkerStyle(20);
  GREx->SetMarkerSize(0.65);
  GREx->SetLineStyle(3);
  GREx->GetXaxis()->SetTitle("Position (mm)");
  GREx->GetYaxis()->SetTitle("Ex (MeV)");
  GREx->Draw();

  //TF1 *fitEx = new TF1("fitEx","[0] + [1]*x + [2]*x*x + [3]*x*x*x",400.,750.);
  TF1 *fitEx = new TF1("fitEx","[0] + [1]*x + [2]*x*x ",400.,750.);
  GREx->Fit("fitEx","");

//---------------------------------------------------------------------
  Double_t fitpar[5];

  fitEx->GetParameters(fitpar);
  double a,b,c,d;
  a = fitpar[0];
  b = fitpar[1];
  c = fitpar[2];
  d = fitpar[3];
  
  double calcEx[nrofpeaks];
  for(Int_t i=0;i<nrofpeaks;i++){  
     calcEx[i]= a + b*peakposition[i] + c*peakposition[i]**2 +d*peakposition[i]**3;
 
     cout << " "<<ExNNDC[i] <<"  "<< calcEx[i] <<" Diff = "<< 1000*(ExNNDC[i] - calcEx[i]) <<" keV" << endl;
  }

 //     cout <<  a + b*453.3 + c*453.3**2 +d*453.3**3 <<endl;


}




