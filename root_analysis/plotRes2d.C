{
  //gROOT->Reset();

  c2 = new TCanvas("c2","The evolution of the Res2D plot with offset",10,10,900,600);
  c2->SetFillColor(9);
  c2->SetGridy(0);

  TPad* pad2 = new TPad("pad2","Spectra",0.01,0.01,0.99,0.99);
  pad2->Draw();
  pad2->cd();
  pad2->Divide(2,2);

TCut CUTbasic = "tof>4700 && tof<4900 && pad1>1200 && pad1<2100";


pad2->cd(1);
DATA->Draw("X1res1:X1res0>>hX1Res2d",CUTbasic,"col");
//DATA->Draw("X1res1:X1res0>>hX1Res2d","CUTpad1tof","col");

pad2->cd(2);
DATA->Draw("U1res1:U1res0>>hU1Res2d",CUTbasic,"col");
//DATA->Draw("U1res1:U1res0>>hU1Res2d","CUTpad1tof","col");

pad2->cd(3);
DATA->Draw("X2res1:X2res0>>hX2Res2d",CUTbasic,"col");
//DATA->Draw("X2res1:X2res0>>hX2Res2d","CUTpad1tof","col");

pad2->cd(4);
DATA->Draw("U2res1:U2res0>>hU2Res2d",CUTbasic,"col");
//DATA->Draw("U2res1:U2res0>>hU2Res2d","CUTpad1tof","col");

}
