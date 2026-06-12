unit penpaintcode;

{
 This sofware was made by Popov Evgeniy Alekseyevich.
 It is distributed under the GNU GENERAL PUBLIC LICENSE (Version 2 or higher).
}

{$mode objfpc}
{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
  LCLProc,Clipbrd,ExtCtrls,ExtDlgs,Menus,ComCtrls,LCLIntf, LazFileUtils;

type

  { TMainWindow }

  TMainWindow = class(TForm)
    CanvasBtn: TBitBtn;
    PenBtn: TBitBtn;
    NewBtn: TBitBtn;
    OpenBtn: TBitBtn;
    EmptyMenu: TPopupMenu;
    SaveBtn: TBitBtn;
    SizeBtn: TBitBtn;
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
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure NewBtnClick(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure SizeBtnClick(Sender: TObject);
    procedure CanvasBtnClick(Sender: TObject);
    procedure PenBtnClick(Sender: TObject);
    procedure SurfaceMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SurfaceMouseEnter(Sender: TObject);
    procedure SurfaceMouseLeave(Sender: TObject);
    procedure SurfaceMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure SurfaceResize(Sender: TObject);
    procedure ScrollBoxMouseEnter(Sender: TObject);
    procedure AboutMenuItemClick(Sender: TObject);
    procedure ShowHelpMenuItemClick(Sender: TObject);
    procedure NewMenuItemClick(Sender: TObject);
    procedure OpenMenuItemClick(Sender: TObject);
    procedure SaveMenuItemClick(Sender: TObject);
    procedure SaveAsMenuItemClick(Sender: TObject);
    procedure CopyMenuItemClick(Sender: TObject);
    procedure PasteMenuItemClick(Sender: TObject);
    procedure OpenPictureDialogCanClose(Sender: TObject; var CanClose: boolean);
    procedure SavePictureDialogCanClose(Sender: TObject; var CanClose: boolean);
    procedure WidthFieldExit(Sender: TObject);
    procedure HeightFieldExit(Sender: TObject);
    procedure SizeFieldExit(Sender: TObject);
  private
    procedure window_setup();
    procedure interface_setup();
    procedure load_contex_help();
    procedure shortcut_setup();
    procedure dialog_setup();
    procedure canvas_setup();
    procedure resize_workspace();
    procedure setup();
    procedure check_command_line();
    procedure create_image();
    procedure set_canvas_size();
    procedure save_to_clipboard();
    procedure load_from_clipboard();
    procedure save_to_file();
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

procedure TMainWindow.window_setup();
begin
 Application.Title:='PenPaint';
 Self.Caption:='PenPaint 1.7.2';
 Self.Font.Name:=Screen.MenuFont.Name;
 Self.Font.Size:=14;
end;

procedure TMainWindow.interface_setup();
begin
 Self.WidthField.PopupMenu:=EmptyMenu;
 Self.HeightField.PopupMenu:=EmptyMenu;
 Self.SizeField.PopupMenu:=EmptyMenu;
 Self.ScrollBox.AutoScroll:=True;
 Self.WidthField.NumbersOnly:=True;
 Self.HeightField.NumbersOnly:=True;
 Self.SizeField.NumbersOnly:=True;
 Self.WidthField.Text:='';
 Self.HeightField.Text:='';
 Self.SizeField.Text:='';
 Self.NewBtn.ShowHint:=True;
 Self.OpenBtn.ShowHint:=True;
 Self.SaveBtn.ShowHint:=True;
 Self.SizeBtn.ShowHint:=True;
 Self.CanvasBtn.ShowHint:=True;
 Self.PenBtn.ShowHint:=True;
 Self.NewBtn.Caption:='';
 Self.OpenBtn.Caption:='';
 Self.SaveBtn.Caption:='';
 Self.SizeBtn.Caption:='';
 Self.CanvasBtn.Caption:='';
 Self.PenBtn.Caption:='';
 Self.NewBtn.NumGlyphs:=1;
 Self.OpenBtn.NumGlyphs:=1;
 Self.SaveBtn.NumGlyphs:=1;
 Self.SizeBtn.NumGlyphs:=1;
 Self.CanvasBtn.NumGlyphs:=1;
 Self.PenBtn.NumGlyphs:=1;
 Self.NewBtn.Glyph.LoadFromFile(get_icon('new'));
 Self.OpenBtn.Glyph.LoadFromFile(get_icon('open'));
 Self.SaveBtn.Glyph.LoadFromFile(get_icon('save'));
 Self.SizeBtn.Glyph.LoadFromFile(get_icon('size'));
 Self.PenBtn.Glyph.LoadFromFile(get_icon('pen'));
 Self.CanvasBtn.Glyph.LoadFromFile(get_icon('canvas'));
end;

procedure TMainWindow.load_contex_help();
begin
 Self.NewBtn.Hint:='Create a new image';
 Self.OpenBtn.Hint:='Load an image from the file';
 Self.SaveBtn.Hint:='Save an image to the file';
 Self.SizeBtn.Hint:='Clear the current image and resize the canvas';
 Self.CanvasBtn.Hint:='Set the canvas color';
 Self.PenBtn.Hint:='Set the pen color';
end;

procedure TMainWindow.shortcut_setup();
begin
 Self.MainMenu.Items[0].Items[0].ShortCut:=TextToShortCut('Ctrl+N');
 Self.MainMenu.Items[0].Items[1].ShortCut:=TextToShortCut('Ctrl+O');
 Self.MainMenu.Items[0].Items[2].ShortCut:=TextToShortCut('Ctrl+S');
 Self.MainMenu.Items[0].Items[3].ShortCut:=TextToShortCut('Ctrl+Alt+S');
 Self.MainMenu.Items[1].Items[0].ShortCut:=TextToShortCut('Shift+C');
 Self.MainMenu.Items[1].Items[1].ShortCut:=TextToShortCut('Shift+V');
 Self.MainMenu.Items[2].Items[1].ShortCut:=TextToShortCut('F1');
end;

procedure TMainWindow.dialog_setup();
begin
 Self.OpenPictureDialog.InitialDir:='';
 Self.SavePictureDialog.InitialDir:=Self.OpenPictureDialog.InitialDir;
 Self.OpenPictureDialog.Filter:='All supported formats|*.bmp;*.jpg;*.png;*.xpm';
 Self.OpenPictureDialog.FileName:='*.bmp;*.jpg;*.png;*.xpm';
 Self.SavePictureDialog.Filter:='Bitmaps|*.bmp|Pixmap|*.xpm|Portable Network Graphic|*.png|Joint Picture Expert Group|*.jpg';
 Self.SavePictureDialog.FilterIndex:=1;
end;

procedure TMainWindow.canvas_setup();
begin
 Self.Surface.Parent.DoubleBuffered:=True;
 Self.Surface.AutoSize:=True;
 Self.Surface.Proportional:=False;
 Self.Surface.Stretch:=False;
 Self.Surface.Canvas.Brush.Style:=bsSolid;
 Self.Surface.Canvas.Pen.Style:=psSolid;
 Self.Surface.Canvas.Brush.Color:=clWhite;
 Self.Surface.Canvas.Pen.Color:=clBlack;
end;

procedure TMainWindow.resize_workspace();
begin
 Self.ScrollBox.Width:=Self.ClientWidth-10;
 Self.ScrollBox.Height:=Self.ClientHeight-Self.OpenBtn.Top-10;
end;

procedure TMainWindow.setup();
begin
 Self.window_setup();
 Self.interface_setup();
 Self.load_contex_help();
 Self.shortcut_setup();
 Self.dialog_setup();
 Self.canvas_setup();
 Self.resize_workspace();
end;

procedure TMainWindow.check_command_line();
begin
 if ParamCount()>0 then
 begin
  Self.SavePictureDialog.FileName:=ParamStr(1);
  Self.Surface.Picture.LoadFromFile(Self.SavePictureDialog.FileName);
  Self.FileBar.SimpleText:=Self.SavePictureDialog.FileName;
 end;

end;

procedure TMainWindow.create_image();
begin
 Self.SizeField.Text:='5';
 Self.Surface.Canvas.FillRect(Self.Surface.Canvas.ClipRect);
 Self.SavePictureDialog.FileName:='';
 Self.FileBar.SimpleText:=Self.SavePictureDialog.FileName;
end;

procedure TMainWindow.set_canvas_size();
begin
 Self.Surface.Picture.Graphic.Width:=StrToInt(Self.WidthField.Text);
 Self.Surface.Picture.Graphic.Height:=StrToInt(Self.HeightField.Text);
 Self.Surface.Width:=Self.Surface.Picture.Graphic.Width;
 Self.Surface.Height:=Self.Surface.Picture.Graphic.Height;
 Self.Surface.Canvas.FillRect(Self.Surface.ClientRect);
 Self.WidthField.Text:=IntToStr(Self.Surface.Width);
 Self.HeightField.Text:=IntToStr(Self.Surface.Height);
end;

procedure TMainWindow.save_to_clipboard();
begin
 Self.Surface.Picture.SaveToClipboardFormat(CF_BITMAP);
end;

procedure TMainWindow.load_from_clipboard();
begin
 Self.Surface.Picture.LoadFromClipboardFormat(CF_BITMAP);
end;

procedure TMainWindow.save_to_file();
begin
 if Self.SavePictureDialog.FileName<>'' then
 begin
  Self.Surface.Picture.SaveToFile(Self.SavePictureDialog.FileName);
 end
 else
 begin
  Self.SavePictureDialog.Execute();
 end;

end;

procedure TMainWindow.FormCreate(Sender: TObject);
begin
 Self.setup();
 Self.create_image();
 Self.check_command_line();
end;

procedure TMainWindow.FormResize(Sender: TObject);
begin
 Self.resize_workspace();
end;

procedure TMainWindow.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
 if Self.SavePictureDialog.FileName<>'' then
 begin
  Self.Surface.Picture.SaveToFile(Self.SavePictureDialog.FileName);
 end
 else
 begin
  if MessageDlg(Application.Title,'An image is not saved. Do you want to save it now?',mtCustom,mbYesNo,0)=mrYes then
  begin
   Self.SavePictureDialog.Execute();
  end;

end;

end;

procedure TMainWindow.NewBtnClick(Sender: TObject);
begin
 Self.create_image();
end;

procedure TMainWindow.OpenBtnClick(Sender: TObject);
begin
 Self.OpenPictureDialog.Execute();
end;

procedure TMainWindow.SaveBtnClick(Sender: TObject);
begin
 Self.save_to_file();
end;

procedure TMainWindow.SizeBtnClick(Sender: TObject);
begin
 Self.set_canvas_size();
 Self.resize_workspace();
end;

procedure TMainWindow.CanvasBtnClick(Sender: TObject);
begin
 if Self.ColorDialog.Execute()=True then
 begin
  Self.Surface.Canvas.Brush.Color:=Self.ColorDialog.Color;
  Self.Surface.Canvas.FillRect(Self.Surface.Canvas.ClipRect);
 end;

end;

procedure TMainWindow.PenBtnClick(Sender: TObject);
begin
 if Self.ColorDialog.Execute()=True then
 begin
  Self.Surface.Canvas.Pen.Color:=Self.ColorDialog.Color;
 end;

end;

procedure TMainWindow.SurfaceMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if Button=mbRight then
 begin
  if ssShift in Shift then
  begin
   Self.Surface.Canvas.Pen.Color:=Self.Surface.Canvas.Pixels[X,Y];
  end
  else
  begin
   Self.Surface.Canvas.Brush.Color:=Self.Surface.Canvas.Pen.Color;
   Self.Surface.Canvas.FloodFill(X,Y,Self.Surface.Canvas.Pixels[X,Y],fsSurface);
  end;

 end;

end;

procedure TMainWindow.SurfaceMouseEnter(Sender: TObject);
begin
 Self.ScrollBox.SetFocus();
 Screen.Cursor:=crCross;
 Self.Surface.Canvas.Pen.Width:=StrToInt(Self.SizeField.Text);
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
  Self.Surface.Canvas.MoveTo(X,Y);
  Self.Surface.Canvas.LineTo(X,Y);
 end;

end;

procedure TMainWindow.SurfaceResize(Sender: TObject);
begin
 Self.WidthField.Text:=IntToStr(Self.Surface.Width);
 Self.HeightField.Text:=IntToStr(Self.Surface.Height);
end;

procedure TMainWindow.ScrollBoxMouseEnter(Sender: TObject);
begin
 Self.ScrollBox.SetFocus();
end;

procedure TMainWindow.AboutMenuItemClick(Sender: TObject);
begin
 ShowMessage('PenPaint is a simple drawing program by Popov Evgeniy Alekseyevich');
end;

procedure TMainWindow.ShowHelpMenuItemClick(Sender: TObject);
begin
 OpenDocument(ExtractFilePath(Application.ExeName)+'help.htm');
end;

procedure TMainWindow.NewMenuItemClick(Sender: TObject);
begin
 Self.create_image();
end;

procedure TMainWindow.OpenMenuItemClick(Sender: TObject);
begin
 Self.OpenPictureDialog.Execute();
end;

procedure TMainWindow.SaveMenuItemClick(Sender: TObject);
begin
 Self.save_to_file();
end;

procedure TMainWindow.SaveAsMenuItemClick(Sender: TObject);
begin
 Self.SavePictureDialog.Execute();
end;

procedure TMainWindow.CopyMenuItemClick(Sender: TObject);
begin
 Self.save_to_clipboard();
end;

procedure TMainWindow.PasteMenuItemClick(Sender: TObject);
begin
 Self.load_from_clipboard();
end;

procedure TMainWindow.OpenPictureDialogCanClose(Sender: TObject;
  var CanClose: boolean);
begin
 Self.SavePictureDialog.FileName:=Self.OpenPictureDialog.FileName;
 Self.Surface.Picture.LoadFromFile(Self.SavePictureDialog.FileName);
 Self.FileBar.SimpleText:=Self.SavePictureDialog.FileName;
end;

procedure TMainWindow.SavePictureDialogCanClose(Sender: TObject;
  var CanClose: boolean);
begin
 if SavePictureDialog.FileName<>'' then
 begin
  Self.SavePictureDialog.FileName:=ExtractFileNameWithoutExt(Self.SavePictureDialog.FileName)+'.'+Self.SavePictureDialog.GetFilterExt();
  Self.Surface.Picture.SaveToFile(Self.SavePictureDialog.FileName);
  Self.FileBar.SimpleText:=Self.SavePictureDialog.FileName;
 end;

end;

procedure TMainWindow.WidthFieldExit(Sender: TObject);
begin
 if StrToIntDef(Self.WidthField.Text,0)<=0 then Self.WidthField.Text:=IntToStr(Self.Surface.Width);
end;

procedure TMainWindow.HeightFieldExit(Sender: TObject);
begin
 if StrToIntDef(Self.HeightField.Text,0)<=0 then Self.HeightField.Text:=IntToStr(Self.Surface.Height);
end;

procedure TMainWindow.SizeFieldExit(Sender: TObject);
begin
 if StrToIntDef(Self.SizeField.Text,0)<=0 then Self.SizeField.Text:=IntToStr(Self.Surface.Canvas.Pen.Width);
end;

end.
