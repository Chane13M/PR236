{

TFile * file20 = new TFile("CUTpad1tof_run1126.root","OLD");
TCutG *cut   = (TCutG*) file20 -> Get( "CUTpad1tof" );
cut->SetVarX("tof");
cut->SetVarY("pad1");

// in order to get back to the root file you were looking at
// you should cd back into that file:     file->cd()
}
