{
//gStyle->SetPalette(1,0);


Char_t name1[30];
     
sprintf(name1,".x rd_gate_tofX1.C");
gROOT->ProcessLine(name1);
sprintf(name1,".x rd_gate_pad1tof.C");
gROOT->ProcessLine(name1);

//sprintf(name1,"_file0->cd()");
//gROOT->ProcessLine(name1);

sprintf(name1,".x histosPR236.C");
gROOT->ProcessLine(name1);

TCut CUTbasic = "CUTpad1tof  && CUTtofX1 ";
TCut CUTflags = "X1flag==0 && U1flag==0 && U2flag==0"; 
TCut CUTlimits = "X1pos>-100";
// && thetaSCAT>-2. && thetaSCAT<2.";
TCut CUTtrigvsCI = "triggerI/CII<3";

//uncomment depending on isotope all are for weekend 1
//values for 24Mg for weekend 2
/*
TCut CUTy = "Y1>-3 && Y1<21"; //18
TCut CUTYbck1 = "Y1<-3 && Y1>-22"; //18
TCut CUTYbck2 = "Y1<-22 && Y1>-41"; //18
TCut CUTybckg = "Y1>-41 && Y1<-3"; //36
TCut CUTyback2 = "Y1<-22 && Y1>-41";
TCut CUTyback1 = "Y1<-3 && Y1>-22";
*/

//values for 90Zr weekend 2
/*
TCut CUTy = "Y1>-12.5 && Y1<16.5"; //18
TCut CUTYbck1 = "Y1<-12.5 && Y1>-28"; //18
TCut CUTYbck2 = "Y1<-28 && Y1>-43.5"; //18
TCut CUTybckg = "Y1>-12.5 && Y1<-43.5"; //36
TCut CUTyback2 = "Y1<-28 && Y1>-43.5";
TCut CUTyback1 = "Y1<-12.5 && Y1>-28";
*/

      

//values for weekend 3 with 24 mg runs
/*
TCut CUTy = "Y1>-7 && Y1<22"; //15
TCut CUTYbck1 = "Y1<-7 && Y1>-25"; //18
TCut CUTYbck2 = "Y1<-25 && Y1>-43"; //18
TCut CUTybckg = "Y1>-43 && Y1<-7"; //36
TCut CUTyback2 = "Y1<-25 && Y1>-43";
TCut CUTyback1 = "Y1<-7 && Y1>-25";
*/

//for 58Ni from weekend 3

TCut CUTy = "Y1>-10 && Y1<22"; //15
TCut CUTYbck1 = "Y1<-10 && Y1>-20"; //18
TCut CUTYbck2 = "Y1<-20 && Y1>-30"; //18
TCut CUTybckg = "Y1>-30 && Y1<-10"; //36
TCut CUTyback2 = "Y1<-20 && Y1>-30";
TCut CUTyback1 = "Y1<-10 && Y1>-20";



}
