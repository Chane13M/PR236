///////////////////////////////////////////////////////////////////////////
// Macro for extrapolating line shape correction parameters	  	 //
//									 //
//  The run file of interest should be read in to root			 //
//  before implementing this script 					 //
//									 //
///////////////////////////////////////////////////////////////////////////

{

 //ToF vs X1 histogram
  TH2F *htofvsX1pos = new TH2F("htofvsX1pos","tof vs X1pos",700,0,800,100,4700,4800);
  TCanvas *C2 = new TCanvas;
  DATA->Draw("tof:X1pos>> htofvsX1pos","X1flag==0 &&U1flag==0 ","col");
   htofvsX1pos->GetXaxis()->SetTitle("X1 position (mm)");
   htofvsX1pos->GetYaxis()->SetTitle("ToF");
   C2 -> Update();
   C2 -> Modified();

/////////////////////////////////////////////////////////////////////////////////////////////////


  TH2F *hPeakofInterest = new TH2F("hPeakofInterest","tof vs X1pos",120,4810,4870,24,648,660);//I used the prominent peak in Run2233

  TCanvas *C4 = new TCanvas;
  DATA->Draw("tof:X1pos-652>> hPeakofInterest","X1flag==0 &&U1flag==0 ","col"); //634 was the mean Xposition of the peak I used
   hPeakofInterest->GetXaxis()->SetTitle("X1-X1mean (mm)");
   hPeakofInterest->GetYaxis()->SetTitle("ToF");
   C4 -> Update();
   C4 -> Modified();


   TCanvas *C5 = new TCanvas;
   hPeakofInterest->FitSlicesX(0,2,69,0,"Q",0); //Fits each slice and creates histograms for each fit variable
   hPeakofInterest_1->Draw(); //histoname_1 is the histogram of the centroid parameters for each slice 
   hPeakofInterest_1->Fit("pol3"); //type of fit can be changed 


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 //Check lineshaping correction
  //Should be of the form: X1pos-(p0+(p1*tof)+(p2*pow(tof,2))+(p3*pow(tof,3)), use p0,p1,p2,p3 obtained from pol3 fit above

  DATA->SetAlias("shapedX1","X1pos-(-22204.7+(36.8581*tof)+(-0.0203301*pow(tof,2))+(3.72715e-6*pow(tof,3)))");



  TH2F *htofvsX1corr = new TH2F("htofvsX1corr","tof vs X1corr",700,100,800,100,1900,2000);
   TCanvas *C6 = new TCanvas;
   DATA->Draw("tof:shapedX1>> htofvsX1corr","X1flag==0 &&U1flag==0 ","col");

   htofvsX1corr->GetXaxis()->SetTitle("Corrected X1 position (mm)");
   htofvsX1corr->GetYaxis()->SetTitle("ToF");
   C6 -> Update();
   C6 -> Modified();







}



