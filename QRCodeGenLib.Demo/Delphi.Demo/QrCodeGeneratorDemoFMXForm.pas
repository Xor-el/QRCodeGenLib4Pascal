unit QrCodeGeneratorDemoFMXForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.StdCtrls,
  uQrCodeGeneratorDemoFMX;

type
  TQRCodeGeneratorFMXDemoForm = class(TForm)
    mmoLogger: TMemo;
    btnRunDemos: TButton;
    procedure btnRunDemosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  QRCodeGeneratorFMXDemoForm: TQRCodeGeneratorFMXDemoForm;

implementation

{$R *.fmx}

procedure TQRCodeGeneratorFMXDemoForm.btnRunDemosClick(Sender: TObject);
begin
  TQrCodeGeneratorDemoFMX.RunAllDemos;
end;

end.
