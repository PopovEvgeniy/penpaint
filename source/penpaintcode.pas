unit penpaintcode; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
  LCLProc,Clipbrd,ExtCtrls,ExtDlgs,Menus,ComCtrls,LCLIntf, LazFileUtils;

type

  { TMainWindow }

  TMainWindow = class(TForm)
    NewBtn: TBitBtn;
    OpenBtn: TBitBtn;
    SaveBtn: TBitBtn;
    SizeBtn: TBitBtn;
    CanvasBtn: TBitBtn;
    PenBtn: TBitBtn;
    ColorDialog: TColorDialog;
    Surface: TImage;
    WidthField: TLabeledEdit;
    HeightField: TLabeledEdit;
    SizeField: TLabeledEdit;
    MainMenu: TMainMenu;
    FileMenu: TMenuItem;
    AboutMenuItem: TMenuItem;
    ShowHelpMenuItem: TMenuItem;
    NewMenuItem: TMenuItem;
    OpenMenuItem: TMenuItem;
    SaveMenuItem: TMenuItem;
    SaveAsMenuItem: TMenuItem;
    ClipboardMenu: TMenuItem;
    CopyMenuItem: TMenuItem;
    PasteMenuItem: TMenuItem;
    HelpMenu: TMenuItem;
    OpenPictureDialog: TOpenPictureDialog;
    SavePictureDialog: TSavePictureDialog;
    ScrollBox: TScrollBox;
    FileBar: TStatusBar;
    procedure NewBtnClick(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure SizeBtnClick(Sender: TObject);
    procedure CanvasBtnClick(Sender: TObject);
    procedure PenBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure SurfaceMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SurfaceMouseEnter(Sender: TObject);
    procedure SurfaceMouseLeave(Sender: TObject);
    procedure SurfaceMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure SurfaceResize(Sender: TObject);
    procedure AboutMenuItemClick(Sender: TObject);
    procedure ShowHelpMenuItemClick(Sender: TObject);
    procedure NewMenuItemClick(Sender: TObject);
    procedure OpenMenuItemClick(Sender: TObject);
    procedure SaveMenuItemClick(Sender: TObject);
    procedure SaveAsMenuItemClick(Sender: TObject);
    procedure CopyMenuItemClick(Sender: TObject);
    procedure PasteMenuItemClick(Sender: TObject);
    procedure OpenPictureDialogCanClose(Sender: TObject; var CanClose: boolean
      );
    procedure SavePictureDialogCanClose(Sender: TObject; var CanClose: boolean
      );
  private
    { private declarations }
  public
    { public declarations }
  end; 

var MainWindow: TMainWindow;

implementation

{$R *.lfm}

{ TMainWindow }

function get_icon(const icon:string): string;
begin
 Result:=ExtractFilePath(Application.ExeName)+'icons'+DirectorySeparator+icon+'.bmp';
end;

procedure window_setup();
begin
 Application.Title:='PenPaint';
 MainWindow.Caption:='PenPaint 1.5.8';
 MainWindow.Font.Name:=Screen.MenuFont.Name;
 MainWindow.Font.Size:=14;
end;

procedure interface_setup();
begin
 MainWindow.ScrollBox.AutoScroll:=True;
 MainWindow.WidthField.NumbersOnly:=True;
 MainWindow.HeightField.NumbersOnly:=True;
 MainWindow.SizeField.NumbersOnly:=True;
 MainWindow.WidthField.Text:='';
 MainWindow.HeightField.Text:=MainWindow.WidthField.Text;
 MainWindow.SizeField.Text:=MainWindow.WidthField.Text;
 MainWindow.NewBtn.ShowHint:=True;
 MainWindow.OpenBtn.ShowHint:=MainWindow.NewBtn.ShowHint;
 MainWindow.SaveBtn.ShowHint:=MainWindow.NewBtn.ShowHint;
 MainWindow.SizeBtn.ShowHint:=MainWindow.NewBtn.ShowHint;
 MainWindow.CanvasBtn.ShowHint:=MainWindow.NewBtn.ShowHint;
 MainWindow.PenBtn.ShowHint:=MainWindow.NewBtn.ShowHint;
 MainWindow.NewBtn.Caption:='';
 MainWindow.OpenBtn.Caption:=MainWindow.NewBtn.Caption;
 MainWindow.SaveBtn.Caption:=MainWindow.NewBtn.Caption;
 MainWindow.SizeBtn.Caption:=MainWindow.NewBtn.Caption;
 MainWindow.CanvasBtn.Caption:=MainWindow.NewBtn.Caption;
 MainWindow.PenBtn.Caption:=MainWindow.NewBtn.Caption;
 MainWindow.NewBtn.NumGlyphs:=1;
 MainWindow.OpenBtn.NumGlyphs:=MainWindow.NewBtn.NumGlyphs;
 MainWindow.SaveBtn.NumGlyphs:=MainWindow.NewBtn.NumGlyphs;
 MainWindow.SizeBtn.NumGlyphs:=MainWindow.NewBtn.NumGlyphs;
 MainWindow.CanvasBtn.NumGlyphs:=MainWindow.NewBtn.NumGlyphs;
 MainWindow.PenBtn.NumGlyphs:=MainWindow.NewBtn.NumGlyphs;
 MainWindow.NewBtn.Glyph.LoadFromFile(get_icon('new'));
 MainWindow.OpenBtn.Glyph.LoadFromFile(get_icon('open'));
 MainWindow.SaveBtn.Glyph.LoadFromFile(get_icon('save'));
 MainWindow.SizeBtn.Glyph.LoadFromFile(get_icon('size'));
 MainWindow.CanvasBtn.Glyph.LoadFromFile(get_icon('canvas'));
 MainWindow.PenBtn.Glyph.LoadFromFile(get_icon('pen'));
end;

procedure load_contex_help();
begin
 MainWindow.NewBtn.Hint:='Create a new image';
 MainWindow.OpenBtn.Hint:='Load an image from the file';
 MainWindow.SaveBtn.Hint:='Save an image to the file';
 MainWindow.SizeBtn.Hint:='Clear the current image and resize the canvas';
 MainWindow.CanvasBtn.Hint:='Set the pen color';
 MainWindow.PenBtn.Hint:='Set the background color';
end;

procedure shortcut_setup();
begin
 MainWindow.MainMenu.Items[0].Items[0].ShortCut:=TextToShortCut('Ctrl+N');
 MainWindow.MainMenu.Items[0].Items[1].ShortCut:=TextToShortCut('Ctrl+O');
 MainWindow.MainMenu.Items[0].Items[2].ShortCut:=TextToShortCut('Ctrl+S');
 MainWindow.MainMenu.Items[0].Items[3].ShortCut:=TextToShortCut('Ctrl+Alt+S');
 MainWindow.MainMenu.Items[1].Items[0].ShortCut:=TextToShortCut('Ctrl+C');
 MainWindow.MainMenu.Items[1].Items[1].ShortCut:=TextToShortCut('Ctrl+V');
 MainWindow.MainMenu.Items[2].Items[1].ShortCut:=TextToShortCut('F1');
end;

procedure dialog_setup();
begin
 MainWindow.OpenPictureDialog.InitialDir:='';
 MainWindow.SavePictureDialog.InitialDir:=MainWindow.OpenPictureDialog.InitialDir;
 MainWindow.OpenPictureDialog.Filter:='All supported formats|*.bmp;*.jpg;*.png;*.xpm';
 MainWindow.OpenPictureDialog.FileName:='*.bmp;*.jpg;*.png;*.xpm';
 MainWindow.SavePictureDialog.Filter:='Bitmaps|*.bmp|Pixmap|*.xpm|Portable Network Graphic|*.png|Joint Picture Expert Group|*.jpg';
 MainWindow.SavePictureDialog.FilterIndex:=1;
end;

procedure canvas_setup();
begin
 MainWindow.Surface.Parent.DoubleBuffered:=True;
 MainWindow.Surface.AutoSize:=True;
 MainWindow.Surface.Proportional:=False;
 MainWindow.Surface.Stretch:=False;
 MainWindow.Surface.Canvas.Brush.Style:=bsSolid;
 MainWindow.Surface.Canvas.Pen.Style:=psSolid;
 MainWindow.Surface.Canvas.Brush.Color:=clWhite;
 MainWindow.Surface.Canvas.Pen.Color:=clBlack;
end;

procedure resize_workspace();
begin
MainWindow.ScrollBox.Width:=MainWindow.ClientWidth-10;
MainWindow.ScrollBox.Height:=MainWindow.ClientHeight-MainWindow.OpenBtn.Top-80;
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
  MainWindow.SavePictureDialog.FileName:=ParamStr(1);
  MainWindow.Surface.Picture.LoadFromFile(MainWindow.SavePictureDialog.FileName);
  MainWindow.FileBar.SimpleText:=MainWindow.SavePictureDialog.FileName;
 end;

end;

procedure create_image();
begin
 MainWindow.SizeField.Text:='5';
 MainWindow.Surface.Canvas.FillRect(MainWindow.Surface.Canvas.ClipRect);
 MainWindow.SavePictureDialog.FileName:='';
 MainWindow.FileBar.SimpleText:=MainWindow.SavePictureDialog.FileName;
end;

procedure set_canvas_size();
begin
 MainWindow.Surface.Width:=StrToInt(MainWindow.WidthField.Text);
 MainWindow.Surface.Height:=StrToInt(MainWindow.HeightField.Text);
 MainWindow.Surface.Picture.Graphic.Width:=StrToInt(MainWindow.WidthField.Text);
 MainWindow.Surface.Picture.Graphic.Height:=StrToInt(MainWindow.HeightField.Text);
 MainWindow.Surface.Canvas.FillRect(MainWindow.Surface.ClientRect);
end;

procedure save_to_clipboard();
begin
 MainWindow.Surface.Picture.SaveToClipboardFormat(CF_BITMAP);
end;

procedure load_from_clipboard();
begin
 MainWindow.Surface.Picture.LoadFromClipboardFormat(CF_BITMAP);
end;

procedure save_to_file();
begin
 if MainWindow.SavePictureDialog.FileName<>'' then
 begin
  MainWindow.Surface.Picture.SaveToFile(MainWindow.SavePictureDialog.FileName);
 end
 else
 begin
  MainWindow.SavePictureDialog.Execute();
 end;

end;

procedure show_help();
var help:string;
begin
 help:=ExtractFilePath(Application.ExeName)+'help.htm';
 OpenDocument(help);
end;

procedure TMainWindow.FormCreate(Sender: TObject);
begin
 setup();
 create_image();
 check_command_line();
end;

procedure TMainWindow.NewBtnClick(Sender: TObject);
begin
 create_image();
end;

procedure TMainWindow.OpenBtnClick(Sender: TObject);
begin
 MainWindow.OpenPictureDialog.Execute();
end;

procedure TMainWindow.SaveBtnClick(Sender: TObject);
begin
 save_to_file();
end;

procedure TMainWindow.SizeBtnClick(Sender: TObject);
begin
 set_canvas_size();
 resize_workspace();
end;

procedure TMainWindow.CanvasBtnClick(Sender: TObject);
begin
 if MainWindow.ColorDialog.Execute()=True then
 begin
  MainWindow.Surface.Canvas.Pen.Color:=MainWindow.ColorDialog.Color;
 end;

end;

procedure TMainWindow.PenBtnClick(Sender: TObject);
begin
 if MainWindow.ColorDialog.Execute()=True then
 begin
  MainWindow.Surface.Canvas.Brush.Color:=MainWindow.ColorDialog.Color;
  MainWindow.Surface.Canvas.FillRect(MainWindow.Surface.Canvas.ClipRect);
 end;

end;

procedure TMainWindow.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
 if MainWindow.SavePictureDialog.FileName<>'' then
 begin
  MainWindow.Surface.Picture.SaveToFile(MainWindow.SavePictureDialog.FileName);
 end
 else
 begin
  if MessageDlg(Application.Title,'An image is not saved. Do you want to save it now?',mtCustom,mbYesNo,0)=mrYes then
  begin
   MainWindow.SavePictureDialog.Execute();
  end;

end;

end;

procedure TMainWindow.FormResize(Sender: TObject);
begin
 resize_workspace();
end;

procedure TMainWindow.SurfaceMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if Button=mbRight then
 begin
  if ssShift in Shift then
  begin
   MainWindow.Surface.Canvas.Pen.Color:=MainWindow.Surface.Canvas.Pixels[X,Y];
  end
  else
  begin
   MainWindow.Surface.Canvas.Brush.Color:=MainWindow.Surface.Canvas.Pen.Color;
   MainWindow.Surface.Canvas.FloodFill(X,Y,MainWindow.Surface.Canvas.Pixels[X,Y],fsSurface);
  end;

 end;

end;

procedure TMainWindow.SurfaceMouseEnter(Sender: TObject);
begin
 Screen.Cursor:=crCross;
 MainWindow.Surface.Canvas.Pen.Width:=StrToInt(MainWindow.SizeField.Text);
end;

procedure TMainWindow.SurfaceMouseLeave(Sender: TObject);
begin
 Screen.Cursor:=crDefault;
end;

procedure TMainWindow.SurfaceMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 if ssLeft in Shift then
 begin
  MainWindow.Surface.Canvas.MoveTo(X,Y);
  MainWindow.Surface.Canvas.LineTo(X,Y);
 end;

end;

procedure TMainWindow.SurfaceResize(Sender: TObject);
begin
 MainWindow.WidthField.Text:=IntToStr(MainWindow.Surface.Width);
 MainWindow.HeightField.Text:=IntToStr(MainWindow.Surface.Height);
end;

procedure TMainWindow.AboutMenuItemClick(Sender: TObject);
begin
 ShowMessage('PenPaint is a simple drawing program by Popov Evgeniy Alekseyevich');
end;

procedure TMainWindow.ShowHelpMenuItemClick(Sender: TObject);
begin
 show_help();
end;

procedure TMainWindow.NewMenuItemClick(Sender: TObject);
begin
 create_image();
end;

procedure TMainWindow.OpenMenuItemClick(Sender: TObject);
begin
 MainWindow.OpenPictureDialog.Execute();
end;

procedure TMainWindow.SaveMenuItemClick(Sender: TObject);
begin
 save_to_file();
end;

procedure TMainWindow.SaveAsMenuItemClick(Sender: TObject);
begin
 MainWindow.SavePictureDialog.Execute();
end;

procedure TMainWindow.CopyMenuItemClick(Sender: TObject);
begin
 save_to_clipboard();
end;

procedure TMainWindow.PasteMenuItemClick(Sender: TObject);
begin
 load_from_clipboard();
end;

procedure TMainWindow.OpenPictureDialogCanClose(Sender: TObject;
  var CanClose: boolean);
begin
 MainWindow.SavePictureDialog.FileName:=MainWindow.OpenPictureDialog.FileName;
 MainWindow.Surface.Picture.LoadFromFile(MainWindow.SavePictureDialog.FileName);
 MainWindow.FileBar.SimpleText:=MainWindow.SavePictureDialog.FileName;
end;

procedure TMainWindow.SavePictureDialogCanClose(Sender: TObject;
  var CanClose: boolean);
begin
 if SavePictureDialog.FileName<>'' then
 begin
  MainWindow.SavePictureDialog.FileName:=ExtractFileNameWithoutExt(MainWindow.SavePictureDialog.FileName)+'.'+MainWindow.SavePictureDialog.GetFilterExt();
  MainWindow.Surface.Picture.SaveToFile(MainWindow.SavePictureDialog.FileName);
  MainWindow.FileBar.SimpleText:=MainWindow.SavePictureDialog.FileName;
 end;

end;

end.
