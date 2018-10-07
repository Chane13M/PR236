{
gStyle->SetPalette(1,0);

c3 = new TCanvas("c3","c3",800,10,1000,600);
c3->SetFillColor(0);
c3->SetGridy(0);
c3->SetFillColor(0);



// Create 1 dimensional histograms for Position
TH1F *hEx = new TH1F("hEx","Excitation energy",2000,0,800);
TH1F *hExback1 = new TH1F("hExback1","Excitation energy",2000,0,800);
TH1F *hExback2 = new TH1F("hExback2","Excitation energy",2000,0,800);
TH1F *hExbacktot = new TH1F("hExbacktot","Excitation energy",2000,0,800);
TH1F *hExdiff = new TH1F("hExdiff","Excitation energy",2000,0,800);

DATAChain->Draw("X1posC >>hEx",CUTbasic && CUTlimits && CUTy,"");
DATAChain->Draw("X1posC >>hExback1",CUTbasic && CUTlimits && CUTYbck1,"");
DATAChain->Draw("X1posC >>hExback2",CUTbasic && CUTlimits && CUTYbck2,"");
//DATAChain->Draw("X1posC >>hExbacktot",CUTbasic && CUTlimits && CUTybckg,"");
//DATAChain->Draw("X1posC >>hExdiff", CUTbasic && CUTlimits && CUTybckgdiff,"");

/*
 * // Create 1 dimensional histograms for Position
TH1F *hEx = new TH1F("hEx","Excitation energy",3000,0,30);
TH1F *hExback1 = new TH1F("hExback1","Excitation energy",3000,0,30);
TH1F *hExback2 = new TH1F("hExback2","Excitation energy",3000,0,30);
TH1F *hExbacktot = new TH1F("hExbacktot","Excitation energy",3000,0,30);
TH1F *hExdiff = new TH1F("hExdiff","Excitation energy",3000,0,30);

DATAChain->Draw("(30.7314 - 0.02812*X1posC -0.000003376*X1posC^2)>>hEx",CUTbasic && CUTlimits && CUTY,"");
DATAChain->Draw("(30.7314 - 0.02812*X1posC -0.000003376*X1posC^2)>>hExback2",CUTbasic && CUTlimits && CUTYbck1,"");
DATAChain->Draw("(30.7314 - 0.02812*X1posC -0.000003376*X1posC^2)>>hExback1",CUTbasic && CUTlimits && CUTYbck2,"");
*/

hExdiff->SetTitle("^{24}Mg(#alpha,#alpha) at 0^{o}");
hExdiff->SetStats(0);
//hExdiff->GetXaxis()->SetTitle("E_{x} (MeV)");
//hExdiff->GetXaxis()->CenterTitle(true);
//hExdiff->GetYaxis()->SetTitle("Counts/10keV");
//hExdiff->GetYaxis()->CenterTitle(true);

hExdiff->Add(hEx);
hExdiff->Add(hExback1,-2);
hExdiff->Add(hExback2,-1);
hExbacktot->Add(hExback1);
hExbacktot->Add(hExback2);

hEx->SetLineColor(4);
hExback1->SetLineColor(2);
hExback2->SetLineColor(3);
hExdiff->SetLineColor(1);
hExbacktot->SetLineColor(6);

//hEx->Draw();
hExdiff->Draw("");
//hExback1->Draw("same");
//hExback2->Draw("same");
//hExbacktot->Draw("same");

/*
auto legend = new TLegend(0.1,0.7,0.48,0.9);
legend->SetHeader("The Legend Title","C"); // option "C" allows to center the header
legend->AddEntry(hEx,"Raw data","l");
legend->AddEntry(hExback1,"Background 1","l");
legend->AddEntry(hExback2,"Background 2","l");
legend->AddEntry(hExbacktot,"Total background","l");
legend->AddEntry(hExdiff,"Background subtracted data","l");
legend->SetLegendFont(20);
legend->Draw();
*/


}


