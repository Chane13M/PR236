
{
gStyle->SetPalette(1,0);

c3 = new TCanvas("c3","c3",800,10,1000,600);
c3->SetFillColor(0);
c3->SetGridy(0);
c3->SetFillColor(0);

//for 24Mg weekend 3
//TCut CUTYbck1 = "Y1>-25 && Y1<-7";   
//TCut CUTYbck2 = "Y1>-43 && Y1<-25";  
 
 //for 90Zr weekend 2
TCut CUTYbck1 = "Y1>-28 && Y1<-12.5";   
TCut CUTYbck2 = "Y1>-43.5 && Y1<-28";

// Create 1 dimensional histograms for Position
TH1F *hEx = new TH1F("hEx","Excitation energy",3000,0,30);
TH1F *hExback1 = new TH1F("hExback1","Excitation energy",3000,0,30);
TH1F *hExback2 = new TH1F("hExback2","Excitation energy",3000,0,30);
TH1F *hExbacktot = new TH1F("hExbacktot","Excitation energy",3000,0,30);
TH1F *hExdiff = new TH1F("hExdiff","Excitation energy",3000,0,30);

DATAChain->Draw("Ex>>hEx",CUTbasic && CUTflags && CUTlimits && CUTy,"");
DATAChain->Draw("Ex>>hExback2",CUTbasic && CUTflags && CUTlimits && CUTYbck1,"");
DATAChain->Draw("Ex>>hExback1",CUTbasic && CUTflags && CUTlimits && CUTYbck2,"");

hExdiff->SetTitle("^{24}Mg(#alpha,#alpha) at 0^{o} (background subtracted)");
hExdiff->SetStats(0);
hExdiff->GetXaxis()->SetTitle("E_{x} (MeV)");
hExdiff->GetXaxis()->CenterTitle(true);
hExdiff->GetYaxis()->SetTitle("Counts/10keV");
hExdiff->GetYaxis()->CenterTitle(true);
hExdiff->GetXaxis()->SetTitleOffset(1.1);  
hExdiff->GetYaxis()->SetTitleOffset(1.4); 

hExdiff->Add(hEx);
hExdiff->Add(hExback1, -1);//,-0.416667);
hExdiff->Add(hExback2, -1);//,-0.416667);
hExbacktot->Add(hExback1);//,0.416667);
hExbacktot->Add(hExback2);//,0.416667);

hEx->SetLineColor(4);
hExback1->SetLineColor(2);
hExback2->SetLineColor(3);
hExdiff->SetLineColor(1);
hExbacktot->SetLineColor(6);

hEx->Draw();
hExdiff->Draw("same");
hExback1->Draw("same");
hExback2->Draw("same");
hExbacktot->Draw("same");

leg = new TLegend(0.1,0.7,0.48,0.9);
//leg->SetHeader("Legend",""); // option "C" allows to center the header
leg->AddEntry(hEx,"Raw data","l");
leg->AddEntry(hExback1,"Background 1","l");
leg->AddEntry(hExback2,"Background 2","l");
leg->AddEntry(hExbacktot,"Total background","l");
leg->AddEntry(hExdiff,"Background subtracted data","l");
//leg->SetLegendFont(16);
leg->Draw();

}