unit Unit1;

interface

uses
  ADR.Android.FileProvider,
  {$IFDEF ANDROID}
    Androidapi.JNI.JavaTypes,
    Androidapi.JNI.Net,
    Androidapi.Helpers,
  {$ENDIF}

  FMX.Controls,
  FMX.Controls.Presentation,
  FMX.Dialogs,
  FMX.Forms,
  FMX.Graphics,
  FMX.Memo,
  FMX.Memo.Types,
  FMX.ScrollBox,
  FMX.StdCtrls,
  FMX.Types,

  System.Classes,
  System.SysUtils,
  System.IOUtils,
  System.Types,
  System.UITypes,
  System.Variants;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
const
  LFile = 'printid.pdf'; //File attached into APK in Project > Deployment
var
  LURI        : JNet_Uri;
begin
  LURI := GetFileUri(TPath.GetDocumentsPath + PathDelim + LFile);
  Memo1.Lines.Clear;
  Memo1.Lines.Add(Format('Authority: %s', [JStringToString(LURI.getAuthority)]));
  Memo1.Lines.Add(Format('Host: %s', [JStringToString(LURI.getHost)]));
  Memo1.Lines.Add(Format('Last Path Segment: %s', [JStringToString(LURI.getLastPathSegment)]));
end;

end.
