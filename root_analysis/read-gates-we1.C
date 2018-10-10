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
//values for 26Mg
/*
TCut CUTy = "Y1>-10 && Y1<22";
TCut CUTyback1 = "Y1<-10 && Y1>-25";
TCut CUTyback2 = "Y1<-25 && Y1>-40";     
TCut CUTybckg = "Y1>-40 && Y1<-10"; //will use this when doing a background subtraction
*/

//values for 58Ni
/*
TCut CUTy = "Y1>-12 && Y1<24"; //this is the region of interest
TCut CUTyback1 = "Y1<-12 && Y1>-27";
TCut CUTyback2 = "Y1<-27 && Y1>-42";     
TCut CUTybckg = "Y1>-42 && Y1<-12"; //will use this when doing a background subtraction      
*/

//values for 90Zr
/*
TCut CUTy = "Y1>-12 && Y1<24";
TCut CUTyback1 = "Y1<-12 && Y1>-27";
TCut CUTyback2 = "Y1<-27 && Y1>-42";     
TCut CUTybckg = "Y1>-42 && Y1<-12"; //will use this when doing a background subtraction      
*/

//values for 24Mg for weekend 3 background
/*
TCut CUTy = "Y1>-4 && Y1<25";
TCut CUTyback1 = "Y1<-4 && Y1>-24";
TCut CUTyback2 = "Y1<-24 && Y1>-44";     
TCut CUTybckg = "Y1>-40 && Y1<-4"; //will use this when doing a background subtraction      
*/

//values for 24Mg for weekend 3 with background one side making up total background
/*
TCut CUTy = "Y1>-3 && Y1<24"; //21
TCut CUTYbck1 = "Y1<-3 && Y1>-23"; //20
TCut CUTYbck2 = "Y1<-23 && Y1>-43"; //13
TCut CUTybckg = "Y1>-3 && Y1<-43";
*/

//values for weekend 3 with 24 mg runs
TCut CUTy = "Y1>-7 && Y1<22"; //15
TCut CUTYbck1 = "Y1<-7 && Y1>-25"; //18
TCut CUTYbck2 = "Y1<-25 && Y1>-43"; //18
TCut CUTybckg = "Y1>-7 && Y1<-43"; //36
TCut CUTyback2 = "Y1<-25 && Y1>-43";
TCut CUTyback1 = "Y1<-7 && Y1>-25";

//58Ni for chained data
/*
TCut CUTy = "Y1>-16 && Y1<24";
TCut CUTyback1 = "Y1<-16 && Y1>-30";
TCut CUTyback2 = "Y1<-30 && Y1>-44";     
TCut CUTybckg = "Y1>-44 && Y1<-16";
*/

//90Zr for chained data
/*
TCut CUTy = "Y1>-20 && Y1<26";
TCut CUTyback1 = "Y1<-20 && Y1>-32";
TCut CUTyback2 = "Y1<-32 && Y1>-44";     
TCut CUTybckg = "Y1>-44 && Y1<-20";
*/




}
