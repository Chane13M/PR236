{
  //gROOT->Reset();
  // needed for this script: gatefiles on CUTbasic && CUTtofX1 

TCut CUTbasic = "tof>6325 && tof<6391 && pad1>170 && pad1<623 && pad2>300 && pad2<830";      //CUTpad1tof ";

//======================================================================
  c2 = new TCanvas("c2","Efficiency",10,10,800,800);
  c2->SetFillColor(0);
  c2->SetGridy(0);

  TPad* pad2 = new TPad("pad2","Spectra",0.01,0.01,0.99,0.99);
  pad2->SetFillColor(0);
  pad2->Draw();
  pad2->cd();
  pad2->Divide(1,4);

//======================================================================
  pad2->cd(1);

  TH1F *hX1all =  new TH1F("hX1all","X1 position",1600,0,800.);
  TH1F *hX1allv2 =  new TH1F("hX1allv2","X1 position",1600,0,800.);
  TH1F *hX1good = new TH1F("hX1good","X1 position",1600,0,800.);
  TH1F *hX1eff =  new TH1F("hX1eff","Efficiency: X1 position",1600,0,800.);
  TH1F *hX1CF =  new TH1F("hX1CF","correction factor: X1 position",1600,0,800.);
  TH1F *hX1goodCOR = new TH1F("hX1goodCOR","Eff corrected X1 position",1600,0,800.);

  double allx1,allx1v2,goodx1;
  float effx1,effx1v2;

  DATA->Draw("X1pos>>hX1all",CUTbasic,""); 
  allx1=hX1all->GetEntries(); // this will also take events that have no X1 asigned e.g. still at -100
				 // if we used "->Intrgral()" then it would have been wrong.
  // what we really want is the number of events that made the PID
  // AND that had at least one wire of a particular wireplane fired.
  // The TTree variable you are looking for is X1effall!

  DATA->Draw("X1pos>>hX1allv2",CUTbasic && "X1effall==1",""); 
  allx1v2=hX1allv2->GetEntries();

  DATA->Draw("X1pos>>hX1good",CUTbasic && "X1effgood==1","same");
  goodx1=hX1good->GetEntries();

  effx1=100*float(goodx1)/float(allx1);
  effx1v2=100*float(goodx1)/float(allx1v2);

  hX1eff->Add(hX1good,1);
  hX1eff->Divide(hX1all);
  hX1eff->Draw();
  hX1eff->SetStats(0);

/*
  hX1CF->Add(hX1all,1);
  hX1CF->Divide(hX1good);
  hX1CF->SetLineColor(3);
  hX1CF->Draw("same");

  hX1goodCOR->Add(hX1good,1);
  hX1goodCOR->Multiply(hX1CF);
  hX1goodCOR->SetLineColor(2);
  
  hX1good->Draw();
  hX1goodCOR->Draw("same");
*/

//======================================================================
  pad2->cd(2);

  TH1F *hU1all =  new TH1F("hU1all","U1 position",1600,0,800.);
  TH1F *hU1allv2 =  new TH1F("hU1allv2","U1 position",1600,0,800.);
  TH1F *hU1good = new TH1F("hU1good","U1 position",1600,0,800.);
  TH1F *hU1eff =  new TH1F("hU1eff","Efficiency: U1 position",1600,0,800.);
  TH1F *hU1CF =  new TH1F("hU1CF","correction factor: U1 position",1600,0,800.);
  TH1F *hU1goodCOR = new TH1F("hU1goodCOR","Eff corrected U1 position",1600,0,800.);

  double allu1,allu1v2,goodu1;
  float effu1,effu1v2;

  DATA->Draw("U1pos>>hU1all",CUTbasic,""); 
  allu1=hU1all->GetEntries(); 
  
  DATA->Draw("U1pos>>hU1allv2",CUTbasic && "U1effall==1",""); 
  allu1v2=hU1allv2->GetEntries();

  DATA->Draw("U1pos>>hU1good",CUTbasic && "U1effgood==1","same");
  goodu1=hU1good->GetEntries();

  effu1=100*float(goodu1)/float(allu1);
  effu1v2=100*float(goodu1)/float(allu1v2);

  hU1eff->Add(hU1good,1);
  hU1eff->Divide(hU1all);
  hU1eff->Draw();
  hU1eff->SetStats(0);

/*
  hU1CF->Add(hU1all,1);
  hU1CF->Divide(hU1good);
  hU1CF->SetLineColor(3);
  hU1CF->Draw("same");

  hU1goodCOR->Add(hU1good,1);
  hU1goodCOR->Multiply(hU1CF);
  hU1goodCOR->SetLineColor(2);
  
  hU1good->Draw();
  hU1goodCOR->Draw("same");
*/

//======================================================================
  pad2->cd(3);

  TH1F *hX2all =  new TH1F("hX2all","X2 position",1600,0,800.);
  TH1F *hX2allv2 =  new TH1F("hX2allv2","X2 position",1600,0,800.);
  TH1F *hX2good = new TH1F("hX2good","X2 position",1600,0,800.);
  TH1F *hX2eff =  new TH1F("hX2eff","Efficiency: X2 position",1600,0,800.);
  TH1F *hX2CF =  new TH1F("hX2CF","correction factor: X2 position",1600,0,800.);
  TH1F *hX2goodCOR = new TH1F("hX2goodCOR","Eff corrected X2 position",1600,0,800.);

  double allx2,allx2v2,goodx2;
  float effx2,effx2v2;

  DATA->Draw("X2pos>>hX2all",CUTbasic,""); 
  allx2=hX2all->GetEntries(); 

  DATA->Draw("X2pos>>hX2allv2",CUTbasic && "X2effall==1",""); 
  allx2v2=hX2allv2->GetEntries();

  DATA->Draw("X2pos>>hX2good",CUTbasic && "X2effgood==1","same");
  goodx2=hX2good->GetEntries();

  effx2=100*float(goodx2)/float(allx2);
  effx2v2=100*float(goodx2)/float(allx2v2);

  hX2eff->Add(hX2good,1);
  hX2eff->Divide(hX2all);
  hX2eff->Draw();
  hX2eff->SetStats(0);

/*
  hX2CF->Add(hX2all,1);
  hX2CF->Divide(hX2good);
  hX2CF->SetLineColor(3);
  hX2CF->Draw("same");

  hX2goodCOR->Add(hX2good,1);
  hX2goodCOR->Multiply(hX2CF);
  hX2goodCOR->SetLineColor(2);
  
  hX2good->Draw();
  hX2goodCOR->Draw("same");
*/




//======================================================================
  pad2->cd(4);

  TH1F *hU2all =  new TH1F("hU2all","U2 position",1600,0,800.);
  TH1F *hU2allv2 =  new TH1F("hU2allv2","U2 position",1600,0,800.);
  TH1F *hU2good = new TH1F("hU2good","U2 position",1600,0,800.);
  TH1F *hU2eff =  new TH1F("hU2eff","Efficiency: U2 position",1600,0,800.);
  TH1F *hU2CF =  new TH1F("hU2CF","correction factor: U2 position",1600,0,800.);
  TH1F *hU2goodCOR = new TH1F("hU2goodCOR","Eff corrected U2 position",1600,0,800.);

  double allu2,allu2v2,goodu2;
  float effu2,effu2v2;

  DATA->Draw("U2pos>>hU2all",CUTbasic,""); 
  allu2=hU2all->GetEntries(); 

  DATA->Draw("U2pos>>hU2allv2",CUTbasic && "U2effall==1",""); 
  allu2v2=hU2allv2->GetEntries();

  DATA->Draw("U2pos>>hU2good",CUTbasic && "U2effgood==1","same");
  goodu2=hU2good->GetEntries();

  effu2=100*float(goodu2)/float(allu2);
  effu2v2=100*float(goodu2)/float(allu2v2);

  hU2eff->Add(hU2good,1);
  hU2eff->Divide(hU2all);
  hU2eff->Draw();
  hU2eff->SetStats(0);

/*
  hU2CF->Add(hU2all,1);
  hU2CF->Divide(hU2good);
  hU2CF->SetLineColor(3);
  hU2CF->Draw("same");

  hU2goodCOR->Add(hU2good,1);
  hU2goodCOR->Multiply(hU2CF);
  hU2goodCOR->SetLineColor(2);
  
  hU2good->Draw();
  hU2goodCOR->Draw("same");
*/


//================================================================================

  cout <<" good events: " << goodx1<< endl; 
  cout <<" all events: " << allx1<< endl;
  cout <<"X1 efficiency: good/all = " << effx1<< endl;
  cout <<"X1 efficiency: good/all-with-at-least-1-wire = " << effx1v2<< endl;

  cout <<" good events: " << goodu1<< endl; 
  cout <<" all events: " << allu1<< endl;
  cout <<"U1 efficiency: good/all = " << effu1<< endl;
  cout <<"U1 efficiency: good/all-with-at-least-1-wire = " << effu1v2<< endl;

  cout <<" good events: " << goodx2<< endl; 
  cout <<" all events: " << allx2<< endl;
  cout <<"X2 efficiency: good/all = " << effx2<< endl;
  cout <<"X2 efficiency: good/all-with-at-least-1-wire = " << effx2v2<< endl;

  cout <<" good events: " << goodu2<< endl; 
  cout <<" all events: " << allu2<< endl;
  cout <<"U2 efficiency: good/all = " << effu2<< endl;
  cout <<"U2 efficiency: good/all-with-at-least-1-wire = " << effu2v2<< endl;

  cout << " NOTE that the extra condition of \"at least 1 wire firing\" is only "<< endl;
  cout << " valuable if we know there are no \"hot\" wires in a wireplane."<< endl;

}



