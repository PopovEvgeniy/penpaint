unit penpaintcode; 

{$mode objfpc}{$H+}
{$R icon.res}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
  LCLProc,Clipbrd,ExtCtrls,ExtDlgs,Menus,ComCtrls,LCLIntf, LazFileUtils;

type

  { TForm1 }

  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    ColorDialog1: TColorDialog;
    Image1: TImage;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenPictureDialog1: TOpenPictureDialog;
    SavePictureDialog1: TSavePictureDialog;
    ScrollBox1: TScrollBox;
    StatusBar1: TStatusBar;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseEnter(Sender: TObject);
    procedure Image1MouseLeave(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Image1Resize(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure OpenPictureDialog1CanClose(Sender: TObject; var CanClose: boolean
      );
    procedure SavePictureDialog1CanClose(Sender: TObject; var CanClose: boolean
      );
  private
    { private declarations }
  public
    { public declarations }
  end; 

var Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure window_setup();
begin
 Application.Title:='PenPaint';
 Form1.Caption:='PenPaint 1.5.5';
 Form1.Font.Name:=Screen.MenuFont.Name;
 Form1.Font.Size:=14;
end;

procedure interface_setup();
begin
 Form1.ScrollBox1.AutoScroll:=True;
 Form1.LabeledEdit1.NumbersOnly:=True;
 Form1.LabeledEdit2.NumbersOnly:=True;
 Form1.LabeledEdit3.NumbersOnly:=True;
 Form1.LabeledEdit1.Text:='';
 Form1.LabeledEdit2.Text:=Form1.LabeledEdit1.Text;
 Form1.LabeledEdit3.Text:=Form1.LabeledEdit1.Text;
 Form1.BitBtn1.ShowHint:=True;
 Form1.BitBtn2.ShowHint:=Form1.BitBtn1.ShowHint;
 Form1.BitBtn3.ShowHint:=Form1.BitBtn1.ShowHint;
 Form1.BitBtn4.ShowHint:=Form1.BitBtn1.ShowHint;
 Form1.BitBtn5.ShowHint:=Form1.BitBtn1.ShowHint;
 Form1.BitBtn6.ShowHint:=Form1.BitBtn1.ShowHint;
 Form1.BitBtn1.Caption:='';
 Form1.BitBtn2.Caption:=Form1.BitBtn1.Caption;
 Form1.BitBtn3.Caption:=Form1.BitBtn1.Caption;
 Form1.BitBtn4.Caption:=Form1.BitBtn1.Caption;
 Form1.BitBtn5.Caption:=Form1.BitBtn1.Caption;
 Form1.BitBtn6.Caption:=Form1.BitBtn1.Caption;
 Form1.BitBtn1.NumGlyphs:=1;
 Form1.BitBtn2.NumGlyphs:=Form1.BitBtn1.NumGlyphs;
 Form1.BitBtn3.NumGlyphs:=Form1.BitBtn1.NumGlyphs;
 Form1.BitBtn4.NumGlyphs:=Form1.BitBtn1.NumGlyphs;
 Form1.BitBtn5.NumGlyphs:=Form1.BitBtn1.NumGlyphs;
 Form1.BitBtn6.NumGlyphs:=Form1.BitBtn1.NumGlyphs;
 Form1.BitBtn1.Glyph.LoadFromResourceName(HINSTANCE,'NEW');
 Form1.BitBtn2.Glyph.LoadFromResourceName(HINSTANCE,'OPEN');
 Form1.BitBtn3.Glyph.LoadFromResourceName(HINSTANCE,'SAVE');
 Form1.BitBtn4.Glyph.LoadFromResourceName(HINSTANCE,'SIZE');
 Form1.BitBtn5.Glyph.LoadFromResourceName(HINSTANCE,'CANVAS');
 Form1.BitBtn6.Glyph.LoadFromResourceName(HINSTANCE,'PEN');
end;

procedure load_contex_help();
begin
 Form1.BitBtn1.Hint:='Create a new image';
 Form1.BitBtn2.Hint:='Load an image from the file';
 Form1.BitBtn3.Hint:='Save an image to the file';
 Form1.BitBtn4.Hint:='Clear the current image and resize the canvas';
 Form1.BitBtn5.Hint:='Set the pen color';
 Form1.BitBtn6.Hint:='Set the background color';
end;

procedure shortcut_setup();
begin
 Form1.MainMenu1.Items[0].Items[0].ShortCut:=TextToShortCut('Ctrl+N');
 Form1.MainMenu1.Items[0].Items[1].ShortCut:=TextToShortCut('Ctrl+O');
 Form1.MainMenu1.Items[0].Items[2].ShortCut:=TextToShortCut('Ctrl+S');
 Form1.MainMenu1.Items[0].Items[3].ShortCut:=TextToShortCut('Ctrl+Alt+S');
 Form1.MainMenu1.Items[1].Items[0].ShortCut:=TextToShortCut('Ctrl+C');
 Form1.MainMenu1.Items[1].Items[1].ShortCut:=TextToShortCut('Ctrl+V');
 Form1.MainMenu1.Items[2].Items[1].ShortCut:=TextToShortCut('F1');
end;

procedure dialog_setup();
begin
 Form1.OpenPictureDialog1.InitialDir:='';
 Form1.SavePictureDialog1.InitialDir:=Form1.OpenPictureDialog1.InitialDir;
 Form1.OpenPictureDialog1.Filter:='All supported formats|*.bmp;*.jpg;*.png;*.xpm';
 Form1.OpenPictureDialog1.FileName:='*.bmp;*.jpg;*.png;*.xpm';
 Form1.SavePictureDialog1.Filter:='Bitmaps|*.bmp|Pixmap|*.xpm|Portable Network Graphic|*.png|Joint Picture Expert Group|*.jpg';
 Form1.SavePictureDialog1.FilterIndex:=1;
end;

procedure canvas_setup();
begin
 Form1.Image1.Parent.DoubleBuffered:=True;
 Form1.Image1.AutoSize:=True;
 Form1.Image1.Proportional:=False;
 Form1.Image1.Stretch:=False;
 Form1.Image1.Canvas.Brush.Style:=bsSolid;
 Form1.Image1.Canvas.Pen.Style:=psSolid;
 Form1.Image1.Canvas.Brush.Color:=clWhite;
 Form1.Image1.Canvas.Pen.Color:=clBlack;
end;

procedure resize_workspace();
begin
Form1.ScrollBox1.Width:=Form1.ClientWidth-10;
Form1.ScrollBox1.Height:=Form1.ClientHeight-Form1.BitBtn2.Top-80;
end;

procedure setup();
begin
 window_setup();
 interface_setup();
 load_contex_help();
 shortcut_setup();
 dialog_setup();
 canvas_setup();
 resize_workspace();
end;

procedure check_command_line();
begin
 if ParamCount()>0 then
 begin
  Form1.SavePictureDialog1.FileName:=ParamStr(1);
  Form1.Image1.Picture.LoadFromFile(Form1.SavePictureDialog1.FileName);
  Form1.StatusBar1.SimpleText:=Form1.SavePictureDialog1.FileName;
 end;

end;

procedure create_image();
begin
 Form1.LabeledEdit3.Text:='5';
 Form1.Image1.Canvas.FillRect(Form1.Image1.Canvas.ClipRect);
 Form1.SavePictureDialog1.FileName:='';
 Form1.StatusBar1.SimpleText:=Form1.SavePictureDialog1.FileName;
end;

procedure set_canvas_size();
begin
 Form1.Image1.Width:=StrToInt(Form1.LabeledEdit1.Text);
 Form1.Image1.Height:=StrToInt(Form1.LabeledEdit2.Text);
 Form1.Image1.Picture.Graphic.Width:=StrToInt(Form1.LabeledEdit1.Text);
 Form1.Image1.Picture.Graphic.Height:=StrToInt(Form1.LabeledEdit2.Text);
 Form1.Image1.Canvas.FillRect(Form1.Image1.ClientRect);
end;

procedure save_to_clipboard();
begin
 Form1.Image1.Picture.SaveToClipboardFormat(CF_BITMAP);
end;

procedure load_from_clipboard();
begin
 Form1.Image1.Picture.LoadFromClipboardFormat(CF_BITMAP);
end;

procedure save_to_file();
begin
 if Form1.SavePictureDialog1.FileName<>'' then
 begin
  Form1.Image1.Picture.SaveToFile(Form1.SavePictureDialog1.FileName);
 end
 else
 begin
  Form1.SavePictureDialog1.Execute();
 end;

end;

procedure show_help();
var help:string;
begin
 help:=ExtractFilePath(Application.ExeName)+'help'+DirectorySeparator+'help.html';
 OpenDocument(help);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 setup();
 create_image();
 check_command_line();
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
 create_image();
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
 Form1.OpenPictureDialog1.Execute();
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
 save_to_file();
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
 set_canvas_size();
 resize_workspace();
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
 if Form1.ColorDialog1.Execute()=True then
 begin
  Form1.Image1.Canvas.Pen.Color:=Form1.ColorDialog1.Color;
 end;

end;

procedure TForm1.BitBtn6Click(Sender: TObject);
begin
 if Form1.ColorDialog1.Execute()=True then
 begin
  Form1.Image1.Canvas.Brush.Color:=Form1.ColorDialog1.Color;
  Form1.Image1.Canvas.FillRect(Form1.Image1.Canvas.ClipRect);
 end;

end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
 if Form1.SavePictureDialog1.FileName<>'' then
 begin
  Form1.Image1.Picture.SaveToFile(Form1.SavePictureDialog1.FileName);
 end
 else
 begin
  if MessageDlg(Application.Title,'An image is not saved. Do you want to save it now?',mtCustom,mbYesNo,0)=mrYes then
  begin
   Form1.SavePictureDialog1.Execute();
  end;

end;

end;

procedure TForm1.FormResize(Sender: TObject);
begin
 resize_workspace();
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if Button=mbRight then
 begin
  if ssShift in Shift then
  begin
   Form1.Image1.Canvas.Pen.Color:=Form1.Image1.Canvas.Pixels[X,Y];
  end
  else
  begin
   Form1.Image1.Canvas.Brush.Color:=Form1.Image1.Canvas.Pen.Color;
   Form1.Image1.Canvas.FloodFill(X,Y,Form1.Image1.Canvas.Pixels[X,Y],fsSurface);
  end;

 end;

end;

procedure TForm1.Image1MouseEnter(Sender: TObject);
begin
 Screen.Cursor:=crCross;
 Form1.Image1.Canvas.Pen.Width:=StrToInt(Form1.LabeledEdit3.Text);
end;

procedure TForm1.Image1MouseLeave(Sender: TObject);
begin
 Screen.Cursor:=crDefault;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 if ssLeft in Shift then
 begin
  Form1.Image1.Canvas.MoveTo(X,Y);
  Form1.Image1.Canvas.LineTo(X,Y);
 end;

end;

procedure TForm1.Image1Resize(Sender: TObject);
begin
 Form1.LabeledEdit1.Text:=IntToStr(Form1.Image1.Width);
 Form1.LabeledEdit2.Text:=IntToStr(Form1.Image1.Height);
end;

procedure TForm1.MenuItem10Click(Sender: TObject);
begin
 ShowMessage('PenPaint is a simple drawing program by Popov Evgeniy Alekseyevich');
end;

procedure TForm1.MenuItem11Click(Sender: TObject);
begin
 show_help();
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
 create_image();
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
 Form1.OpenPictureDialog1.Execute();
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
 save_to_file();
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
 Form1.SavePictureDialog1.Execute();
end;

procedure TForm1.MenuItem7Click(Sender: TObject);
begin
 save_to_clipboard();
end;

procedure TForm1.MenuItem8Click(Sender: TObject);
begin
 load_from_clipboard();
end;

procedure TForm1.OpenPictureDialog1CanClose(Sender: TObject;
  var CanClose: boolean);
begin
 Form1.SavePictureDialog1.FileName:=Form1.OpenPictureDialog1.FileName;
 Form1.Image1.Picture.LoadFromFile(Form1.SavePictureDialog1.FileName);
 Form1.StatusBar1.SimpleText:=Form1.SavePictureDialog1.FileName;
end;

procedure TForm1.SavePictureDialog1CanClose(Sender: TObject;
  var CanClose: boolean);
begin
 if SavePictureDialog1.FileName<>'' then
 begin
  Form1.SavePictureDialog1.FileName:=ExtractFileNameWithoutExt(Form1.SavePictureDialog1.FileName)+'.'+Form1.SavePictureDialog1.GetFilterExt();
  Form1.Image1.Picture.SaveToFile(Form1.SavePictureDialog1.FileName);
  Form1.StatusBar1.SimpleText:=Form1.SavePictureDialog1.FileName;
 end;

end;

end.
