//---------------------------------------------------------------------------

#ifndef MForm1H
#define MForm1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Grids.hpp>
#include <Dialogs.hpp>
#include <Buttons.hpp>

#include <fstream.h>
#include "CGRID.h"
#include <ComCtrls.hpp>
#include <jpeg.hpp>
#include <vcl\Clipbrd.hpp>

//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
   TButton *Button1;
   TImage *Image1;
   TLabeledEdit *LabeledEdit1;
   TLabeledEdit *LabeledEdit2;
   TStringGrid *SG_data;
   TStringGrid *SG_koef;
   TSaveDialog *SaveDialog1;
   TOpenDialog *OpenDialog1;
   TBevel *Bevel2;
   TBevel *Bevel4;
   TButton *Button2;
   TButton *Button3;
   TButton *Button4;
   TButton *ButtonDelColl;
   void __fastcall Button1Click(TObject *Sender);
   void __fastcall LabeledEdit1Change(TObject *Sender);
   void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
   void __fastcall SG_dataKeyPress(TObject *Sender, char &Key);
   void __fastcall FormResize(TObject *Sender);
   void __fastcall LabeledEdit2KeyPress(TObject *Sender, char &Key);
   void __fastcall LabeledEdit2Change(TObject *Sender);
   void __fastcall SG_dataKeyUp(TObject *Sender, WORD &Key,
          TShiftState Shift);
   void __fastcall Button2Click(TObject *Sender);
   void __fastcall Button3Click(TObject *Sender);
   void __fastcall Button4Click(TObject *Sender);
   void __fastcall SG_dataSelectCell(TObject *Sender, int ACol, int ARow,
          bool &CanSelect);
   void __fastcall ButtonDelCollClick(TObject *Sender);
   void __fastcall ButtonInvert_XYClick(TObject *Sender);
   void __fastcall SG_koefKeyPress(TObject *Sender, char &Key);
   void __fastcall SG_koefSelectCell(TObject *Sender, int ACol, int ARow,
          bool &CanSelect);

private:	// User declarations
   int nData   //число данных
      , nData_max
      , n;     //показатель степени
   float x[1024], y[1024], a[1024];
   float Xmax, Xmin, Ymax, Ymin;
   int SelectedCol, SelectedRow;

   TClipboard* C;

   String FileName;
   bool flEdit;
   void LoadFromFile(String FileName);
   void SaveToFile(String FileName);
   bool GetPos (fstream &file, String &Caption);
   void ShowData(void);
   void DrawData(void);
   POINT ToImage(float x, float y);
   TRect RectImage;
      String source; //в эту переменную нужно записать текст, который в дальнейшем поместится в буфер обмена
      String fromClipboard; //в эту переменную сохраним текст из буфера обмена

public:		// User declarations

   __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
