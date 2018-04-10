{
  // number of entries used for efficiency calculation
  //  int numentries = 100000;

  double sampling_ratio = 0.05; // 0.1:10% of the whole data will be used

  //  int *x1fl = new int();
  //  int *u1fl = new int();
  //  int *x2fl = new int();
  //  int *u2fl = new int();
  int *x1fl,*u1fl,*x2fl,*u2fl;

  int numentries;
  int cnt0000=0,cnt1000=0,cnt0100=0,cnt0010=0,cnt0001=0;
  double x1eff=0.0,u1eff=0.0,x2eff=0.0,u2eff=0.0,toteff=1.0;

  DATA->SetBranchAddress("X1flag",&x1fl);
  DATA->SetBranchAddress("U1flag",&u1fl);
  DATA->SetBranchAddress("X2flag",&x2fl);
  DATA->SetBranchAddress("U2flag",&u2fl);

  numentries = DATA->GetEntries();

  // if you want to go through the end of rootfile ------
  /*
  i=0;
  while(DATA->GetEntry(i)){
    if     (x1fl==0&&u1fl==0&&x2fl==0&&u2fl==0) ++cnt0000;
    else if(x1fl!=0&&u1fl==0&&x2fl==0&&u2fl==0) ++cnt1000;
    else if(x1fl==0&&u1fl!=0&&x2fl==0&&u2fl==0) ++cnt0100;
    else if(x1fl==0&&u1fl==0&&x2fl!=0&&u2fl==0) ++cnt0010;
    else if(x1fl==0&&u1fl==0&&x2fl==0&&u2fl!=0) ++cnt0001;
    ++i;
  }
  */
  // ----------------------------------------------------

  //  for(int i=0;i<numentries;++i){
  for(int i=0;i<(int)((double)numentries*sampling_ratio);++i){
    DATA->GetEntry(i);
    if     (x1fl==0&&u1fl==0&&x2fl==0&&u2fl==0) ++cnt0000;
    else if(x1fl!=0&&u1fl==0&&x2fl==0&&u2fl==0) ++cnt1000;
    else if(x1fl==0&&u1fl!=0&&x2fl==0&&u2fl==0) ++cnt0100;
    else if(x1fl==0&&u1fl==0&&x2fl!=0&&u2fl==0) ++cnt0010;
    else if(x1fl==0&&u1fl==0&&x2fl==0&&u2fl!=0) ++cnt0001;
  }

  //  printf("%d/%d/%d/%d/%d\n",cnt0000,cnt1000,cnt0100,cnt0010,cnt0001);
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

  if(cnt0010==0)
    x2eff = 0.0;
  else{
    x2eff = (double)cnt0000/((double)cnt0000+(double)cnt0010);
    toteff *= x2eff;
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
  if(x2eff==0.0) printf("  X2    : ----- \% (No entry)\n");
  else           printf("  X2    : %4.2f \%\n",x2eff*100);
  if(u2eff==0.0) printf("  U2    : ----- \% (No entry)\n");
  else           printf("  U2    : %4.2f \%\n",u2eff*100);
  printf("  Total : %4.2f \%\n",toteff*100);
  printf("%d entries used (sampling ratio : %4.3f)\n",i,sampling_ratio);
}
