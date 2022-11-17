unit Form_Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Edit, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TForm2 = class(TForm)
    Rectangle1: TRectangle;
    imgICookies: TImage;
    lytEmail: TLayout;
    lblICookies: TLabel;
    imgEmail: TImage;
    lytPassword: TLayout;
    imgPassword: TImage;
    edtPassword: TEdit;
    lytCadastro: TLayout;
    lblCadastro: TLabel;
    lblCadastrar: TLabel;
    edtEmail: TEdit;
    procedure lblCadastrarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.lblCadastrarClick(Sender: TObject);
begin

//  Form2 := TForm2.Create(Application);
//  Form2.Show;
end;

end.
