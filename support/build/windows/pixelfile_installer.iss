#ifndef BuildDir
  #error "BuildDir must be provided by the build workflow."
#endif
#ifndef InstallerDir
  #error "InstallerDir must be provided by the build workflow."
#endif
#ifndef AppIcon
  #error "AppIcon must be provided by the build workflow."
#endif
#ifndef RuntimeDir
  #error "RuntimeDir must be provided by the build workflow."
#endif

#define MyAppName "PixelFile"
#define MyAppVersion GetFileVersion(BuildDir + "\localsend_app.exe")
#define MyAppPublisher "济南像素引擎人工智能有限公司"
#define MyAppURL "https://www.pixelfuel.cn"
#define MyAppExeName "localsend_app.exe"
#define MyAppMsixHelper "localsend_msix_helper.msix"

[Setup]
; Keep the existing installer identity so upgrades remain compatible.
AppId={{00809252-FEC6-448E-83B4-E7F55AE7E47D}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\PixelFile
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
PrivilegesRequiredOverridesAllowed=dialog
OutputDir={#InstallerDir}
OutputBaseFilename=PixelFile-Setup
SetupIconFile={#AppIcon}
UninstallDisplayIcon={app}\{#MyAppExeName}
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
ArchitecturesInstallIn64BitMode=x64compatible
ArchitecturesAllowed=x64compatible

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "chinesesimplified"; MessagesFile: "inno\ChineseSimplified.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "{#BuildDir}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#RuntimeDir}\*.dll"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "powershell.exe"; Parameters: "-NoProfile -ExecutionPolicy Bypass -Command Add-AppxPackage .\{#MyAppMsixHelper} -ExternalLocation $(Get-Location)"; WorkingDir: "{app}"; Flags: runhidden waituntilterminated
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[UninstallRun]
Filename: "powershell.exe"; Parameters: "-NoProfile -ExecutionPolicy Bypass -Command Remove-AppxPackage $(Get-AppxPackage com.flutter.localsendapp)"; WorkingDir: "{app}"; Flags: runhidden waituntilterminated
