; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "OpenZFS On Windows"
#define MyAppVersion "0.22"
#define MyAppPublisher "OpenZFS"
#define MyAppURL "http://www.openzfsonwindows.org/"

#include "environment.iss"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{61A38ED1-4D3F-4869-A8D5-87A58A301D56}
AppName={#MyAppName}-debug
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf64}\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
LicenseFile={#SourcePath}\OPENSOLARIS.LICENSE.txt
InfoBeforeFile={#SourcePath}\readme.txt
OutputBaseFilename=OpenZFSOnWindows-debug
SetupIconFile={#SourcePath}\ZFSinlogo.ico
Compression=lzma
SolidCompression=yes
PrivilegesRequired=admin
OutputDir={#SourcePath}\..
ChangesEnvironment=true
WizardSmallImageFile="{#SourcePath}\Small.bmp"
WizardImageFile="{#SourcePath}\Large.bmp"
; Tools/Configure Sign Tools -> Add -> 
; "signtoola" = "C:\Program Files (x86)\Windows Kits\10\bin\10.0.17763.0\x64\signtool.exe sign /sha1 ab8e4f6b94cecfa4638847122b511e507e147c50 /n $qJoergen Lundman$q /t http://timestamp.digicert.com /fd sha1 /d $qOpenZFS on Windows$q $f"
; "signtoolb" = "C:\Program Files (x86)\Windows Kits\10\bin\10.0.17763.0\x64\signtool.exe sign /sha1 ab8e4f6b94cecfa4638847122b511e507e147c50 /as /n $qJoergen Lundman$q /tr http://timestamp.digicert.com /td sha256 /fd sha256 /d $qOpenZFS on Windows$q $f"
SignTool=signtoola
SignTool=signtoolb

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Code]
procedure CurStepChanged(CurStep: TSetupStep);
begin
    if (CurStep = ssPostInstall) and IsTaskSelected('envPath')
    then EnvAddPath(ExpandConstant('{app}'));
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
    if CurUninstallStep = usPostUninstall
    then EnvRemovePath(ExpandConstant('{app}'));
end;

[Tasks]
Name: envPath; Description: "Add OpenZFS to PATH variable" 

[Files]
Source: "{#SourcePath}\..\README.md"; DestDir: "{app}"; Flags: ignoreversion  
Source: "{#SourcePath}\..\CODE_OF_CONDUCT.md"; DestDir: "{app}"; Flags: ignoreversion  
Source: "{#SourcePath}\..\x64\Debug\*.exe"; DestDir: "{app}"; Flags: ignoreversion sign 
Source: "{#SourcePath}\..\x64\Debug\ZFSin\ZFSin.sys"; DestDir: "{app}"; Flags: ignoreversion 
Source: "{#SourcePath}\..\x64\Debug\ZFSin\ZFSin.cat"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourcePath}\..\x64\Debug\ZFSin\ZFSin.inf"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourcePath}\..\ZFSin.cer"; DestDir: "{app}"; Flags: ignoreversion  
;Source: "{#SourcePath}\..\ZFSin\ZFSin.inf"; DestDir: "{app}"; Flags: ignoreversion  
Source: "{#SourcePath}\HowToDebug.txt"; DestDir: "{app}"; Flags: ignoreversion  
Source: "{#SourcePath}\..\ZFSin\zfs\cmd\arcstat\arcstat.pl"; DestDir: "{app}"; Flags: ignoreversion  
Source: "{#SourcePath}\..\x64\Debug\*.pdb"; DestDir: "{app}\symbols"; Flags: ignoreversion  

; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{cm:ProgramOnTheWeb,{#MyAppName}}"; Filename: "{#MyAppURL}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"

[Run]
Filename: "{app}\ZFSInstaller.exe"; Parameters: "install .\ZFSin.inf"; StatusMsg: "Installing Driver..."; Flags: runascurrentuser; 

[UninstallRun]
Filename: "{app}\ZFSInstaller.exe"; Parameters: "uninstall .\ZFSin.inf"; RunOnceId: "driver"; Flags: runascurrentuser;

