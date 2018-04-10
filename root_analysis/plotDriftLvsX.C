{
	TH2F *hX1DriftLvsX1 = new TH2F("hX1DriftLvsX1","X1 DriftLength vs X1 Position",1600,0.,800.,110,-1.,10.);
	TH2F *hU1DriftLvsU1 = new TH2F("hU1DriftLvsU1","U1 DriftLength vs U1 Position",1600,0.,800.,110,-1.,10.);
	TH2F *hX2DriftLvsX2 = new TH2F("hX2DriftLvsX2","X2 DriftLength vs X2 Position",1600,0.,800.,110,-1.,10.);
	TH2F *hU2DriftLvsU2 = new TH2F("hU2DriftLvsU2","U2 DriftLength vs U2 Position",1600,0.,800.,110,-1.,10.);

	c4 = new TCanvas("c4","The drift length spectra vs position for the four wireplanes",10,10,900,600);
	c4->SetFillColor(9);
	c4->SetGridy(0);
	
	TPad* pad4 = new TPad("pad4","Spectra",0.01,0.01,0.99,0.99);
	pad4->Draw();
	pad4->cd();
	pad4->Divide(2,2);
	
	pad4->cd(1);
	DATA->Draw("abs(X1distUsed):X1pos>>hX1DriftLvsX1","pad1<1960 && pad1>1227 && tof<4862 && tof>4802","col");
	
	pad4->cd(2);
	hU1DriftLvsU1->Draw();
	
	pad4->cd(3);
	hX2DriftLvsX2->Draw();
	
	pad4->cd(4);
	hU2DriftLvsU2->Draw();

}
