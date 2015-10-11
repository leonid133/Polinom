//---------------------------------------------------------------------------

#include <math.h>
#include <vcl.h>
#pragma hdrstop

#include "MForm1.h"
#include "about.h"

//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "PERFGRAP"
#pragma link "CGRID"
#pragma resource "*.dfm"

TForm1 *Form1;
//---------------------------------------------------------------------------

__fastcall TForm1::TForm1(TComponent* Owner)
   : TForm(Owner)
   , flEdit(false)
   , nData(2)
   , nData_max(1024)
   , n(0)
   , SelectedCol(1)
   , SelectedRow(1)
{
   C = new TClipboard;

   string tmp;
   String patch(ExtractFilePath(Application->ExeName));
   patch += "start.ini";
   fstream file(patch.c_str());
   if(file)
   {
      char ch, *p;
      p = &ch;
      do
      {
         file.read(p,1);
         if(ch!='\0')
         {
            FileName += ch;
         }   
      }while (!file.eof());
      file.close();
      FileName.SetLength(FileName.Length()-1);
      LoadFromFile(FileName);
   }
   SG_data->ColCount = nData+1;
   SG_data->Cells[0][1]= "     X";
   SG_data->Cells[0][2]= "     Y";
   DrawData();
   ShowData();
}

//---------------------------------------------------------------------------
/*a- массив коэффициентов полинома
  b- массив свободных членов системы уравнений;*/
void __fastcall TForm1::Button1Click(TObject *Sender)
{
   std::numeric_limits <float> float_limits;
   const float min_float = float_limits.epsilon();
   String txt;
   float *b,**sums;
   for(int i = 0; i < 1024; i++)
      a[i]=0;
   b = new float[n+1];
   sums = new float* [n+1];
   for(int i = 0; i < n+1; i++)
      sums[i] = new float[n+1];
   float t;
   for(int i = 1; i < nData; i++)    //упорядочиваем точки по возрастанию абсцисс
 	{
      for(int j = i; j > 0; j--)
      {
         if(x[j] < x[j-1])
  			{
            t = x[j-1];  x[j-1] = x[j];   x[j] = t;
        		t = y[j-1];  y[j-1] = y[j];   y[j] = t;
  			}
      }
 	}
   for(int i = 0; i < n+1; i++)      //заполняем коэффициенты системы уравнений
  	{
      for(int j = 0; j < n+1; j++)
      {
     		sums[i][j] = 0;
	  		for(int k = 0; k < nData; k++)
         {
            if (fabs(x[k]) > min_float)
	  		      sums[i][j] += pow(x[k], i+j);
         }
	  	}
 	}
  	for(int i = 0; i < n+1; i++)      //заполняем столбец свободных членов
  	{
      b[i] = 0;
 	   for(int k = 0; k < nData; k++)
      {
         if (fabs(x[k]) > min_float)
   		   b[i] += pow(x[k], i)*y[k];
      }
   }
	//применяем метод Гаусса для приведения матрицы системы к треугольному виду
   for(int k = 0; k < n+1; k++)
   {
      for(int i = k+1; i < n+1; i++)
      {
         t = sums[i][k]/sums[k][k];
	      for(int j = k; j < n+1; j++)
            sums[i][j] -= t * sums[k][j];
         b[i] -= t*b[k];
      }
   }
   for(int i = n; i >= 0; i--)     //вычисляем коэффициенты аппроксимирующего полинома
   {
      t = 0;
      for(int j = i; j < n+1; j++)
	      t += sums[i][j]*a[j];
      a[i] = (b[i]-t)/sums[i][i];

      txt.sprintf("%f", a[i]);
      SG_koef->Cells[i][1] = txt;
   }
   Image1->Canvas->Rectangle(0, 0, Image1->Width, Image1->Height);
   DrawData();
   float Y, h = (Xmax-Xmin)/RectImage.Width();
   for(float X = Xmin; X < Xmax; X = X+h)
   {
      Y = 0;
      if (fabs(X) > min_float)
      {
         for(int j = 0; j < n+1; j++) //высчитываем значение полинома, заданного своими коэффициентами, в точке Х
            Y += a[j]*pow(X, j);
      }
      POINT p = ToImage(X, Y);
      if (fabs(X-Xmin) < min_float)
         Image1->Canvas->MoveTo(p.x, p.y);
      else
         Image1->Canvas->LineTo(p.x, p.y);
   }
   delete[] a, b, sums;
}

//---------------------------------------------------------------------------
void __fastcall TForm1::LabeledEdit1Change(TObject *Sender)
{
   flEdit = true;
}

//-----------------------------------------------------------------------------
void TForm1::SaveToFile(String FileName)
{
      fstream file;
      file.open(FileName.c_str(), ios:: out);
      if (!file)
         return;
      file << "n = " << n << "\n";
      file << "nData = " << nData <<"\n";

      for(int i = 0; i < nData; i++)
      {
         file << "data" << i << " = " << x[i] << ", " << y[i] << "\n";
      }
      file.close();
      flEdit = false;
}

//----------------------------------------------------------------------------
void TForm1:: LoadFromFile(String FileName)
{
      fstream file;
      file.open(FileName.c_str());
      Form1->Caption = "Полином - " + FileName;
      if (!file)
      {
         file.close();
         return;
      }
      if(GetPos (file, "n"))
         file >> n;
      if(!GetPos (file, "nData"))
      {
         file.close();
         return;
      }

      file >> nData;
      LabeledEdit2->Text = nData;
      SG_data->ColCount = nData+1;
      SG_data->Width = SG_data->DefaultColWidth*(nData+1)+nData+4;

      LabeledEdit1->Text = n;
      SG_koef->ColCount = n+1;
      SG_koef->Width = SG_koef->DefaultColWidth*(n+1)+n+4;

      string temp;    String txt;
      for(int i = 0; i < nData; i++)
      {
         txt.sprintf("data%d", i);
         if(GetPos (file, txt))
            file >> x[i] >> temp >> y[i];
      }
      ShowData();
      DrawData();
      file.close();
      flEdit = false;
      return;
}

//----------------------------------------------------------------------------
bool TForm1::GetPos (fstream &file, String &Caption)
{
      string temp;
      file.seekg(0);
      while (!file.eof() && !file.bad() && !file.fail())
      {
         file >> temp;
         if(temp == Caption.c_str())
         {
            file >> temp;
            return true;
         }
      }
      MessageBox(NULL, "Объект не найден", Caption.c_str(), MB_OK);
      return false;
}

//----------------------------------------------------------------------------
void __fastcall TForm1::FormClose(TObject *Sender, TCloseAction &Action)
{
   if (flEdit)
   {
      int b = Application->MessageBox("Сохранить изменения", "", MB_YESNOCANCEL);
      if (b == IDYES)
         SaveToFile(FileName);
      else if (b == IDCANCEL)
      {
         Action = caNone;
         return;
      }
   }
   String inifile = ExtractFilePath(Application->ExeName)+"start.ini";
   ofstream file(inifile.c_str());
   if (file)
      file << FileName.c_str();

   file.close();
   return;
}

//---------------------------------------------------------------------------
void __fastcall TForm1::SG_dataKeyPress(TObject *Sender, char &Key)
{
   String txt;
   Set <char, '0', '9'> Dig;
	Dig << '0' << '1' << '2' << '3' << '4' << '5' << '6' <<'7'<<'8'<< '9';

   if(Key == 8 || Key == 0x2e) //Забой или точка
		;
	else if(Key == 0x2c) //запятая
	{
   	Key = 0x2e;
   }
   else if(Key == 13)
   {
      Button1Click(Sender);
   }
   else if(Key == 45)
   {          }
   else if(Key == 16)
   {
      //чтение текста из буфера обмена
      char *p;
      C->GetTextBuf(p, 5);
      source = *p;
      SG_data->Cells[SelectedCol][SelectedRow] = source;
   }
	else if ( !Dig.Contains(Key) )
	{
		Key = 0;
		Beep();
	}
   flEdit = true;
}

//---------------------------------------------------------------------------
void __fastcall TForm1::FormResize(TObject *Sender)
{
   LabeledEdit2->Left = 10;
   LabeledEdit2->Top = 20;

   SG_data->Top = LabeledEdit2->BoundsRect.Bottom+5;
   if((SG_data->DefaultColWidth+2)*(LabeledEdit2->Text.ToInt()+2) < (ClientWidth - 20))
   {
      SG_data->Width = (SG_data->DefaultColWidth+1)*(LabeledEdit2->Text.ToInt()+1);
      SG_data->Height = 3*(SG_data->DefaultRowHeight+1);
   }
   else
   {
      SG_data->Width = (ClientWidth - 20);
      SG_data->Height = 3*(SG_data->DefaultRowHeight+1)+22;
   }
   Bevel2->Top = SG_data->Top + SG_data->Height + 10;
   Bevel2->Width = ClientWidth - 10;

   LabeledEdit1->Left = LabeledEdit2->Left;
   LabeledEdit1->Top = Bevel2->Top + 30;

   SG_koef->Top = LabeledEdit1->BoundsRect.Bottom+5;
   if(((SG_koef->DefaultColWidth+2)*(Form1->LabeledEdit1->Text.ToIntDef(0) + 1) + 3) < (ClientWidth - 20))
   {
      SG_koef->Width = (SG_koef->DefaultColWidth+1)*(Form1->LabeledEdit1->Text.ToIntDef(0) + 1);
      SG_koef->Height = 2*(SG_koef->DefaultRowHeight+1);
   }
   else
   {
      SG_koef->Width = (ClientWidth - 20);
      SG_koef->Height = 2*(SG_koef->DefaultRowHeight+1) + 22;
   }

   Bevel4->Top = SG_koef->Top + SG_koef->Height + 10;
   Bevel4->Width = ClientWidth - 10;

   Image1->Left = LabeledEdit2->Left;
   Image1->Top = Bevel4->Top + 10;
   Image1->Width = ClientWidth - 20;
   Image1->Height = ClientHeight - Image1->Top - 10;
   Image1->Canvas->Pen->Color = clBlack;
   Image1->Canvas->Rectangle(0, 0, Image1->Width, Image1->Height);
   RectImage = TRect(5,5,Image1->Width-5,Image1->Height-5);
   Image1->Canvas->Rectangle(RectImage);
   DrawData();
   Button1->Top = LabeledEdit1->Top;

}

//---------------------------------------------------------------------------
void __fastcall TForm1::LabeledEdit2KeyPress(TObject *Sender, char &Key)
{
  	Set <char, '0', '9'> Dig;
	Dig << '0' << '1' << '2' << '3' << '4' << '5' << '6' <<'7'<<'8'<< '9';

   if(Key == 8) //Забой
	{}
   else if (Key == 13)  //Enter
   {
      n = Form1->LabeledEdit1->Text.ToInt();
      nData = Form1->LabeledEdit2->Text.ToInt();

      if(nData<2){nData=2;}
      if(nData>nData_max){nData=nData_max;}
      if(n<0){n=0;}
      if(n>nData-1){n=nData-1;}
      FormResize(this);
      ShowData();
      Button1Click(Sender);
   }
   else if (Key ==45)
   {
      Key = 0;
      Beep();
   }
	else if ( !Dig.Contains(Key) )
	{
		Key = 0;
		Beep();
	}
}

//---------------------------------------------------------------------------
void __fastcall TForm1::LabeledEdit2Change(TObject *Sender)
{
   flEdit = true;
   nData = Form1->LabeledEdit2->Text.ToIntDef(0);
}
//---------------------------------------------------------------------------
void TForm1:: ShowData(void)
{
   SG_data->ColCount = nData+1;
   SG_koef->ColCount = n+1;
   char txt[20];
   for(int i = 0; i < nData; i++)
   {
      sprintf(txt, "       %d", i);
      SG_data->Cells[i+1][0] = txt;
      sprintf(txt, "%.3f", x[i]);
      SG_data->Cells[i+1][1] = txt;
      sprintf(txt, "%.3f", y[i]);
      SG_data->Cells[i+1][2] = txt;
   }
   String k_txt;
   for(int i = 0; i <= n; i++)
   {
      k_txt.sprintf("    a%d", i);
      SG_koef->Cells[i][0] = k_txt;
   }
   LabeledEdit2->Text = nData;
   LabeledEdit1->Text = n;
   FormResize(this);
}
//---------------------------------------------------------------------------
void TForm1:: DrawData(void)
{
   Xmax = Xmin = x[0];
   Ymax = Ymin = y[0];
   for(int i = 0; i < nData; i++) //нахождение максимумов
   {
      if(x[i] > Xmax) Xmax = x[i];
      if(x[i] < Xmin) Xmin = x[i];
      if(y[i] > Ymax) Ymax = y[i];
      if(y[i] < Ymin) Ymin = y[i];
   }
   if((Xmax-Xmin) < 0.1) Xmax = Xmax+1;
   if((Ymax-Ymin) < 0.1) Ymax = Ymax+1;

   Image1->Canvas->Pen->Color = clBlack;
   Image1->Canvas->Rectangle(0, 0, Image1->Width, Image1->Height);
   for(int i = 0; i < nData; i++)
   {
      POINT p = ToImage(x[i], y[i]);
      Image1->Canvas->Ellipse(p.x+5, p.y+5, p.x-5, p.y-5);
   }
}

//--------------------------------------------------------------------------
POINT TForm1:: ToImage(float x, float y)
{
   POINT p;
   p.x = 10+(RectImage.Width()-20)*(x-Xmin)/(Xmax-Xmin);
   p.y = RectImage.Height()-10-(RectImage.Height()-20)*(y-Ymin)/(Ymax-Ymin);
   return p;
}

//--------------------------------------------------------------------------
void __fastcall TForm1::SG_dataKeyUp(TObject *Sender, WORD &Key,
      TShiftState Shift)
{
   String txt;
   for (int i = 0; i < nData; i++)
   {
      txt = SG_data->Cells[i+1][1];
      x[i] =  atof(txt.c_str());
      txt = SG_data->Cells[i+1][2];
      y[i] =  atof(txt.c_str());
   }
   DrawData();
}

//load-----------------------------------------------------------------------
void __fastcall TForm1::Button2Click(TObject *Sender)
{
   OpenDialog1->InitialDir = ExtractFilePath(Application->ExeName)+"\Data";
   if (OpenDialog1->Execute())
   {
      FileName = OpenDialog1->FileName;
      LoadFromFile(FileName);
   }
}
//save-----------------------------------------------------------------------
void __fastcall TForm1::Button3Click(TObject *Sender)
{
   OpenDialog1->InitialDir = ExtractFilePath(Application->ExeName)+"\Data";
   if (SaveDialog1->Execute())
   {
      FileName = SaveDialog1->FileName;
      SaveToFile(FileName);
      flEdit = false;
   }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button4Click(TObject *Sender)
{
     Form2->Visible = true;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::SG_dataSelectCell(TObject *Sender, int ACol,
      int ARow, bool &CanSelect)
{
   SelectedCol = ACol;
   SelectedRow = ARow;
   ButtonDelColl->Hint = "Удалить точку № ";
   ButtonDelColl->Hint += SelectedCol-1;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::ButtonDelCollClick(TObject *Sender)
{
   int decr = 0;
   float newx[1024], newy[1024];
   for(int i = 0; i < nData; i++)
   {
      if((i+1) == SelectedCol)
      {
         decr++;
      }
      newx[i] = x[i+decr];
      newy[i] = y[i+decr];
   }
   nData--;
   for(int i = 0; i < nData; i++)
   {
      x[i] = newx[i];
      y[i] = newy[i];
   }
   ShowData();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::ButtonInvert_XYClick(TObject *Sender)
{
   float temp[1024];
   for(int i = 0; i < nData; i++)
   {
      temp[i] = x[i];
      x[i] = y[i];
      y[i] = temp[i];
   }
   ShowData();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::SG_koefKeyPress(TObject *Sender, char &Key)
{
   if(Key == 3)
   {
      C->Open();
      C->SetTextBuf(source.c_str());
      C->Close();
   }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::SG_koefSelectCell(TObject *Sender, int ACol,
      int ARow, bool &CanSelect)
{
   source = SG_koef->Cells[ACol][ARow];
}
//---------------------------------------------------------------------------


