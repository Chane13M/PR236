//#include <iostream>

{
  ofstream out;
  out.open("datafile");

  float lut;
  Int_t nbins = hExdiff->GetNbinsX();

  // Now write to a datafile
  for(Int_t i=0;i<nbins;i++) {
    out << i << "  " << hExdiff->GetBinContent(i)  << endl;
    //out << i << "  " << hExdiff->GetBinCenter(i)  << endl;   // give value of xaxis of bin
    //out << hExdiff->GetBinCenter(i)  << "  " << hExdiff->GetBinContent(i)  << endl;   // give value of xaxis of bin

  }

  out.close();
}
