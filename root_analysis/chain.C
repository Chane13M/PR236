{
  TChain *DATAChain1 = new TChain("DATA","MEGA Tree");
  char name[128];


  Char_t name1[30];
  sprintf(name1,".x ../SCRIPTS/histosPR170.C");
  gROOT->ProcessLine(name1);
  sprintf(name1,".x ../SCRIPTS/read-gates-tgt5-run29x.C");
  gROOT->ProcessLine(name1);

  TH1F *hX1pos1 = new TH1F("hX1pos1","X1 Position",2400,0.,800.);

  //PR170, pt, analysis group 3
  //Int_t run_no1[]={21351,21352,21353,21359,21360,21361,21363,21364,21366,21368,21369,21370,21371,21373,21374,21375,21376,21381,21382,21383,21392,21393,21394,21395};

  //PR170, pt, analysis group 2
  //Int_t run_no1[]={21348,21349,21350};

  //PR170, pt, analysis group 4
  //Int_t run_no1[]={21407,21408};

  //PR170, pt, analysis group 5
  //Int_t run_no1[]={21441,21442};

  //PR170, pt, analysis group 6
  //Int_t run_no1[]={21444,21445,21446,21447,21448,21449,21450,21451,21452,21453,21455,21456,21457,21458,21462,21463,21467,21468,21469,21470,21471};

  //PR170, pt, target 5, run 29172 and onwards
  Int_t run_no1[]={29172,29173,29174,29177,29178,29179,29180,29181,29182,29183,29184,29185,29201,29202,29210,29211,29212,29213,29214,29215,29216,29217,29219,29220,29221,29223,29224,29235,29242,29243,29244,29245,29246,29247,29248,29249,29250,29251,29252,29253,29254,29257,29258,29259,29260,29276};

  Int_t nrofruns1=sizeof(run_no1)/sizeof(run_no1[0]);  

  for(Int_t i=0;i<nrofruns1;i++)	{
	  sprintf(name,"/FAST/run%5d.root",run_no1[i]);
          cout<< name<<endl;
	  DATAChain1->Add(name);
  }
  DATAChain1->Draw("X1posC>>hX1pos1",CUTbasic && CUTlimits,"");

  //DATAChain1->Draw("pad1:tof>>hpad1vstof",CUTbasic && CUTlimits,"col");

}

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

