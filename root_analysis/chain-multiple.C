{
  TChain *DATAChain1 = new TChain("DATA","MEGA Tree");
  TChain *DATAChain2 = new TChain("DATA","MEGA Tree");
  TChain *DATAChain3 = new TChain("DATA","MEGA Tree");
  TChain *DATAChain4 = new TChain("DATA","MEGA Tree");
  TChain *DATAChain5 = new TChain("DATA","MEGA Tree");
  char name[128];


  Char_t name1[30];
  sprintf(name1,".x ../SCRIPTS/histosPR170.C");
  gROOT->ProcessLine(name1);
  sprintf(name1,".x ../SCRIPTS/read-gates-tgt4-run21x.C");
  gROOT->ProcessLine(name1);

  TH1F *hX1pos1 = new TH1F("hX1pos1","X1 Position",2400,0.,800.);
  TH1F *hX1pos2 = new TH1F("hX1pos2","X1 Position",2400,0.,800.);
  TH1F *hX1pos3 = new TH1F("hX1pos3","X1 Position",2400,0.,800.);
  TH1F *hX1pos4 = new TH1F("hX1pos4","X1 Position",2400,0.,800.);
  TH1F *hX1pos5 = new TH1F("hX1pos5","X1 Position",2400,0.,800.);

  hX1pos2->SetLineColor(2);
  hX1pos3->SetLineColor(3);
  hX1pos4->SetLineColor(4);
  hX1pos5->SetLineColor(6);

  // PR170: all Jan11
  //Int_t run_no[]={21351,21097,21098,21099,21100,21101,21102,21103,21348,21349,21350,21352,21353,21359,21360,21361,21363,21364,21366,21368,21369,21370,21371,21373,21374,21375,21376,21381,21382,21383,21392,21393,21394,21395,21407,21408,21441,21442,21444,21445,21446,21447,21448,21449,21450,21451,21452,21453,21455,21456,21457,21458,21462,21463,21467,21468,21469,21470,21471};


  //PR170, pt, analysis group 3
  Int_t run_no1[]={21351,21352,21353,21359,21360,21361,21363,21364,21366,21368,21369,21370,21371,21373,21374,21375,21376,21381,21382,21383,21392,21393,21394,21395};
  //Int_t run_no2[]={21368,21369};
  Int_t nrofruns1=sizeof(run_no1)/sizeof(run_no1[0]);  

  //PR170, pt, analysis group 2
  Int_t run_no2[]={21348,21349,21350};
  Int_t nrofruns2=sizeof(run_no2)/sizeof(run_no2[0]);  

  //PR170, pt, analysis group 4
  Int_t run_no3[]={21407,21408};
  Int_t nrofruns3=sizeof(run_no3)/sizeof(run_no3[0]);  

  //PR170, pt, analysis group 5
  Int_t run_no4[]={21441,21442};
  Int_t nrofruns4=sizeof(run_no4)/sizeof(run_no4[0]);  

  //PR170, pt, analysis group 6
  Int_t run_no5[]={21444,21445,21446,21447,21448,21449,21450,21451,21452,21453,21455,21456,21457,21458,21462,21463,21467,21468,21469,21470,21471};
  Int_t nrofruns5=sizeof(run_no5)/sizeof(run_no5[0]);  

  //PR170, pt, target 5, run 29172 and onwards
  Int_t run_no[]={29172,29173,29174,29177,29178,29179,29180,29181,29182,29183,29184,29185,29201,29202,29210,29211,29212,29213,29214,29215,29216,29217,29219,29220,29221,29223,29224,29235,29242,29243,29244,29245,29246,29247,29248,29249,29250,29251,29252,29253,29254,29257,29258,29259,29260,29261,29262,29266,29267,29268,29276};

  for(Int_t i=0;i<nrofruns1;i++)	{
	  sprintf(name,"/FAST/run%5d.root",run_no1[i]);
          cout<< name<<endl;
	  DATAChain1->Add(name);
  }
  DATAChain1->Draw("X1posC>>hX1pos1",CUTbasic && CUTlimits,"");


  for(Int_t i=0;i<nrofruns2;i++)	{
	  sprintf(name,"/FAST/run%5d.root",run_no2[i]);
          cout<< name<<endl;
	  DATAChain2->Add(name);
  }
  DATAChain2->Draw("X1posC>>hX1pos2",CUTbasic && CUTlimits,"same");

  for(Int_t i=0;i<nrofruns3;i++)	{
	  sprintf(name,"/FAST/run%5d.root",run_no3[i]);
          cout<< name<<endl;
	  DATAChain3->Add(name);
  }
  DATAChain3->Draw("X1posC>>hX1pos3",CUTbasic && CUTlimits,"same");

  for(Int_t i=0;i<nrofruns4;i++)	{
	  sprintf(name,"/FAST/run%5d.root",run_no4[i]);
          cout<< name<<endl;
	  DATAChain4->Add(name);
  }
  DATAChain4->Draw("X1posC>>hX1pos4",CUTbasic && CUTlimits,"same");


  for(Int_t i=0;i<nrofruns5;i++)	{
	  sprintf(name,"/FAST/run%5d.root",run_no5[i]);
          cout<< name<<endl;
	  DATAChain5->Add(name);
  }
  DATAChain5->Draw("X1posC>>hX1pos5",CUTbasic && CUTlimits,"same");



}

hX1pos1->Draw();
hX1pos2->Draw("same");
hX1pos3->Draw("same");
hX1pos4->Draw("same");


  //DATAChain->Draw("thetaFP*(-0.5795 -0.0000457*X1pos) + (23.1-0.003541*X1pos):X1pos>>hThSCATvsX1",CUTbasic,"");
//the following is from Daniel
//DATAChain->SetAlias("newX1","X1pos + 0.1211*thetaSCAT - 0.0001*pow(thetaSCAT-1.,2)  ")

//DATAChain->Draw("(X1pos-1.2*thetaSCAT)>>hX1pos",CUTbasic && CUTlimits,"");

//  DATAChain->Draw("SiliconEnergy:X1pos>>hESivsX",CUTbasic && CUTlimits && CUTsitime && CUTsip0 && "pulser==0","col");

//  DATAChain->Draw("SiliconEnergy:SiliconTime>>h(10000,-12000,14000,100,0,4000)",CUTbasic && CUTlimits &&  "ADCChannelFront>0 && ADCChannelFront<16 && pulser==0","col");

//  DATAChain->Draw("X1pos>>hX1posall",CUTbasic && CUTlimits &&  "pulser==0","col");
  
//  DATAChain->Draw("X1pos>>hX1posp0",CUTbasic && CUTlimits && CUTsitime && CUTsip0 && "pulser==0","col");

//  DATAChain->Draw("GammaRawADC:X1pos>>hESivsX",CUTbasic && CUTlimits && CUTsip0 && "pulser==0","col");

//  DATAChain->Draw("GammaEnergy:GammaTime>>h(10000,-12000,14000,1000,0,20000)",CUTbasic && CUTlimits &&  "GammaDetectorLabel==1 && pulser==0","col");

//  DATAChain->Draw("GammaEnergy:X1pos>>hENaiX(800,0,800,500,0,20000)",CUTbasic && CUTlimits && CUTnaitime && "pulser==0","col");

//  DATAChain->Draw("GammaEnergy:X1pos>>hENaiX(800,0,800,600,0,6000)",CUTbasic && CUTlimits,"col");

