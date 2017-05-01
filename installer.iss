[Setup]
AppName=PenPaint
AppVersion=1.2.3.1
AppPublisher=Tuzik
AppPublisherURL=http://tuzik87.ru54.com/
AppSupportURL=http://tuzik87.ru54.com/
AppUpdatesURL=http://tuzik87.ru54.com/
DefaultDirName={pf}\PenPaint
DefaultGroupName=PenPaint
DisableProgramGroupPage=true
OutputDir=C:\PenPaint
OutputBaseFilename=penpaint_setup
Compression=lzma/ultra64
SolidCompression=true
InternalCompressLevel=ultra64
UsePreviousGroup=false
UsePreviousSetupType=false
UsePreviousTasks=false
ShowLanguageDialog=no
MinVersion=4.1.1998,5.0.2195
RestartIfNeededByRun=false
PrivilegesRequired=none
AllowCancelDuringInstall=false
DisableReadyPage=true
Uninstallable=IsTaskSelected('typical')
UsePreviousUserInfo=false

[Files]
Source: C:\PenPaint\Version 1.2.3.1\deploy\penpaint.exe; DestDir: {app}; Flags: ignoreversion
Source: C:\PenPaint\Version 1.2.3.1\deploy\source.zip; DestDir: {app}; Flags: ignoreversion; Components: source
Source: C:\PenPaint\Version 1.2.3.1\deploy\documentation\canvas.jpg; DestDir: {app}\documentation; Flags: ignoreversion
Source: C:\PenPaint\Version 1.2.3.1\deploy\documentation\gpl.htm; DestDir: {app}\documentation; Flags: ignoreversion
Source: C:\PenPaint\Version 1.2.3.1\deploy\documentation\manual.htm; DestDir: {app}\documentation; Flags: ignoreversion
Source: C:\PenPaint\Version 1.2.3.1\deploy\documentation\pen.jpg; DestDir: {app}\documentation; Flags: ignoreversion
Source: C:\PenPaint\Version 1.2.3.1\deploy\documentation\size.jpg; DestDir: {app}\documentation; Flags: ignoreversion

[Icons]
Name: {group}\Documentation\User guide; Filename: {app}\documentation\manual.htm; Tasks: typical
Name: {group}\Documentation\License; Filename: {app}\documentation\gpl.htm; Tasks: typical
Name: {group}\PenPaint; Filename: {app}\penpaint.exe; Tasks: typical
Name: {group}\Source code; Filename: {app}\source.zip; Components: source; Tasks: typical
Name: {group}\Uninstall PenPaint; Filename: {app}\unins000.exe; Tasks: typical

[Types]
Name: Normal; Description: Normal install; Flags: iscustom

[Components]
Name: Main; Description: Program files; Flags: fixed; Types: Normal
Name: Source; Description: Source code

[Tasks]
Name: typical; Description: Typical install; Flags: exclusive
Name: portable; Description: Install to portable media; Flags: exclusive unchecked
