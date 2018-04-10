{
	c3 = new TCanvas("c3","The drift length spectra for the four wireplanes",10,10,900,600);
	c3->SetFillColor(9);
	c3->SetGridy(0);
	
	TPad* pad3 = new TPad("pad3","Spectra",0.01,0.01,0.99,0.99);
	pad3->Draw();
	pad3->cd();
	pad3->Divide(2,2);
	
	pad3->cd(1);
	hX1_DriftLength->Draw();
	
	pad3->cd(2);
	hU1_DriftLength->Draw();
	
	pad3->cd(3);
	hX2_DriftLength->Draw();
	
	pad3->cd(4);
	hU2_DriftLength->Draw();

}
