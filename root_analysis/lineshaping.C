///////////////////////////////////////////////////////////////////////////
// Macro for extrapolating line shape correction parameters	  	 //
//									 //
//  The run file of interest should be read in to root			 //
//  before implementing this script 					 //
//									 //
///////////////////////////////////////////////////////////////////////////

{

 //ToF vs X1 histogram
  TH2F *hThSCATvsX1pos = new TH2F("hThSCATvsX1pos","Scattering theta vs X1pos",1600,0,800,64,-4,4);
  TCanvas *C2 = new TCanvas;
  DATA->Draw("thetaSCAT:X1pos>>hThSCATvsX1pos","","col");
   hThSCATvsX1pos->GetXaxis()->SetTitle("X1 position (mm)");
   hThSCATvsX1pos->GetYaxis()->SetTitle("Scattering angle");
   C2 -> Update();
   C2 -> Modified();

/////////////////////////////////////////////////////////////////////////////////////////////////


  TH2F *hPeakofInterest = new TH2F("hPeakofInterest","Scattering theta vs X1pos",20,649,659,32,-2,2);//I used the prominent peak in Run2233

  TCanvas *C4 = new TCanvas;
  DATA->Draw("thetaSCAT:X1pos>>hPeakofInterest","","col"); //634 was the mean Xposition of the peak I used
   hPeakofInterest->GetXaxis()->SetTitle("X1-X1mean (mm)");
   hPeakofInterest->GetYaxis()->SetTitle("Scattering theta");
   C4 -> Update();
   C4 -> Modified();


   TCanvas *C5 = new TCanvas;
   hPeakofInterest->FitSlicesX(0,2,69,0,"Q",0); //Fits each slice and creates histograms for each fit variable
   hPeakofInterest_1->Fit("pol3"); //type of fit can be changed 
   hPeakofInterest_1->Draw(); //histoname_1 is the histogram of the centroid parameters for each slice 

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//This should be uncommented only after the parameters are provided
 //Check lineshaping correction
  //Should be of the form: X1pos-(p0+(p1*tof)+(p2*pow(tof,2))+(p3*pow(tof,3)), use p0,p1,p2,p3 obtained from pol3 fit above

  DATA->SetAlias("shapedX1","X1pos-(651.093+(7.96988*thetaSCAT)+(-0.50891*pow(thetaSCAT,2))+(-2.59462*pow(thetaSCAT,3)))");



  TH2F *hthetaSCATvsX1corr = new TH2F("hThSCATvsX1corr","Scattering angle vs X1corr",700,100,800,100,1900,2000);
   TCanvas *C6 = new TCanvas;
   DATA->Draw("thetaSCAT:shapedX1>>hThSCATvsX1corr","","col");

   hThSCATvsX1corr->GetXaxis()->SetTitle("Corrected X1 position (mm)");
   hThSCATvsX1corr->GetYaxis()->SetTitle("ToF");
   C6 -> Update();
   C6 -> Modified();







}



