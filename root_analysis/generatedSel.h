/////////////////////////////////////////////////////////////////////////
//   This class has been automatically generated 
//   (at Mon Apr  2 20:31:20 2018 by ROOT version 5.34/36)
//   from TTree DATA/K600 data
//   found on file: /home/chane/K600/Data/PR236/sorted03146.root
/////////////////////////////////////////////////////////////////////////


#ifndef generatedSel_h
#define generatedSel_h

// System Headers needed by the proxy
#if defined(__CINT__) && !defined(__MAKECINT__)
   #define ROOT_Rtypes
   #define ROOT_TError
#endif
#include <TROOT.h>
#include <TChain.h>
#include <TFile.h>
#include <TPad.h>
#include <TH1.h>
#include <TSelector.h>
#include <TBranchProxy.h>
#include <TBranchProxyDirector.h>
#include <TBranchProxyTemplate.h>
#include <TFriendProxy.h>
using namespace ROOT;

// forward declarations needed by this particular proxy


// Header needed by this particular proxy


class CUTtofX1_Interface {
   // This class defines the list of methods that are directly used by generatedSel,
   // and that can be overloaded in the user's script
public:
   void CUTtofX1_Begin(TTree*) {}
   void CUTtofX1_SlaveBegin(TTree*) {}
   Bool_t CUTtofX1_Notify() { return kTRUE; }
   Bool_t CUTtofX1_Process(Long64_t) { return kTRUE; }
   void CUTtofX1_SlaveTerminate() {}
   void CUTtofX1_Terminate() {}
};


class generatedSel : public TSelector, public CUTtofX1_Interface {
public :
   TTree          *fChain;         //!pointer to the analyzed TTree or TChain
   TH1            *htemp;          //!pointer to the histogram
   TBranchProxyDirector fDirector; //!Manages the proxys

   // Optional User methods
   TClass         *fClass;    // Pointer to this class's description

   // Proxy for each of the branches, leaves and friends of the tree
   TIntProxy           t_runtime;
   TIntProxy           t_evtcounter;
   TIntProxy           t_tdcsperevent;
   TIntProxy           t_triggerI;
   TIntProxy           t_triggerU;
   TIntProxy           t_CIU;
   TIntProxy           t_CII;
   TIntProxy           t_tof;
   TIntProxy           t_toftdc1;
   TIntProxy           t_toftdc2;
   TIntProxy           t_toftdc3;
   TIntProxy           t_toftdc4;
   TIntProxy           t_toftdc5;
   TIntProxy           t_toftdc6;
   TIntProxy           t_toftdc7;
   TIntProxy           t_k600;
   TDoubleProxy        t_pad1;
   TDoubleProxy        t_pad2;
   TDoubleProxy        t_pad1hiP;
   TDoubleProxy        t_pad1lowP;
   TDoubleProxy        t_pad2hiP;
   TDoubleProxy        t_pad2lowP;
   TDoubleProxy        t_pad1hiPT;
   TDoubleProxy        t_pad1lowPT;
   TDoubleProxy        t_pad2hiPT;
   TDoubleProxy        t_pad2lowPT;
   TDoubleProxy        t_X1pos;
   TDoubleProxy        t_X1th;
   TIntProxy           t_X1flag;
   TDoubleProxy        t_X1chisq;
   TDoubleProxy        t_X1res0;
   TDoubleProxy        t_X1res1;
   TIntProxy           t_X1hits;
   TDoubleProxy        t_X1effID;
   TDoubleProxy        t_X1effall;
   TDoubleProxy        t_X1effdt;
   TDoubleProxy        t_X1effgroup;
   TDoubleProxy        t_X1effgood;
   TIntProxy           t_nX1wiresUsed;
   TIntProxy           t_X1doublewires;
   TIntProxy           t_X1multiplemin;
   TDoubleProxy        t_X1TimeDiff;
   TArrayIntProxy      t_X1wireUsed;
   TArrayDoubleProxy   t_X1distUsed;
   TDoubleProxy        t_U1pos;
   TDoubleProxy        t_U1th;
   TIntProxy           t_U1flag;
   TDoubleProxy        t_U1chisq;
   TDoubleProxy        t_U1res0;
   TDoubleProxy        t_U1res1;
   TDoubleProxy        t_U1effID;
   TIntProxy           t_U1hits;
   TDoubleProxy        t_U1effall;
   TDoubleProxy        t_U1effdt;
   TDoubleProxy        t_U1effgroup;
   TDoubleProxy        t_U1effgood;
   TIntProxy           t_nU1wiresUsed;
   TIntProxy           t_U1doublewires;
   TIntProxy           t_U1multiplemin;
   TArrayIntProxy      t_U1wireUsed;
   TArrayDoubleProxy   t_U1distUsed;
   TDoubleProxy        t_X2pos;
   TDoubleProxy        t_X2th;
   TIntProxy           t_X2flag;
   TDoubleProxy        t_X2chisq;
   TDoubleProxy        t_X2res0;
   TDoubleProxy        t_X2res1;
   TDoubleProxy        t_X2effID;
   TIntProxy           t_X2hits;
   TDoubleProxy        t_X2effall;
   TDoubleProxy        t_X2effdt;
   TDoubleProxy        t_X2effgroup;
   TDoubleProxy        t_X2effgood;
   TIntProxy           t_nX2wiresUsed;
   TIntProxy           t_X2doublewires;
   TIntProxy           t_X2multiplemin;
   TArrayIntProxy      t_X2wireUsed;
   TDoubleProxy        t_U2pos;
   TDoubleProxy        t_U2th;
   TIntProxy           t_U2flag;
   TDoubleProxy        t_U2chisq;
   TDoubleProxy        t_U2res0;
   TDoubleProxy        t_U2res1;
   TDoubleProxy        t_U2effID;
   TIntProxy           t_U2hits;
   TDoubleProxy        t_U2effall;
   TDoubleProxy        t_U2effdt;
   TDoubleProxy        t_U2effgroup;
   TDoubleProxy        t_U2effgood;
   TIntProxy           t_nU2wiresUsed;
   TIntProxy           t_U2doublewires;
   TIntProxy           t_U2multiplemin;
   TArrayIntProxy      t_U2wireUsed;
   TDoubleProxy        t_thetaFP;
   TDoubleProxy        t_thetaFPx;
   TDoubleProxy        t_phiFP;
   TDoubleProxy        t_Y1;
   TDoubleProxy        t_Y2;
   TIntProxy           t_pulser;
   TDoubleProxy        t_X1posC;
   TDoubleProxy        t_X1posO;
   TDoubleProxy        t_Ex;
   TDoubleProxy        t_ExC;
   TDoubleProxy        t_T3;
   TDoubleProxy        t_rigidity3;
   TDoubleProxy        t_theta;
   TDoubleProxy        t_thetaSCAT;
   TDoubleProxy        t_phiSCAT;


   generatedSel(TTree *tree=0) : 
      fChain(0),
      htemp(0),
      fDirector(tree,-1),
      fClass                (TClass::GetClass("generatedSel")),
      t_runtime          (&fDirector,"runtime"),
      t_evtcounter       (&fDirector,"evtcounter"),
      t_tdcsperevent     (&fDirector,"tdcsperevent"),
      t_triggerI         (&fDirector,"triggerI"),
      t_triggerU         (&fDirector,"triggerU"),
      t_CIU              (&fDirector,"CIU"),
      t_CII              (&fDirector,"CII"),
      t_tof              (&fDirector,"tof"),
      t_toftdc1          (&fDirector,"toftdc1"),
      t_toftdc2          (&fDirector,"toftdc2"),
      t_toftdc3          (&fDirector,"toftdc3"),
      t_toftdc4          (&fDirector,"toftdc4"),
      t_toftdc5          (&fDirector,"toftdc5"),
      t_toftdc6          (&fDirector,"toftdc6"),
      t_toftdc7          (&fDirector,"toftdc7"),
      t_k600             (&fDirector,"k600"),
      t_pad1             (&fDirector,"pad1"),
      t_pad2             (&fDirector,"pad2"),
      t_pad1hiP          (&fDirector,"pad1hiP"),
      t_pad1lowP         (&fDirector,"pad1lowP"),
      t_pad2hiP          (&fDirector,"pad2hiP"),
      t_pad2lowP         (&fDirector,"pad2lowP"),
      t_pad1hiPT         (&fDirector,"pad1hiPT"),
      t_pad1lowPT        (&fDirector,"pad1lowPT"),
      t_pad2hiPT         (&fDirector,"pad2hiPT"),
      t_pad2lowPT        (&fDirector,"pad2lowPT"),
      t_X1pos            (&fDirector,"X1pos"),
      t_X1th             (&fDirector,"X1th"),
      t_X1flag           (&fDirector,"X1flag"),
      t_X1chisq          (&fDirector,"X1chisq"),
      t_X1res0           (&fDirector,"X1res0"),
      t_X1res1           (&fDirector,"X1res1"),
      t_X1hits           (&fDirector,"X1hits"),
      t_X1effID          (&fDirector,"X1effID"),
      t_X1effall         (&fDirector,"X1effall"),
      t_X1effdt          (&fDirector,"X1effdt"),
      t_X1effgroup       (&fDirector,"X1effgroup"),
      t_X1effgood        (&fDirector,"X1effgood"),
      t_nX1wiresUsed     (&fDirector,"nX1wiresUsed"),
      t_X1doublewires    (&fDirector,"X1doublewires"),
      t_X1multiplemin    (&fDirector,"X1multiplemin"),
      t_X1TimeDiff       (&fDirector,"X1TimeDiff"),
      t_X1wireUsed       (&fDirector,"X1wireUsed"),
      t_X1distUsed       (&fDirector,"X1distUsed"),
      t_U1pos            (&fDirector,"U1pos"),
      t_U1th             (&fDirector,"U1th"),
      t_U1flag           (&fDirector,"U1flag"),
      t_U1chisq          (&fDirector,"U1chisq"),
      t_U1res0           (&fDirector,"U1res0"),
      t_U1res1           (&fDirector,"U1res1"),
      t_U1effID          (&fDirector,"U1effID"),
      t_U1hits           (&fDirector,"U1hits"),
      t_U1effall         (&fDirector,"U1effall"),
      t_U1effdt          (&fDirector,"U1effdt"),
      t_U1effgroup       (&fDirector,"U1effgroup"),
      t_U1effgood        (&fDirector,"U1effgood"),
      t_nU1wiresUsed     (&fDirector,"nU1wiresUsed"),
      t_U1doublewires    (&fDirector,"U1doublewires"),
      t_U1multiplemin    (&fDirector,"U1multiplemin"),
      t_U1wireUsed       (&fDirector,"U1wireUsed"),
      t_U1distUsed       (&fDirector,"U1distUsed"),
      t_X2pos            (&fDirector,"X2pos"),
      t_X2th             (&fDirector,"X2th"),
      t_X2flag           (&fDirector,"X2flag"),
      t_X2chisq          (&fDirector,"X2chisq"),
      t_X2res0           (&fDirector,"X2res0"),
      t_X2res1           (&fDirector,"X2res1"),
      t_X2effID          (&fDirector,"X2effID"),
      t_X2hits           (&fDirector,"X2hits"),
      t_X2effall         (&fDirector,"X2effall"),
      t_X2effdt          (&fDirector,"X2effdt"),
      t_X2effgroup       (&fDirector,"X2effgroup"),
      t_X2effgood        (&fDirector,"X2effgood"),
      t_nX2wiresUsed     (&fDirector,"nX2wiresUsed"),
      t_X2doublewires    (&fDirector,"X2doublewires"),
      t_X2multiplemin    (&fDirector,"X2multiplemin"),
      t_X2wireUsed       (&fDirector,"X2wireUsed"),
      t_U2pos            (&fDirector,"U2pos"),
      t_U2th             (&fDirector,"U2th"),
      t_U2flag           (&fDirector,"U2flag"),
      t_U2chisq          (&fDirector,"U2chisq"),
      t_U2res0           (&fDirector,"U2res0"),
      t_U2res1           (&fDirector,"U2res1"),
      t_U2effID          (&fDirector,"U2effID"),
      t_U2hits           (&fDirector,"U2hits"),
      t_U2effall         (&fDirector,"U2effall"),
      t_U2effdt          (&fDirector,"U2effdt"),
      t_U2effgroup       (&fDirector,"U2effgroup"),
      t_U2effgood        (&fDirector,"U2effgood"),
      t_nU2wiresUsed     (&fDirector,"nU2wiresUsed"),
      t_U2doublewires    (&fDirector,"U2doublewires"),
      t_U2multiplemin    (&fDirector,"U2multiplemin"),
      t_U2wireUsed       (&fDirector,"U2wireUsed"),
      t_thetaFP          (&fDirector,"thetaFP"),
      t_thetaFPx         (&fDirector,"thetaFPx"),
      t_phiFP            (&fDirector,"phiFP"),
      t_Y1               (&fDirector,"Y1"),
      t_Y2               (&fDirector,"Y2"),
      t_pulser           (&fDirector,"pulser"),
      t_X1posC           (&fDirector,"X1posC"),
      t_X1posO           (&fDirector,"X1posO"),
      t_Ex               (&fDirector,"Ex"),
      t_ExC              (&fDirector,"ExC"),
      t_T3               (&fDirector,"T3"),
      t_rigidity3        (&fDirector,"rigidity3"),
      t_theta            (&fDirector,"theta"),
      t_thetaSCAT        (&fDirector,"thetaSCAT"),
      t_phiSCAT          (&fDirector,"phiSCAT")
      { }
   ~generatedSel();
   Int_t   Version() const {return 1;}
   void    Begin(::TTree *tree);
   void    SlaveBegin(::TTree *tree);
   void    Init(::TTree *tree);
   Bool_t  Notify();
   Bool_t  Process(Long64_t entry);
   void    SlaveTerminate();
   void    Terminate();

   ClassDef(generatedSel,0);


//inject the user's code
#include "CUTtofX1.root"
};

#endif


#ifdef __MAKECINT__
#pragma link C++ class generatedSel;
#endif


inline generatedSel::~generatedSel() {
   // destructor. Clean up helpers.

}

inline void generatedSel::Init(TTree *tree)
{
//   Set branch addresses
   if (tree == 0) return;
   fChain = tree;
   fDirector.SetTree(fChain);
   if (htemp == 0) {
      htemp = fDirector.CreateHistogram(GetOption());
      htemp->SetTitle("CUTtofX1.root");
      fObject = htemp;
   }
}

Bool_t generatedSel::Notify()
{
   // Called when loading a new file.
   // Get branch pointers.
   fDirector.SetTree(fChain);
   CUTtofX1_Notify();
   
   return kTRUE;
}
   

inline void generatedSel::Begin(TTree *tree)
{
   // The Begin() function is called at the start of the query.
   // When running with PROOF Begin() is only called on the client.
   // The tree argument is deprecated (on PROOF 0 is passed).

   TString option = GetOption();
   CUTtofX1_Begin(tree);

}

inline void generatedSel::SlaveBegin(TTree *tree)
{
   // The SlaveBegin() function is called after the Begin() function.
   // When running with PROOF SlaveBegin() is called on each slave server.
   // The tree argument is deprecated (on PROOF 0 is passed).

   Init(tree);

   CUTtofX1_SlaveBegin(tree);

}

inline Bool_t generatedSel::Process(Long64_t entry)
{
   // The Process() function is called for each entry in the tree (or possibly
   // keyed object in the case of PROOF) to be processed. The entry argument
   // specifies which entry in the currently loaded tree is to be processed.
   // It can be passed to either TTree::GetEntry() or TBranch::GetEntry()
   // to read either all or the required parts of the data. When processing
   // keyed objects with PROOF, the object is already loaded and is available
   // via the fObject pointer.
   //
   // This function should contain the "body" of the analysis. It can contain
   // simple or elaborate selection criteria, run algorithms on the data
   // of the event and typically fill histograms.

   // WARNING when a selector is used with a TChain, you must use
   //  the pointer to the current TTree to call GetEntry(entry).
   //  The entry is always the local entry number in the current tree.
   //  Assuming that fChain is the pointer to the TChain being processed,
   //  use fChain->GetTree()->GetEntry(entry).


   fDirector.SetReadEntry(entry);
   htemp->Fill(CUTtofX1());
   CUTtofX1_Process(entry);
   return kTRUE;

}

inline void generatedSel::SlaveTerminate()
{
   // The SlaveTerminate() function is called after all entries or objects
   // have been processed. When running with PROOF SlaveTerminate() is called
   // on each slave server.
   CUTtofX1_SlaveTerminate();
}

inline void generatedSel::Terminate()
{
   // Function called at the end of the event loop.
   htemp = (TH1*)fObject;
   Int_t drawflag = (htemp && htemp->GetEntries()>0);
   
   if (gPad && !drawflag && !fOption.Contains("goff") && !fOption.Contains("same")) {
      gPad->Clear();
   } else {
      if (fOption.Contains("goff")) drawflag = false;
      if (drawflag) htemp->Draw(fOption);
   }
   CUTtofX1_Terminate();
}
