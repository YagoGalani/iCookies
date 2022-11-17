unit Form_Login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.Layouts, FMX.Objects, FMX.TabControl,
  System.Actions, FMX.ActnList, DataModule;

type
  TfrmLogin = class(TForm)
    TabControl1: TTabControl;
    tbiCadastro: TTabItem;
    Layout1: TLayout;
    Image2: TImage;
    dbEmail: TEdit;
    Label1: TLabel;
    Layout2: TLayout;
    Image3: TImage;
    dbPassword: TEdit;
    Layout3: TLayout;
    btnCadastrar: TButton;
    lytUser: TLayout;
    imgUser: TImage;
    dbUser: TEdit;
    ActionList1: TActionList;
    Action1: TAction;
    actCadastro: TChangeTabAction;
    actPrincipal: TChangeTabAction;
    Image4: TImage;
    tbiPrincipal: TTabItem;
    Layout4: TLayout;
    lblICookies: TLabel;
    lytEmail: TLayout;
    imgEmail: TImage;
    edtEmail: TEdit;
    lytPassword: TLayout;
    imgPassword: TImage;
    edtPassword: TEdit;
    Layout5: TLayout;
    btnLogin: TButton;
    lytCadastro: TLayout;
    lblCadastro: TLabel;
    lblCadastrar: TLabel;
    Rectangle3: TRectangle;
    imgICookies: TImage;
    procedure btnCadastrarClick(Sender: TObject);
    procedure Rectangle3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
  private
    { Private declarations }
    FDM: TDM;
    function UsuarioValido(AUser: string; APassword: string): boolean;
    function UsuarioCadastrado(AUser, AEmail: string): boolean;
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  Form_Conectado;
{$R *.fmx}

procedure TfrmLogin.btnCadastrarClick(Sender: TObject);
begin
  if dbUser.Text.IsEmpty then
    raise Exception.Create('Usuário sem informação');

  if dbEmail.Text.IsEmpty then
    raise Exception.Create('Email sem informação');

  if dbPassword.Text.IsEmpty then
    raise Exception.Create('Senha sem informação');

  if UsuarioCadastrado(dbUser.Text, dbEmail.Text) then
    raise Exception.Create('Usuário/senha já cadastrado');

  FDM.qryUser.Insert;
  FDM.qryUserUSER.AsString := dbUser.Text;
  FDM.qryUserEMAIL.AsString := dbEmail.Text;
  FDM.qryUserPASSWORD.AsString := dbPassword.Text;
  FDM.qryUser.Post;

  ShowMessage('Usuario cadastrado com sucesso!');
  actPrincipal.ExecuteTarget(Self);
  TabControl1.ActiveTab := tbiPrincipal;

end;

procedure TfrmLogin.btnLoginClick(Sender: TObject);
begin
  if not UsuarioValido(edtEmail.Text, edtPassword.Text) then
    raise Exception.Create('Usuário/senha inválido');
  TfrmDados.execute(FDM.qryUserUSER.AsString, FDM.qryUserEMAIL.AsString);
  Close;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  BorderStyle := TFmxFormBorderStyle.None;
  TabControl1.TabPosition := TTabPosition.None;
  TabControl1.ActiveTab := tbiPrincipal;

  FDM := TDm.Create(Self);
end;

procedure TfrmLogin.Rectangle3Click(Sender: TObject);
begin
  actCadastro.ExecuteTarget(Self);
end;

function TfrmLogin.UsuarioCadastrado(AUser, AEmail: string): boolean;
begin
  FDM.qryUser.Close;
  FDM.qryUser.SQL.Clear;
  FDM.qryUser.SQL.Add(_SQL_INSERT);
  FDM.qryUser.ParamByName('user').AsString := AUser;
  FDM.qryUser.ParamByName('email').AsString := AEmail;
  FDM.qryUser.Open;

  Result := False;
  if FDM.qryUser.RecordCount > 0 then
    Result := True;
end;

function TfrmLogin.UsuarioValido(AUser: string; APassword: string): boolean;
begin
  FDM.qryUser.Close;
  FDM.qryUser.SQL.Clear;
  FDM.qryUser.SQL.Add(_SQL_LOGIN);
  FDM.qryUser.ParamByName('user').AsString := AUser;
  FDM.qryUser.ParamByName('password').AsString := APassword;
  FDM.qryUser.Open;

  Result := False;
  if FDM.qryUser.RecordCount > 0 then
    Result := True;
end;

end.
