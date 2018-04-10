{

#include <math.h>
#include <stdlib.h>     /* abs */

  char name[128];
  int nrofpeaks=8;   
  int firstpeak=0;   

/*
  for(Int_t i=0;i<nrofpeaks;i++){
     sprintf(name,"t%i->Delete()",i);
     gROOT->ProcessLine(name); 
     cout<<name<<endl;
  }
  all->Delete();
  bckgY->Delete();
  bckgC->Delete();
*/

  Double_t pi=3.14159265359;
  Double_t binsperMeV=10;	// for determiniation of nr of counts in peak
  Double_t low=10.5;
  Double_t hi=14.;
  Double_t rangelo[100],rangehi[100],centroid[100],sigma[100];
  Double_t par[100], peakcounts[100];

  for(Int_t i=0;i<100;i++){
    par[i]=0.0;
  }  

//--------------------------------------------------------------------------------------------------------
// Information for all the states in 13C; natural parity states 
  rangelo[0]=10;     rangehi[0]=11 ;   centroid[0]= 10.818;   sigma[0]= sqrt(.094**2+0.024**2)/2.35;
  rangelo[1]=10.7;  rangehi[1]=11.4 ;   centroid[1]= 11.080;   sigma[1]= sqrt(.094**2+0.004**2)/2.35;
  rangelo[2]=11;    rangehi[2]=13 ;   centroid[2]= 11.848;   sigma[2]= sqrt(.094**2+0.068**2)/2.35;
  rangelo[3]=11.;   rangehi[3]=13.;  centroid[3]= 12.106;   sigma[3]= sqrt(.094**2+0.540**2)/2.35;
  rangelo[4]=11;    rangehi[4]=13 ;   centroid[4]= 12.130;   sigma[4]= sqrt(.094**2+0.080**2)/2.35;
  rangelo[5]=12;    rangehi[5]=14 ;   centroid[5]= 13.410;   sigma[5]= sqrt(.094**2+0.035**2)/2.35;
  rangelo[6]=12;    rangehi[6]=15 ;   centroid[6]= 13.760;   sigma[6]= sqrt(.094**2+0.300**2)/2.35;

// Information for all the states in 12C; natural parity states 

  rangelo[7]=9;    rangehi[7]=10;    centroid[7]= 9.641;   sigma[7]= sqrt(.094**2+0.034**2)/2.35;

/*
  rangelo[8]=10;    rangehi[8]=14 ;   centroid[8]= 13.259;   sigma[8]= sqrt(.094**2+0.021**2)/2.35;
  rangelo[9]=11;    rangehi[9]=15 ;   centroid[9]= 13.600;   sigma[9]= sqrt(.094**2+0.8**2)/2.35;    //wakasa
  rangelo[10]=13;   rangehi[10]=14.5; centroid[10]= 13.869;  sigma[10]= sqrt(.094**2+0.089**2)/2.35;
  rangelo[11]=13;   rangehi[12]=15 ;  centroid[11]= 14.032;  sigma[11]= sqrt(.094**2+0.185**2)/2.35;
  rangelo[12]=13;   rangehi[12]=16 ;  centroid[12]= 14.100;  sigma[12]= sqrt(.094**2+0.750**2)/2.35;
*/


//------------------------------------------------------------------------------------------
// Define peaks, plus the polynomial background
//
  for(Int_t i=firstpeak;i<nrofpeaks;i++){
     sprintf(name,"TF1 *t%i = new TF1(\"t%i\",\"gaus\",rangelo[%i],rangehi[%i]);",i,i,i,i);
     gROOT->ProcessLine(name); 
     //cout<<name<<endl;

     sprintf(name,"t%i->SetParameters(1000,centroid[%i],sigma[%i]);",i,i,i);
     gROOT->ProcessLine(name); 
     //cout<<name<<endl;
  }
  TF1 *bckgY = new TF1("bckgY","[0] + [1]*x",low,hi);
  TF1 *bckgC = new TF1("bckgC","[0] + [1]*x + [2]*x*x + [3]*x*x*x",low,hi);
  //bckg->SetParameters(1,1.,1.);

//------------------------------------------------------------------------------------------
// Add all the peaks in one function and fit that function
//
//
  TF1 *all = new TF1("all","t0+t1+t2+t3+t4+t5+t6+t7+t8+bckgY+bckgC",low,hi);
  //TF1 *all = new TF1("all","t0+bckg",low,hi);
  //TF1 *all = new TF1("all","t0+t1+t2+t3+t4+t5+t6+t7+t8",low,hi);
  for(Int_t i=firstpeak;i<nrofpeaks;i++){

     //sprintf(name,"all->FixParameter(1+3*%i,centroid[%i]);",i,i);
     //gROOT->ProcessLine(name); //cout<<name<<endl;
     //sprintf(name,"all->FixParameter(2+3*%i,sigma[%i]);",i,i);
     //gROOT->ProcessLine(name);  //cout<<name<<endl;
 
     sprintf(name,"all->SetParLimits(0+3*%i,0,50000);",i);
     gROOT->ProcessLine(name);  //cout<<name<<endl;
     sprintf(name,"all->SetParLimits(2+3*%i,0,3000);",i);  // if width not fixed, then limit it
     //sprintf(name,"all->SetParLimits(2+3*%i,0.9*sigma[%i],1.1*sigma[%i]);",i,i,i);  // if width not fixed, limit it
     gROOT->ProcessLine(name);  //cout<<name<<endl;
     sprintf(name,"all->SetParLimits(1+3*%i,centroid[%i]-0.05,centroid[%i]+0.05);",i,i,i);  // if position is fixed, limit it
     //gROOT->ProcessLine(name);  //cout<<name<<endl;

  }
  all->SetParLimits(27,6500.,20000);
  all->SetParLimits(28,0.,10);

  //all->FixParameter(29,-233960);
  //all->FixParameter(30,67878);
  //all->FixParameter(31,-6338);
  //all->FixParameter(32,192);

  all->FixParameter(29, 3.29246e+04);
  all->FixParameter(30,-2.60319e+03);
  all->FixParameter(31,-2.02718e+02);
  all->FixParameter(32,1.60654e+01);

  //hExLiCO->Fit("all","VRB+","",low,hi);
  hExdiff->Fit("all","VRB+","",low,hi);


//------------------------------------------------------------------------------------------
// get parameters of individual peaks from fit 
//
  all->GetParameters(par);
  for(Int_t i=firstpeak;i<nrofpeaks;i++){
     peakcounts[i]=par[0+i*3]*fabs(par[2+i*3])*sqrt(2*pi) *binsperMeV ; 

     cout << "peak #"<< i+1 << ": position = " << par[3*i+1] <<" MeV     FWHM = " << 1000*2.35*par[3*i+2] << " kev   peak counts ="<< peakcounts[i]  << "   (NNDC: "<< centroid[i] <<";  "<< 1000*2.35*sigma[i] <<" ) "<<endl;

  }

  cout << "Parameters for background1 : "<< par[(nrofpeaks)*3+0] <<" , "<<  par[(nrofpeaks)*3+1]  <<endl;
  cout << "Parameters for background2 : "<< par[(nrofpeaks)*3+2] <<" , "<<  par[(nrofpeaks)*3+3] <<" , "<< par[(nrofpeaks)*3+4] <<" , "<< par[(nrofpeaks)*3+5] <<endl;

//------------------------------------------------------------------------------------------
// now plot the individual peaks 
//
  for(Int_t i=firstpeak;i<nrofpeaks;i++){
     sprintf(name,"t%i->SetParameters(par[0+3*%i],par[1+3*%i],par[2+3*%i])",i,i,i,i);
     gROOT->ProcessLine(name); //cout<<name<<endl;
     sprintf(name,"t%i->SetLineColor(%i+40)",i,i);
     gROOT->ProcessLine(name); //cout<<name<<endl;
     sprintf(name,"t%i->SetLineStyle(7)",i);
     gROOT->ProcessLine(name); //cout<<name<<endl;
     sprintf(name,"t%i->Draw(\"same\")",i);
     gROOT->ProcessLine(name); //cout<<name<<endl;
  }
  //bckg->SetParameters(par[nrofpeaks*3],par[nrofpeaks*3+1],par[nrofpeaks*3+2]);
  
  bckgY->SetParameters(par[27],par[28]);
  bckgC->SetParameters(par[29],par[30],par[31],par[32]);
  //bckg->SetParameters(par[3],par[4],par[5]);
  bckgY->SetLineStyle(7);
  bckgC->SetLineStyle(7);
  bckgC->SetLineColor(4);
  bckgY->Draw("same");
  bckgC->Draw("same");

  cout<< " chi sq = "<<  all->GetChisquare() << "  Nr of Degr Of Freedom = "<<  all->GetNDF() <<endl;
  cout<< " reduced chisq = "<<  all->GetChisquare()/all->GetNDF() <<endl;

}
 
 

  TF1 *all2 = new TF1("all2","t0",low,hi);
  TF1 *all2 = new TF1("all2","t0+t1+t2+t3+t4+t5+t6+t7+t8+bckg",low,hi);

  TF1 *bckg = new TF1("bckg","[0]+[1]*x+[2]*x*x+[3]*x*x*x",low,hi);
  bckg->FixParameter(0, 3.29246e+04);
  bckg->FixParameter(1,-2.60319e+03);
  bckg->SetParameter(2,-2.02718e+02);
  bckg->SetParameter(3,1.60654e+01);


  hExdiff->Fit("bckg","VRB+","",low,hi);
