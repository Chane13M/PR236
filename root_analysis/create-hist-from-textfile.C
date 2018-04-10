{
  TString file;
  TString pathname="/home/neveling/K600/PR264-Aarhus-3Hed/ANALYSIS/";
  TString filename="CableLength.dat";
  file=pathname+filename;
  //cout << "file " <<file<<endl;


  double offset[896];
  int channel=0;
  Char_t file_name[100];
//==================read input=======================
  sprintf(file_name,"%s",file.Data());
  ifstream inputfile(file_name);  
  if(!inputfile)  { 
    cerr<<"Can't open input file, -> exit"<<endl; 
    exit(1);
  }
  else cerr << "Opening file " <<file_name<<endl;

  while(!inputfile.eof()){     
	inputfile >> offset[channel];
	//inputfile >> channel[counter] >> offset[counter];
	//cout<<"   "<<counter<<"   "<<channel[counter]<<" "<<offset[counter]<<" "<<err[counter]<<"  "<<endl;	
	channel++;
  }
//==================create histogram=======================
  TH1F *hCableLength = new TH1F("hCableLength","time offsets",896,0.,895.);
  for(Int_t j = 0; j < (channel-1); j++) {
	   hCableLength->SetBinContent(j,offset[j]);
  }

  inputfile.close();


  TH1F *hCableLengthNic = new TH1F("CableLengthNic","time offsets",896,0.,895.);

}

hCableLengthNic->Add(hCableLength);

