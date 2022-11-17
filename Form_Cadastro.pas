unit Form_Cadastro;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.Layouts, FMX.Objects;

type
  TForm3 = class(TForm)
    Rectangle1: TRectangle;
    imgICookies: TImage;
    lytEmail: TLayout;
    imgEmail: TImage;
    edtEmail: TEdit;
    lblICookies: TLabel;
    lytPassword: TLayout;
    imgPassword: TImage;
    edtPassword: TEdit;
    lytCadastro: TLayout;
    btnCadastrar: TButton;
    lytUser: TLayout;
    imgUser: TImage;
    edtUser: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}

end.
