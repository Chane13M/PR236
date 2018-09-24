{
#include <TString.h>
#include <TCanvas.h>
#include <TH2.h>
#include <TFile.h>
#include <TBranch.h>
#include <TDirectory.h>
#include <TROOT.h>
#include <TApplication.h>
#include <TPaveText.h>
#include <TPaveStats.h>
#include <TPaveLabel.h>
#include <TProfile.h>
#include <TF1.h>
#include <TStyle.h>
#include <TGraphErrors.h>
#include <TMultiGraph.h>
#include <TGraph.h>
#include <TKey.h>
#include <TLegend.h>

// This script is mainly useful to convert the horizontal ThFP
// to ThSCAT.
// For Phi as well see ThFPtoThSCAT.C or ThPhi-FPtoSCAT.C

gROOT->ForceStyle();

const Int_t nr_of_x=2;
const Int_t nr_of_phi=1;
const Int_t nr_of_th=2;

//==================
Double_t  PhiSC[nr_of_x][10][10],     ThSC[nr_of_x][10][10];
Double_t   ThFP[nr_of_x][10][10],  SigThFP[nr_of_x][10][10];
Double_t      X[nr_of_x][10][10];

for(Int_t k=0;k<nr_of_x;k++) {
  for(Int_t i=0;i<8;i++) {
    for(Int_t j=0;j<8;j++) {
        X[k][i][j]=0;
	PhiSC[k][i][j]=0;
	ThSC[k][i][j]=0;
	ThFP[k][i][j]=0;
	SigThFP[k][i][j]=0;
    }
  }
}


//==================
TString file;
TString filename[nr_of_x];
//filename[0]="theta-calib-12C4p4.dat";   
//filename[1]="theta-calib-12C7p64.dat";   
filename[0]="theta1.dat";   
filename[1]="theta3.dat";
//filename[2]="theta3.dat"; 
TString pathname="/home/chane/K600/Analysis/PR236/root_analysis/";
Char_t file_name[100]; 

Int_t phicnt;
for(Int_t k=0;k<nr_of_x;k++) {
  phicnt=0;
  file=pathname+filename[k];
  sprintf(file_name,"%s",file.Data());
  ifstream inputfile(file_name);
  if(!inputfile)  { 
    cerr<<"Can't open input file, -> exit"<<endl; 
    exit(1);
  }
  else cerr << "Opening file " <<file_name<<endl;
  while(!inputfile.eof()){           // this is bad programming: will always read 1 more set of 5!!!!! 
      for(Int_t j=0;j<nr_of_th;j++) {
        inputfile >> X[k][phicnt][j] >> PhiSC[k][phicnt][j] >> ThSC[k][phicnt][j] >> ThFP[k][phicnt][j] >> SigThFP[k][phicnt][j];
        //cout<< k<<" "<< phicnt<<" "<<j<<" "<<X[k][phicnt][j]<<" "<<PhiSC[k][phicnt][j]<<" "<<ThSC[k][phicnt][j]<<" "<<ThFP[k][phicnt][j]<<" "<<SigThFP[k][phicnt][j]<<endl;
        //cout<< X[k][phicnt][j]<<" "<<PhiSC[k][phicnt][j]<<" "<<ThSC[k][phicnt][j]<<" "<<ThFP[k][phicnt][j]<<" "<<SigThFP[k][phicnt][j]<<endl;
      }
      phicnt++;
  }
  inputfile.close();     
  //number_of_entries=i-1;
  //cout<<"Number of entries: "<<number_of_entries<<endl;

/*
  for(Int_t k=0;k<5;k++){
      cout<<"   "<<ThSC[0][k]<<" "<<ThFP[0][k]<<"  "<<endl;
  }
  cout<<"Now to stop everything briefly... ";
  cin>>temp;
*/
}


//==================
TCanvas *c2= new TCanvas("c2","c2",1700,10,1100,500);

TPaveLabel *title = new TPaveLabel(0.1,0.96,0.9,0.99,"#theta_{FP} to #theta_{SCAT}");
title->SetTextFont(42);
title->Draw();

TPad *graphpad1  = new TPad("Graphs","Graphs",0.01,0.05,0.99,0.96);
graphpad1->Draw();
graphpad1->cd();
graphpad1->Divide(nr_of_x,1);
  
TPaveText* legend1;
TPaveText* legend2;
TPaveText* legend3;

Char_t slopetxt[100], txt[100];

Double_t Xtmp[nr_of_x],slopetmp[nr_of_x],offsettmp[nr_of_x];
Int_t number_of_entries;
Double_t slope[nr_of_x][nr_of_phi],offset[nr_of_x][nr_of_phi];
Double_t chisq[nr_of_x][nr_of_phi];
TString comment;

TGraph *gr_angle[nr_of_x][nr_of_phi];
for(Int_t k=0;k<nr_of_x;k++) {
  for(Int_t n=0;n<nr_of_phi;n++){
    gr_angle[k][n]= new TGraph(nr_of_th,ThFP[k][n],ThSC[k][n]);
    gr_angle[k][n]->SetMarkerColor(1);
    gr_angle[k][n]->SetMarkerStyle(20);
    gr_angle[k][n]->SetMarkerSize(0.65);
    gr_angle[k][n]->GetXaxis()->SetTitle("#theta_{FP} (deg.)");
    gr_angle[k][n]->GetYaxis()->SetTitle("#theta_{SCAT} (deg.)");
  }
}

Int_t temp;  
for(Int_t k=0;k<nr_of_x;k++) {
  for(Int_t n=0;n<nr_of_phi;n++){
    temp=k*nr_of_phi +(n+1);
    graphpad1->cd(temp); 
    gr_angle[k][n]->Draw("PA");
    gr_angle[k][n]->SetTitle("");
    gr_angle[k][n]->Fit("pol1","Q");
    gr_angle[k][n]->GetFunction("pol1")->SetLineColor(1);
    gr_angle[k][n]->GetFunction("pol1")->SetLineWidth(.2);       
  
    slope[k][n] = gr_angle[k][n]->GetFunction("pol1")->GetParameter(1);
    offset[k][n] = gr_angle[k][n]->GetFunction("pol1")->GetParameter(0);
    chisq[k][n] = gr_angle[k][n]->GetFunction("pol1")->GetChisquare();
    sprintf(slopetxt,"Slope = %f;  Offset = %f ",slope[k][n],offset[k][n]);
    legend1 = new TPaveText(0.15,0.87,0.85,1.0,"brNDC");
    legend1->SetTextFont(42);
    legend1->AddText(slopetxt);
    legend1->Draw();

    sprintf(txt,"X = %f ", X[k][n][0]);
    legend2 = new TPaveText(0.15,0.73,0.5,0.87,"brNDC");
    legend2->SetTextFont(42);
    legend2->AddText(txt);
    legend2->Draw();

    sprintf(txt,"chisq = %f ", chisq[k][n]);
    legend3 = new TPaveText(0.15,0.13,0.5,0.17,"brNDC");
    legend3->SetTextFont(42);
    legend3->AddText(txt);
    legend3->Draw();
    //cout<<X[k][n][0]<<" "<<PhiSC[k][n][0]<<" "<<slope[k][n]<<" "<<offset[k][n]<<"  "<<endl;

    slopetmp[k]=slope[k][0];
    offsettmp[k]=offset[k][0];
    Xtmp[k]=X[k][0][0];
  }  
}

graphpad1->Update();
//c2->SaveAs("tmp.ps");


//------------------------------------------------------------------------------

TCanvas *c4 = new TCanvas("c4","c4",2600,200,700,400);

TPaveLabel *title2 = new TPaveLabel(0.1,0.96,0.9,0.99,"slope and offset as function of X");
title2->SetTextFont(40);
title2->Draw();

TPad *graphpad3  = new TPad("Graphs","Graphs",0.01,0.05,0.99,0.95);
graphpad3->Draw();
graphpad3->cd();
graphpad3->Divide(2);

for(Int_t k=0;k<nr_of_x;k++) {
  cout<< Xtmp[k]<<" "<<slopetmp[k]<<" "<<offsettmp[k]<<endl;
}
Double_t slope3[nr_of_x],offset3[nr_of_x];

TGraph *gr_TH[2];
gr_TH[0]= new TGraph(nr_of_x,Xtmp,slopetmp);
gr_TH[1]= new TGraph(nr_of_x,Xtmp,offsettmp);

for(Int_t k=0;k<2;k++) {
    gr_TH[k]->SetMarkerColor(1);
    gr_TH[k]->SetMarkerStyle(20);
    gr_TH[k]->SetMarkerSize(0.65);
    gr_TH[k]->GetXaxis()->SetTitle("X_{fp} (mm)");
}
gr_TH[0]->GetYaxis()->SetTitle("Slope");
gr_TH[1]->GetYaxis()->SetTitle("Offset");

for(Int_t k=0;k<2;k++) {
    temp=(k+1);
    graphpad3->cd(temp); 
    gr_TH[k]->Draw("PA");
    gr_TH[k]->SetTitle("");
    gr_TH[k]->Fit("pol1","Q");
    gr_TH[k]->GetFunction("pol1")->SetLineColor(1);
    gr_TH[k]->GetFunction("pol1")->SetLineWidth(.2);        

    slope3[k] = gr_TH[k]->GetFunction("pol1")->GetParameter(1);
    offset3[k] = gr_TH[k]->GetFunction("pol1")->GetParameter(0);

    sprintf(slopetxt,"slope = %f;  offset = %f ",slope3[k],offset3[k]);
    legend1 = new TPaveText(0.15,0.87,0.85,1.0,"brNDC");
    legend1->SetTextFont(42);
    legend1->AddText(slopetxt);
    legend1->Draw();

    if(k==0) sprintf(txt,"slope");
    if(k==1) sprintf(txt,"offset");
    legend2 = new TPaveText(0.25,0.73,0.45,0.87,"brNDC");
    legend2->SetTextFont(42);
    legend2->AddText(txt);
    legend2->Draw();

}
graphpad3->Update();

cout<<"#Theta_{SCAT}=("<< offset3[0]<<" + "<<slope3[0]<<"*X)*#Theta_{FP} + ("<< offset3[1]<<" + "<<slope3[1]<<"*X)"<<endl;


};



