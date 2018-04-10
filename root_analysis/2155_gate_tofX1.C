{
// you have to first plot the

TCutG *cut=new TCutG();
CUTtofX1 = (TCutG*) gPad -> WaitPrimitive("CUTG");

CUTtofX1 -> SetName("CUTtofX1"); 
CUTtofX1 -> SetVarX("X1pos");
CUTtofX1 -> SetVarY("tof");

// uncomment next section only if you want to write the gate to somewhere

file20 = new TFile("CUTtofX1.root","NEW");
CUTtofX1 -> Write();
file20 -> ls();
file20 -> Close();

// in order to get back to the root file you were looking at
// you should cd back into that file:     file->cd()

}
