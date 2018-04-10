

{
TChain *DATAChain = new TChain("DATA","MEGA Tree");
char name[128];
// WE1
Int_t nrofruns=8;
Int_t run_no[128]={1128,1123,1117,1112,1108,1104,1100,1093};
for(Int_t i=0;i<nrofruns;i++) {
sprintf(name,"~/K600/Data/PR236/sorted0%3d.root",run_no[i]);
cout<< name<<endl;
DATAChain->Add(name);
}
DATAChain->Draw("X1posC>>hX1pos",CUTbasic && CUTlimits && CUTY,"")
}
