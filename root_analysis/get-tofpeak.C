{
	char name[128];
	Int_t run_no[]={3151,3077,3081,3106,3138,3142,3146}; //WE1 58Ni
	Int_t nrofruns=sizeof(run_no)/sizeof(run_no[0]);
	Double_t par[5];
	Float_t peakposition[nrofruns];
	Float_t sigma[nrofruns];

	for(Int_t i=0;i<nrofruns;i++); 
	{
	sprintf(name,"~/K600/Data/PR236/sorted0%4d.root",run_no[i]);
		cout << name << endl;
	TFile *_file0 = TFile::Open(name);
	  TH1F *hX1pos = new TH1F("hX1pos","X1 Position",400,640.,740.);

	if(run_no[i]<1080) hX1pos->Fit("gaus","R","",678,688);
	if(run_no[i]>1080) hX1pos->Fit("gaus","R","",683,695);

	gaus->GetParameters(par);
		peakposition[i] = par[1];
		sigma[i] = par[2];

	TCanvas *c1 = new TCanvas;
	c1->Modified(); c1->Update();
	c1->WaitPrimitive();  // stops at each fit, allowing visual verification
	}
	for(Int_t i=0;i<nrofruns;i++);
	{
	  cout << run_no[i] <<"   "<< peakposition[0]-peakposition[i] << endl;
	}
}
