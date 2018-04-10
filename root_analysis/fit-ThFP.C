{
#include "TF1.h"
#include "TMath.h"

gROOT->Reset();

double minfit=27.;
double maxfit=34.;

/*
    //for run 128
p2=new TF1("p2","gaus",28.,28.8);
p3=new TF1("p3","gaus",28.8,29.6);
p4=new TF1("p4","gaus",29.6,30.5);
p5=new TF1("p5","gaus",30.5,31.2);

    //for run 132
p2=new TF1("p2","gaus",29.,29.8);
p3=new TF1("p3","gaus",29.8,30.6);
p4=new TF1("p4","gaus",30.6,31.5);
p5=new TF1("p5","gaus",31.5,32.2);
*/

    //for run 133
p2=new TF1("p2","gaus",29.5,30.5);
p3=new TF1("p3","gaus",30.5,31.3);
p4=new TF1("p4","gaus",31.3,32.2);
p5=new TF1("p5","gaus",32.2,33.2);


double par[20];

//total = new TF1("total","gaus(0)+gaus(3)+gaus(6)+gaus(9)+gaus(12)+gaus(15)+gaus(18)",minfit,maxfit);
//total = new TF1("total","gaus(3)+gaus(6)+gaus(9)+gaus(12)+gaus(15)+gaus(18)",minfit,maxfit); // first peak not there
total = new TF1("total","gaus(3)+gaus(6)+gaus(9)+gaus(12)",minfit,maxfit); // first and last peak not there
//total = new TF1("total","gaus(6)+gaus(9)+gaus(12)+gaus(15)+gaus(18)",minfit,maxfit);  // first 2 peaks not there

//hThFP->Fit(p1,"R");
hThFP->Fit(p2,"R");
hThFP->Fit(p3,"R");
hThFP->Fit(p4,"R");
hThFP->Fit(p5,"R");
//hThFP->Fit(p6,"R");
//hThFP->Fit(p7,"R");

//p1->GetParameters(&par[0]);
p2->GetParameters(&par[3]);
p3->GetParameters(&par[6]);
p4->GetParameters(&par[9]);
p5->GetParameters(&par[12]);
//p6->GetParameters(&par[15]);
//p7->GetParameters(&par[18]);

total->SetParameters(par);

hThFP->Fit(total,"R+");

double theta[7];
//theta[0]=2.251;
theta[1]=1.679;
theta[2]=0.819;
theta[3]=0.0;
theta[4]=-0.819;
//theta[5]=-1.679;
//theta[6]=-2.251;

double phi[7];
//phi[0]=-2.251;
phi[1]=-1.679;
phi[2]=-0.819;
phi[3]=0.0;
phi[4]=0.819;
phi[5]=1.679;
phi[6]=2.251;

double X[7];
X[0]=652.;  
X[1]=484.4;  
X[2]=326.7;  
X[3]=322.2;  
X[4]=220.0;  

int xnr=1;	// determines which X value is to be printed
int phinr=3;	// determines which phi value is to be printed

printf("X           phi angle  ThSCAT    ThFP     sigma  \n");
//printf("X           phi angle  ThSCAT    ThFP     sigma U2 \n");
//printf("%f %f %f %f %f \n",X[3],phi[3],theta[0],par[1],par[2]);
printf("%f %f %f %f %f \n",X[xnr],phi[phinr],theta[1],par[4],par[5]);
printf("%f %f %f %f %f \n",X[xnr],phi[phinr],theta[2],par[7],par[8]);
printf("%f %f %f %f %f \n",X[xnr],phi[phinr],theta[3],par[10],par[11]);
printf("%f %f %f %f %f \n",X[xnr],phi[phinr],theta[4],par[13],par[14]);
//printf("%f %f %f %f %f \n",X[xnr],phi[phinr],theta[5],par[16],par[17]);
//printf("%f %f %f %f %f \n",X[xnr],phi[phinr],theta[6],par[19],par[20]);


}



