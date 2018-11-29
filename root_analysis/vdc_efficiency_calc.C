{
  double sampling_ratio = 0.01;

  int *x1fl,*u1fl,*u2fl;

  int numentries;
  int cnt0000=0,cnt1000=0,cnt0100=0,cnt0010=0,cnt0001=0;
  double x1eff=0.0,u1eff=0.0,u2eff=0.0,toteff=1.0;

  DATAChain->SetBranchAddress("X1flag",&x1fl);
  DATAChain->SetBranchAddress("U1flag",&u1fl);
  DATAChain->SetBranchAddress("U2flag",&u2fl);

  numentries = DATAChain->GetEntries();


  for(int i=0;i<(int)((double)numentries*sampling_ratio);++i){
    DATAChain->GetEntry(i);
    if     (x1fl==0&&u1fl==0&&u2fl==0) ++cnt0000;
    else if(x1fl!=0&&u1fl==0&&u2fl==0) ++cnt1000;
    else if(x1fl==0&&u1fl!=0&&u2fl==0) ++cnt0100;
    else if(x1fl==0&&u1fl==0&&u2fl!=0) ++cnt0001;
  }

  toteff = 1.0;

  if(cnt0000==0){
    fprintf(stderr,"ERROR : No good event obtained.\n");
    return;
  }

  if(cnt1000==0)
    x1eff = 0.0;
  else{
    x1eff = (double)cnt0000/((double)cnt0000+(double)cnt1000);
    toteff *= x1eff;
  }

  if(cnt0100==0)
    u1eff = 0.0;
  else{
    u1eff = (double)cnt0000/((double)cnt0000+(double)cnt0100);
    toteff *= u1eff;
  }

    if(cnt0001==0)
    u2eff = 0.0;
  else{
    u2eff = (double)cnt0000/((double)cnt0000+(double)cnt0001);
    toteff *= u2eff;
  }

  printf("Wire-plane efficiency\n");
  if(x1eff==0.0) printf("  X1    : ----- \% (No entry)\n");
  else           printf("  X1    : %4.2f \%\n",x1eff*100);
  if(u1eff==0.0) printf("  U1    : ----- \% (No entry)\n");
  else           printf("  U1    : %4.2f \%\n",u1eff*100);
  if(u2eff==0.0) printf("  U2    : ----- \% (No entry)\n");
  else           printf("  U2    : %4.2f \%\n",u2eff*100);
  printf("  Total : %4.2f \%\n",toteff*100);
  printf("%d entries used (sampling ratio : %4.3f)\n",i,sampling_ratio);
}