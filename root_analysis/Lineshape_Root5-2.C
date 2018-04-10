
/******************************************************************************************\
  Name:         Lineshape_Root5.C
  Created by:   Felix Diel

  Notes:	Notes by a user, for a user :) 

		Please note the following when using the script: 

		1. Once inside ROOT looking at a sorted.root file, load the script
		   as follow: 

		   >> .L Lineshape_Root5.C

                2. Plot hThSCATvsX1 and use this to identify the line you would
		   like to correct as well as the parameters required to use the 
		   script. An input of the following form is required:

                   >> line_shape_single(TTree *tree, std::string opt,
					double peak_pos, double peak_width,
					double lo_th, double hi_th,
		 			double intervals, int th_o)
		      where:


                  i) 	The first parameter is the TTree that you are using.
                      	For example if you are using a single root file, you will 
		      	use DATA. For a chained group, you will use DATAChain.

		  ii)	The second parameter allows you to use any TCutG options
			you may want to use. Please note that they must be TCutG
			options and not TCut options. When using this argument,
			the input must be in double quotes e.g. "CUTpad1tof"

		  iii)	The third parameter is the x-position of the line you are 
			wanting to correct. The script moves through the line
			starting from the lowest angle. This means that the
			position you choose should coincide with where the line
			begins at that low angle point. Note that this position is 
			an important parameter and can be the difference between a 
			successful output and a failed output. Try to be as accurate
			as possible.

		  iv)	The fourth parameter is the peak width. This is a bit less 
			intuitive to set but essentially, the script attempts to 
			fit a Gaussian to the projection of a section of the line
			so this parameter should be something like the thickness of
			the line in mm.

		  v)	The fifth parameter is the low angle limit of the region
			in which the line is located. In principle, the value for
			this parameter should correspond with the value chosen for
			the third parameter. Note that if the line is too weak at
			this lower limit position, the process will fail. It is best
			to choose the position where the line is clearly visible and
			move out a bit, iteratively.

		  vi)	The sixth parameter is the high angle limit. This is the
			position at which the script will stop attempting to correct
			the line.

		  vii)	The seventh parameter is the number of sections into which 
			you would like to divide the angle interval containing the 
			line. The script divides the interval between (v) and (vi) 
			in to sections and projects and fits each section. Choosing 
			a low number will give high statistics for each section
			resulting in an easier fit with with less accurate position.
			A high number means many fit positions along the line. This
			results in a more accurate lineshape but it means that it is
			easier for the script to fail. Values generally range between
			20 and 100 depending on the strength of the line. It really
			is situationally dependent though so it's important to try
			a few options before deciding on a number. 

		  viii) Finally, the eighth parameter is order of the polynomial you
			would like to use to fit the lineshape. Beware of making this 
			number too large because it can affect the region outside of 
			your fitting area. Again, this is situationally dependent so
			spend time trying a few options in order to understand the 
			effect of this parameter.

  		
		3. A sample input line is: 

		   >> line_shape_single(DATA,"CUTpad1tof && CUTpad2tof && CUTpad1pad2 
		      && CUTtofX1 && X1flag==0 && U1flag==0 && U2flag==0 && Y1>-5 && 
		      Y1<20",650.5,2,-1.7,2.0,20,5)

		4. If your fit fails, do not despair just yet! Try the following:

		   a)	Double check parameter (iii) and maybe make it more accurate. 
			Try a slightly different value if necessary. 

		   b)	Decrease parameter (vii). 

		   c)	Double check parameter (v) and make sure that the line isn't 
			too weak at the position you've selected. Maybe try to adjust
			this value and run the script again. 

		   If the above options do not work, ask Retief or Lindsay for help :) 
		
		5. Please also note that this is sometimes just a starting point for the
		   lineshape correction and that sometimes corrections in Y1 and X1*ThSCAT
		   are necessary as well. Be sure to fit your lineshape-corrected peak to
		   verify whether you have an acceptable sigma.
		   
		
\******************************************************************************************/


#include <string>

void line_shape_single(TTree *tree, std::string opt, double peak_pos,
                       double peak_width, double lo_th, double hi_th,
                       double intervals, int th_o) {


  //This macro assumes you have loaded the histos.C 

  TCanvas *c1 = new TCanvas("c2", "Test", 800, 600);

  int binMin = 0;
  int binMax = 0;

  double sliceBinWidth = 0;
  double sliceUserWidth = 0;

  double delay = 100000;

  TCanvas *c2 = new TCanvas("cline", "Test", 800, 600);

  c2->Update();
  tree->Draw("thetaSCAT:X1posO>>hThSCATvsX1", opt.c_str(), "col");

  hThSCATvsX1->Draw("colz");
  c2->Update();

  gStyle->SetPalette(55);
  c2->Show();
  c2->Update();
  c2->Divide(1, 2);
  c2->cd(1);

  gPad->Modified();
  hThSCATvsX1->Draw("COLZ");
  hThSCATvsX1->GetXaxis()->SetRangeUser(peak_pos - 20, peak_pos + 40);
  c2->Update();

  gSystem->ProcessEvents();

  c2->cd(2);

  TH1D *projX;

  TF1 *gaus = new TF1("func", "gaus(0)", 0, 10);
  gaus->SetParameters(1, peak_pos, peak_width);

  binMin = hThSCATvsX1->GetYaxis()->FindBin(lo_th);
  binMax = hThSCATvsX1->GetYaxis()->FindBin(hi_th);

  sliceBinWidth = (binMax - binMin) / intervals;
  sliceUserWidth = (hi_th - lo_th) / intervals;
	

double *x = new double[intervals];	
double *y = new double[intervals];	
double *height = new double[intervals];	


  for (int i = 0; i < intervals; ++i) {

    projX = hThSCATvsX1->ProjectionX("px", i * sliceBinWidth + binMin,
                                     (i + 1) * sliceBinWidth + binMin, "");

    projX->GetXaxis()->SetRangeUser(peak_pos - 20, peak_pos + 40);
    projX->Draw();

    projX->Fit("func", "Q", "", gaus->GetParameter(1) - peak_width,
               gaus->GetParameter(1) + peak_width);

    height[i] = gaus->GetParameter(0);

    // Sometimes errors happen!
    // the following code was for GR data but is still fine for k600... I think
    //if ((gaus->GetParameter(1)) > -600) {

      projX->Draw("");
      c2->Update();

      x[i] = gaus->GetParameter(1);
      y[i] = lo_th + i * sliceUserWidth + sliceUserWidth / 2;

      gSystem->ProcessEvents();
      gaus->SetParameters(gaus->GetParameter(0), gaus->GetParameter(1),
                          gaus->GetParameter(2));

    /*} else {
      c2->Update();
      x[i] = x[i - 1];
      y[i] = lo_th + i * sliceUserWidth + sliceUserWidth / 2;
      gSystem->ProcessEvents();
      gaus->SetParameters(height[i - 1], x[i], 2 * peak_width);
    }
    usleep(delay);*/
  }

  TGraph *gr1 = new TGraph(intervals, y, x);

  gr1->Draw("AC*");

  stringstream sstm;
  sstm << "pol" << th_o;
  string polS = sstm.str();

  stringstream sstm2;
  sstm2 << "Peak at x = " << peak_pos << " fitted with Pol " << 6;
  string graphTitle = sstm2.str();

  gr1->SetTitle(graphTitle.c_str());

  TF1 *polN = new TF1("pol", polS.c_str(), 0, 10);
  gr1->Fit("pol", "Q");

  TSpline3 *s = new TSpline3("grs", gr1);
  s->SetLineColor(kGreen);
  s->Draw("SAME");

  std::vector<double> out_par;

  for (int i = 0; i <= th_o; ++i) {
    out_par.push_back(polN->GetParameter(i));
    if (i > 0) {
      std::cout << out_par[i] << " ";
    }
  }
  std::cout << std::endl;
  std::string opt_corr = "thetaSCAT:X1posO-(";

  for (int i = 1; i <= th_o; ++i) {

stringstream ss_1;
ss_1 << out_par[i];
string str_1 = ss_1.str();

stringstream ss_2;
ss_2 << i;
string str_2 = ss_2.str();



    opt_corr +=
        "(" + str_1 + ")*(thetaSCAT**" + str_2 + ")";

    if (i < th_o) {
      opt_corr += " + ";
    }
  }

  opt_corr += ")>>hThSCATvsX1";

  std::cout << "" << std::endl;

  std::cout << opt_corr << std::endl;

  TCanvas *c0 = new TCanvas("c0", "Test", 800, 600);

  tree->Draw(opt_corr.c_str(), opt.c_str(), "col");

////After loading this script, copy this line into terminal and modify it to suit the data of interest ///
//line_shape_single(DATA,"CUTpad1tof && CUTtofX1 && X1flag==0 && U1flag==0 && X2flag==0 && Y1>-10 && Y1<25",537.0,3,-1.9,1.9,20,5)



}
