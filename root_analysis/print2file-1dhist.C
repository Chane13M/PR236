//#include <iostream>

{
  ofstream out;
  //out.open("run2405-fixedmonitor.dat");
  out.open("run2405-inbeammonitor.dat");


  // Now write to a datafile
  for(Int_t i=0;i<500;i++) {
    out << (i) << "  " << Scaler_BLM7->GetBinContent(i)  << endl;
    //out << (i) << "  " << Scaler_BLM8->GetBinContent(i)  << endl;
  }

  out.close();
}
