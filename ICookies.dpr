program ICookies;

uses
  System.StartUpCopy,
  FMX.Forms,
  Form_Conectado in 'Form_Conectado.pas' {frmDados},
  Form_Login in 'Form_Login.pas' {frmLogin},
  DataModule in 'DataModule.pas' {dm: TDataModule},
  Item in 'Item.pas' {frmItem: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
