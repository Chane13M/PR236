{
	TH2F *hX1DriftLvsX1 = new TH2F("hX1DriftLvsX1","X1 DriftLength vs X1 Position",200,0.,800.,110,-1.,10.);
	TH2F *hU1DriftLvsU1 = new TH2F("hU1DriftLvsU1","U1 DriftLength vs U1 Position",200,0.,800.,110,-1.,10.);
	TH2F *hX2DriftLvsX2 = new TH2F("hX2DriftLvsX2","X2 DriftLength vs X2 Position",200,0.,800.,110,-1.,10.);
	TH2F *hU2DriftLvsU2 = new TH2F("hU2DriftLvsU2","U2 DriftLength vs U2 Position",200,0.,800.,110,-1.,10.);

	c4 = new TCanvas("c4","The overview for the four wireplanes",10,10,900,600);
	c4->SetFillColor(9);
	c4->SetGridy(0);
	
	TPad* pad4 = new TPad("pad4","Spectra",0.01,0.01,0.99,0.99);
	pad4->Draw();
	pad4->cd();
	pad4->Divide(4,4);

	pad4->cd(1);
	DATA->Draw("X1pos>>hX1pos","","");

	pad4->cd(2);
	DATA->Draw("U1pos>>hU1pos","","");
	
	pad4->cd(3);
	DATA->Draw("X2pos>>hX2pos","","");

	pad4->cd(4);
	DATA->Draw("U2pos>>hU2pos","","");

	pad4->cd(5);
	hX1_DriftLength->Draw();
	
	pad4->cd(6);
	hU1_DriftLength->Draw();
	
	pad4->cd(7);
	hX2_DriftLength->Draw();
	
	pad4->cd(8);
	hU2_DriftLength->Draw();

	pad4->cd(9);
	DATA->Draw("abs(X1distUsed):X1pos>>hX1DriftLvsX1","pad1<1960 && pad1>1227 && tof<4862 && tof>4802","col");
	
	pad4->cd(10);
	DATA->Draw("abs(U1distUsed):U1pos>>hU1DriftLvsU1","pad1<1960 && pad1>1227 && tof<4862 && tof>4802","col");
	
	pad4->cd(11);
	hX2DriftLvsX2->Draw();
	
	pad4->cd(12);
	hU2DriftLvsU2->Draw();


	pad4->cd(13);
	DATA->Draw("X1res1:X1res0>>hX1Res2d","","col");


	pad4->cd(14);
	DATA->Draw("U1res1:U1res0>>hU1Res2d","","col");

	pad4->cd(15);
	DATA->Draw("X2res1:X2res0>>hX2Res2d","","col");

	pad4->cd(16);
	DATA->Draw("U2res1:U2res0>>hU2Res2d","","col");

}
