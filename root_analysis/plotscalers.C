{
gStyle->SetPalette(1,0);

Char_t canvastitle[100]="PR170 2011";     // runnr and Exp

int rangemin=0;        // min and max ranges of time scale
int rangemax=3000;

double lo=0.75;         // hi and lo Y range of indiv labels
double hi=0.9;

TCanvas* MyCanvas = new TCanvas("MyCanvas",canvastitle,1);
MyCanvas->SetFillStyle(0);
TPaveLabel* title = new TPaveLabel(0.1,0.96,0.9,0.99,canvastitle);
title->SetFillStyle(0);
title->SetBorderSize(0);
title->SetTextSize(1.5);  
title->Draw();
TDatime now;
TPaveLabel* date = new TPaveLabel(0.7,0.01,0.9,0.03,now->AsString());
date->Draw();
TPad* graphPad = new TPad("Graphs","Graphs",0.01,0.05,0.95,0.95);
graphPad->SetBorderSize(0);
graphPad->SetFillStyle(0);
graphPad->Draw();
graphPad->cd();
graphPad->Divide(2,2);

//c2=new TCanvas("c2",canvastitle,100,10,700,700);
//c2->Divide(2,2);
//c2->SetFillColor(0);

double trigi,trigu,cii,ciu,pulseri,pulseru,clocki,clocku;

Char_t text1[100],text2[100],text3[100],text4[100],text5[100],text6[100];
TPaveText* legend1 = new TPaveText(0.35,lo,0.75,hi,"brNDC");
TPaveText* legend2 = new TPaveText(0.35,lo,0.75,hi,"brNDC");
TPaveText* legend3 = new TPaveText(0.35,lo,0.75,hi,"brNDC");
TPaveText* legend4 = new TPaveText(0.35,lo,0.75,hi,"brNDC");
TPaveText* legend5 = new TPaveText(0.61,0.25,0.9,0.65,"brNDC");
TPaveText* legend6 = new TPaveText(0.61,0.25,0.9,0.65,"brNDC");
legend1->SetTextSize(0.05);  
legend2->SetTextSize(0.05);  
legend3->SetTextSize(0.05);  
legend4->SetTextSize(0.05);  
legend5->SetTextSize(0.05);  
legend6->SetTextSize(0.05);  
legend1->SetFillStyle(1);
legend2->SetFillStyle(1);
legend3->SetFillStyle(1);
legend4->SetFillStyle(1);



Scaler_TriggerI->SetLineColor(2);
Scaler_PulserI->SetLineColor(2);
Scaler_CII->SetLineColor(2);
Scaler_ClockI->SetLineColor(2);

graphPad->cd(1);
Scaler_TriggerI->GetXaxis()->SetRange(rangemin,rangemax);
Scaler_TriggerI->Draw();
Scaler_TriggerU->Draw("same");
  trigi=Scaler_TriggerI->GetEntries();
  trigu=Scaler_TriggerU->GetEntries();
  sprintf(text1,"I = %d   U = %d",trigi,trigu);
  legend1->AddText(text1);
  sprintf(text1,"Alivetime = %f",100*trigi/trigu);
  legend1->AddText(text1);
  legend1->SetTextFont(40);
  legend1->SetBorderSize(0);
  legend1->Draw();
gPad->SetFillStyle(0);

 
graphPad->cd(2);
Scaler_PulserU->GetXaxis()->SetRange(rangemin,rangemax);
Scaler_PulserU->Draw();
Scaler_PulserI->Draw("same");
  pulseri=Scaler_PulserI->GetEntries();
  pulseru=Scaler_PulserU->GetEntries();
  sprintf(text2,"I = %d   U = %d",pulseri,pulseru);
  legend2->AddText(text2);
  sprintf(text2,"Alivetime = %f",100*pulseri/pulseru);
  legend2->AddText(text2);
  legend2->SetTextFont(40);
  legend2->SetBorderSize(0);
  legend2->Draw();
gPad->SetFillStyle(0);

graphPad->cd(4);
Scaler_ClockU->GetXaxis()->SetRange(rangemin,rangemax);
Scaler_ClockU->Draw();
Scaler_ClockI->Draw("same");
  clocki=Scaler_ClockI->GetEntries();
  clocku=Scaler_ClockU->GetEntries();
  sprintf(text4,"I = %d   U = %d",clocki,clocku);
  legend4->AddText(text4);
  sprintf(text4,"Alivetime = %f",100*clocki/clocku);
  legend4->AddText(text4);
  legend4->SetTextFont(40);
  legend4->SetBorderSize(0);
  legend4->Draw();
gPad->SetFillStyle(0);

graphPad->cd(3);
Scaler_CII->GetXaxis()->SetRange(rangemin,rangemax);
Scaler_CII->Draw();
Scaler_CIU->Draw("same");
  cii=Scaler_CII->GetEntries();
  ciu=Scaler_CIU->GetEntries();
  sprintf(text3,"I = %d   U = %d",cii,ciu);
  legend3->AddText(text3);
  sprintf(text3,"Alivetime = %f",100*cii/ciu);
  legend3->AddText(text3);
  legend3->SetTextFont(40);
  legend3->SetBorderSize(0);
  legend3->Draw();
gPad->SetFillStyle(0);

/*
graphPad->cd(5);
Scaler_QDCBUF->SetLineColor(1);
Scaler_TDCBUF1->SetLineColor(2);
Scaler_TDCBUF2->SetLineColor(3);
Scaler_TDCBUF3->SetLineColor(4);
Scaler_TDCBUF4->SetLineColor(5);
Scaler_TDCBUF5->SetLineColor(6);
Scaler_TDCBUF6->SetLineColor(7);
Scaler_TDCBUF7->SetLineColor(28);
Scaler_QDCBUF->GetXaxis()->SetRange(rangemin,rangemax);
Scaler_QDCBUF->Draw();
Scaler_TDCBUF1->Draw("same");
Scaler_TDCBUF2->Draw("same");
Scaler_TDCBUF3->Draw("same");
Scaler_TDCBUF4->Draw("same");
Scaler_TDCBUF5->Draw("same");
Scaler_TDCBUF6->Draw("same");
Scaler_TDCBUF7->Draw("same");
  sprintf(text5,"QDCBUF = black");
  legend5->AddText(text5);
  sprintf(text5,"TDCBUF1 = red");
  legend5->AddText(text5);
  sprintf(text5,"TDCBUF2 = light green");
  legend5->AddText(text5);
  sprintf(text5,"TDCBUF3 = blue");
  legend5->AddText(text5);
  sprintf(text5,"TDCBUF4 = yellow");
  legend5->AddText(text5);
  sprintf(text5,"TDCBUF5 = magenta");
  legend5->AddText(text5);
  sprintf(text5,"TDCBUF6 = light blue");
  legend5->AddText(text5);
  sprintf(text5,"TDCBUF7 = brown");
  legend5->AddText(text5);
  legend5->SetTextFont(40);
  legend5->SetBorderSize(0);
  legend5->Draw();
gPad->SetFillStyle(0);

graphPad->cd(6);
Scaler_TDCevt->SetLineColor(1);
Scaler_QDCevt->SetLineColor(2);
Scaler_prevTdc->SetLineColor(3);
Scaler_NumSkips->SetLineColor(4);
Scaler_TDCMod->SetLineColor(5);
Scaler_NumWords->SetLineColor(6);
Scaler_TDCevt->Draw();
Scaler_QDCevt->Draw("same");
Scaler_prevTdc->Draw("same");
Scaler_NumSkips->Draw("same");
Scaler_TDCMod->Draw("same");
Scaler_NumWords->Draw("same");
  sprintf(text6,"TDCevt = black");
  legend6->AddText(text6);
  sprintf(text6,"QDCevt = red");
  legend6->AddText(text6);
  sprintf(text6,"prevTdc = light green");
  legend6->AddText(text6);
  sprintf(text6,"NumSkips = blue");
  legend6->AddText(text6);
  sprintf(text6,"TDCMod = yellow");
  legend6->AddText(text6);
  sprintf(text6,"NumWords = magenta");
  legend6->AddText(text6);
  legend6->SetTextFont(40);
  legend6->SetBorderSize(0);
  legend6->Draw();
gPad->SetFillStyle(0);
*/

}
