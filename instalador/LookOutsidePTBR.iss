; Instalador da tradução PT-BR de Look Outside (Inno Setup 6)
; Copia só js\plugins\PTBR_Traducao.js e registra o plugin em js\plugins.js (com cópia de segurança).
; Compilar (dentro da pasta instalador): ISCC.exe LookOutsidePTBR.iss   -> output\Instalador Look Outside PT-BR V1.exe
; O plugin vem de ..\js\plugins\PTBR_Traducao.js (o mesmo arquivo da instalação manual).

#define AppName      "Look Outside - Tradução PT-BR"
#define AppVersion   "1.0.0"
#define TrVersion    "V1"
#define GameVersion  "2.30 (build 12)"

[Setup]
AppId={{6F1D2C4A-8B37-4E59-9A0C-5B7E2D1A9C01}
AppName={#AppName}
AppVersion={#AppVersion}
AppVerName={#AppName} {#TrVersion}
AppPublisher=Tradução PT-BR
VersionInfoVersion={#AppVersion}
VersionInfoDescription=Instalador da tradução PT-BR de Look Outside
VersionInfoProductName={#AppName}
VersionInfoProductVersion={#AppVersion}
DefaultDirName={code:GetGameDir}
AppendDefaultDirName=no
DirExistsWarning=no
UsePreviousAppDir=yes
DisableProgramGroupPage=yes
DisableWelcomePage=no
DisableDirPage=no
DisableReadyPage=no
Uninstallable=yes
UninstallFilesDir={app}\PTBR_Desinstalar
UninstallDisplayName={#AppName} {#TrVersion}
UninstallDisplayIcon={app}\PTBR_Desinstalar\icon.ico
PrivilegesRequired=lowest
SetupIconFile=icon.ico
WizardStyle=modern
WizardImageFile=wizard.bmp,wizard200.bmp
WizardSmallImageFile=small.bmp,small200.bmp
OutputDir=output
OutputBaseFilename=Instalador Look Outside PT-BR {#TrVersion}
Compression=lzma2
SolidCompression=yes

[Languages]
Name: "ptbr"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"

[Messages]
WelcomeLabel1=Tradução PT-BR de Look Outside {#TrVersion}
WelcomeLabel2=Este assistente instala a tradução para o português do Brasil.%n%nCompatível com Look Outside até o patch {#GameVersion}.%n%nSó o arquivo da tradução é copiado; o plugins.js do jogo ganha uma linha para ativá-la (com cópia de segurança).%n%nFeche o jogo antes de continuar.
SelectDirDesc=Onde está o Look Outside?
SelectDirLabel3=Pasta do Look Outside (onde fica o Game.exe). Ela foi detectada pela Steam; se o jogo estiver em outro lugar, escolha a pasta certa.
SelectDirBrowseLabel=Para continuar, clique em Avançar. Para escolher outra pasta, clique em Procurar.
FinishedHeadingLabel=Tradução instalada
FinishedLabelNoIcons=A tradução foi instalada. Abra o jogo normalmente pela Steam (se ele estiver aberto, feche e abra de novo).

[Files]
Source: "..\js\plugins\PTBR_Traducao.js"; DestDir: "{app}\js\plugins"; Flags: ignoreversion
Source: "icon.ico"; DestDir: "{app}\PTBR_Desinstalar"; Flags: ignoreversion

[Code]
const
  GAME_SUB = '\steamapps\common\Look Outside';
  ENTRY = '{"name":"PTBR_Traducao","status":true,"description":"[PT-BR] Traducao de Look Outside","parameters":{}}';
  BACKUP_EXT = '.original_ptbr_backup';

function IsGameDir(Dir: String): Boolean;
begin
  Result := FileExists(AddBackslash(Dir) + 'Game.exe') and FileExists(AddBackslash(Dir) + 'js\plugins.js');
end;

// Steam guarda as bibliotecas em steamapps\libraryfolders.vdf, linhas no formato:  "path"  "D:\\SteamLibrary"
function FindInLibraries(SteamRoot: String): String;
var
  Lines: TArrayOfString;
  I, P: Integer;
  L, V: String;
begin
  Result := '';
  if IsGameDir(SteamRoot + GAME_SUB) then begin Result := SteamRoot + GAME_SUB; exit; end;
  if not LoadStringsFromFile(SteamRoot + '\steamapps\libraryfolders.vdf', Lines) then exit;
  for I := 0 to GetArrayLength(Lines) - 1 do begin
    L := Trim(Lines[I]);
    if Pos('"path"', L) = 1 then begin
      V := Trim(Copy(L, 7, Length(L)));
      if (Length(V) > 2) and (V[1] = '"') then begin
        V := Copy(V, 2, Length(V));
        P := Pos('"', V);
        if P > 0 then V := Copy(V, 1, P - 1);
        StringChangeEx(V, '\\', '\', True);
        if IsGameDir(V + GAME_SUB) then begin Result := V + GAME_SUB; exit; end;
      end;
    end;
  end;
end;

function GetGameDir(Param: String): String;
var
  Root: String;
begin
  Result := '';
  // HKLM primeiro: guarda o caminho com as maiúsculas certas (o SteamPath do HKCU vem todo em minúsculas)
  if RegQueryStringValue(HKLM, 'SOFTWARE\WOW6432Node\Valve\Steam', 'InstallPath', Root) then
    Result := FindInLibraries(Root);
  if (Result = '') and RegQueryStringValue(HKCU, 'Software\Valve\Steam', 'SteamPath', Root) then begin
    StringChangeEx(Root, '/', '\', True);
    Result := FindInLibraries(Root);
  end;
  if (Result = '') and RegQueryStringValue(HKLM, 'SOFTWARE\Valve\Steam', 'InstallPath', Root) then
    Result := FindInLibraries(Root);
  if Result = '' then
    Result := ExpandConstant('{commonpf32}\Steam') + GAME_SUB;
end;

function CanWrite(Dir: String): Boolean;
var
  T: String;
begin
  T := AddBackslash(Dir) + 'jsptbr_teste_escrita.tmp';
  Result := SaveStringToFile(T, 'ok', False);
  if Result then DeleteFile(T);
end;

function NextButtonClick(CurPageID: Integer): Boolean;
begin
  Result := True;
  if (CurPageID = wpSelectDir) and not IsGameDir(WizardDirValue) then begin
    MsgBox('Essa pasta não parece ser a do Look Outside (não achei o Game.exe e o js\plugins.js).' + #13#10 +
      'Escolha a pasta onde o jogo está instalado.', mbError, MB_OK);
    Result := False;
  end
  else if (CurPageID = wpSelectDir) and not CanWrite(WizardDirValue) then begin
    MsgBox('O Windows não deixou gravar nessa pasta.' + #13#10 +
      'Feche o instalador e abra de novo com o botão direito > Executar como administrador.', mbError, MB_OK);
    Result := False;
  end;
end;

// Coloca a entrada do plugin depois do último objeto da lista: "    }\n];" vira "    },\n{...}\n];"
procedure RegisterPlugin();
var
  F: String;
  S: AnsiString;
  I, CloseAt, Last: Integer;
begin
  F := ExpandConstant('{app}\js\plugins.js');
  if not LoadStringFromFile(F, S) then begin
    MsgBox('Não consegui ler ' + F, mbError, MB_OK); exit;
  end;
  if Pos('"PTBR_Traducao"', S) > 0 then exit;   // já registrado (atualização)
  if not FileExists(F + BACKUP_EXT) then FileCopy(F, F + BACKUP_EXT, True);
  CloseAt := 0; Last := 0;
  for I := Length(S) downto 1 do
    if (CloseAt = 0) and (S[I] = ']') then CloseAt := I
    else if (CloseAt > 0) and (S[I] = '}') then begin Last := I; break; end;
  if Last = 0 then begin
    MsgBox('O formato do js\plugins.js é inesperado; a tradução foi copiada, mas não foi ativada.', mbError, MB_OK); exit;
  end;
  Insert(',' + #10 + ENTRY, S, Last + 1);
  if not SaveStringToFile(F, S, False) then
    MsgBox('Não consegui salvar ' + F, mbError, MB_OK);
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then RegisterPlugin();
end;

// Desinstalar: tira só a entrada da tradução (o resto do plugins.js fica como está, mesmo após atualização do jogo)
procedure UnregisterPlugin();
var
  F: String;
  S: AnsiString;
  P, A: Integer;
begin
  F := ExpandConstant('{app}\js\plugins.js');
  if not LoadStringFromFile(F, S) then exit;
  P := Pos(ENTRY, S);
  if P > 0 then begin
    A := P - 1;
    while (A > 0) and ((S[A] = #10) or (S[A] = #13) or (S[A] = ' ') or (S[A] = #9)) do A := A - 1;
    if (A > 0) and (S[A] = ',') then Delete(S, A, P + Length(ENTRY) - A)
    else Delete(S, P, Length(ENTRY));
    SaveStringToFile(F, S, False);
  end;
  DeleteFile(F + BACKUP_EXT);
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  if CurUninstallStep = usUninstall then UnregisterPlugin();
end;
