unit ADR.Android.FileProvider;

interface

uses
  {$IFDEF ANDROID}
    , Androidapi.JNI.GraphicsContentViewText
    , Androidapi.JNI.provider
    , Androidapi.JNI.JavaTypes
    , Androidapi.JNI.Net
    , Androidapi.JNI.App
    , AndroidAPI.jNI.OS
    , Androidapi.JNIBridge
    , FMX.Helpers.Android
    , IdUri
    , Androidapi.Helpers
    , FMX.Platform.Android;
  {$ENDIF}

type
{$IFDEF ANDROID}
  JFileProvider = interface;
  JFileProviderClass = interface(JContentProviderClass)
    ['{33A87969-5731-4791-90F6-3AD22F2BB822}']
    {class} function getUriForFile(context: JContext; authority: JString; _file: JFile): Jnet_Uri; cdecl;
    {class} function init: JFileProvider; cdecl;
  end;

  [JavaSignature('android/support/v4/content/FileProvider')]
  JFileProvider = interface(JContentProvider)
    ['{12F5DD38-A3CE-4D2E-9F68-24933C9D221B}']
    procedure attachInfo(context: JContext; info: JProviderInfo); cdecl;
    function delete(uri: Jnet_Uri; selection: JString; selectionArgs: TJavaObjectArray<JString>): Integer; cdecl;
    function getType(uri: Jnet_Uri): JString; cdecl;
    function insert(uri: Jnet_Uri; values: JContentValues): Jnet_Uri; cdecl;
    function onCreate: Boolean; cdecl;
    function openFile(uri: Jnet_Uri; mode: JString): JParcelFileDescriptor; cdecl;
    function query(uri: Jnet_Uri; projection: TJavaObjectArray<JString>; selection: JString; selectionArgs: TJavaObjectArray<JString>;
      sortOrder: JString): JCursor; cdecl;
    function update(uri: Jnet_Uri; values: JContentValues; selection: JString; selectionArgs: TJavaObjectArray<JString>): Integer; cdecl;
  end;
  TJFileProvider = class(TJavaGenericImport<JFileProviderClass, JFileProvider>) end;
{$ENDIF}

  function  GetFileUri(AFile: String): JNet_Uri;

implementation

{$IFDEF ANDROID}
function GetFileUri(AFile: String): JNet_Uri;
var
  FileAtt      : JFile;
  Auth         : JString;
  PackageName  : String;
begin
  PackageName := JStringToString(SharedActivityContext.getPackageName);
  FileAtt     := TJFile.JavaClass.init(StringToJString(AFile));
  Auth        := StringToJString(Packagename + '.fileprovider');
  Result      := TJFileProvider.JavaClass.getUriForFile(TAndroidHelper.Context, Auth, FileAtt);
end;
{$ENDIF}
end.
