{

TFile * file20 = new TFile("CUTtofX1_run1126.root","OLD");
TCutG *cut   = (TCutG*) file20 -> Get( "CUTtofX1" );
cut->SetVarX("X1pos");
cut->SetVarY("tof");

// in order to get back to the root file you were looking at
// you should cd back into that file:     file->cd()
}
