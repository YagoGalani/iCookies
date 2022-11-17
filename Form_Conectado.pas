unit Form_Conectado;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts,
  DataModule, Item;

type
  TfrmDados = class(TForm)
    TabControl1: TTabControl;
    tbiHome: TTabItem;
    tbiPedido: TTabItem;
    tbiConta: TTabItem;
    TabControl2: TTabControl;
    tbiSalgados: TTabItem;
    tbiDoces: TTabItem;
    tbiBebidas: TTabItem;
    Layout1: TLayout;
    Image1: TImage;
    Layout2: TLayout;
    lblBemVindo: TLabel;
    lblICookies: TLabel;
    Layout3: TLayout;
    lblDetalhePedido: TLabel;
    Label1: TLabel;
    lytUser: TLayout;
    Image14: TImage;
    Layout4: TLayout;
    lblEmail: TLabel;
    lblEmailC: TLabel;
    lblUserC: TLabel;
    lblUser: TLabel;
    lytSair: TLayout;
    btnSair: TButton;
    SpeedButton1: TSpeedButton;
    scrSalgados: TVertScrollBox;
    toolbarProduto: TLayout;
    rctSalgados: TRectangle;
    btnSalgados: TSpeedButton;
    rctBebidas: TRectangle;
    btnBebidas: TSpeedButton;
    rctDoces: TRectangle;
    btnDoces: TSpeedButton;
    scrDoces: TVertScrollBox;
    scrBebidas: TVertScrollBox;
    Layout6: TLayout;
    rctHome: TRectangle;
    btnHome: TSpeedButton;
    rctConta: TRectangle;
    btnConta: TSpeedButton;
    rctPedido: TRectangle;
    btnPedido: TSpeedButton;
    Line1: TLine;
    Line2: TLine;
    Line4: TLine;
    Layout5: TLayout;
    lblTotalPedido: TLabel;
    lblTotalGeral: TLabel;
    Line3: TLine;
    Line5: TLine;
    tbiFinalizado: TTabItem;
    btnFinalizar: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Layout7: TLayout;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnSalgadosClick(Sender: TObject);
    procedure btnDocesClick(Sender: TObject);
    procedure btnBebidasClick(Sender: TObject);
    procedure btnHomeClick(Sender: TObject);
    procedure btnPedidoClick(Sender: TObject);
    procedure btnContaClick(Sender: TObject);
    procedure btnFinalizarClick(Sender: TObject);
  private
    { Private declarations }
    FDM: TDm;
    FscrPedido: TVertScrollBox;

    procedure CarregarSalgados;
    procedure CarregarDoces;
    procedure CarregarBebidas;
    procedure CarregarPedidos;

    procedure RedimensionartoolbarProduto;
    procedure RedimensionartoolbarMainMenu;
  public
    { Public declarations }

    class procedure execute(AUser, AEmail: string);
  end;

implementation

uses
  Data.DB;

{$R *.fmx}

{ TfrmDados }

procedure TfrmDados.btnBebidasClick(Sender: TObject);
begin
  TabControl2.ActiveTab := tbiBebidas;
end;

procedure TfrmDados.btnContaClick(Sender: TObject);
begin
  TabControl1.ActiveTab := tbiConta;
end;

procedure TfrmDados.btnDocesClick(Sender: TObject);
begin
  TabControl2.ActiveTab := tbiDoces;
end;

procedure TfrmDados.btnFinalizarClick(Sender: TObject);
begin
  TabControl1.ActiveTab := tbiFinalizado;
end;

procedure TfrmDados.btnHomeClick(Sender: TObject);
begin
  TabControl1.ActiveTab := tbiHome;
  btnHome.IsPressed := True;
end;

procedure TfrmDados.btnPedidoClick(Sender: TObject);
begin
  TabControl1.ActiveTab := tbiPedido;
  CarregarPedidos;
end;

procedure TfrmDados.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmDados.btnSalgadosClick(Sender: TObject);
begin
  TabControl2.ActiveTab := tbiSalgados;
  btnSalgados.IsPressed := true;
end;

procedure TfrmDados.CarregarSalgados;
var
  LFrame: TfrmItem;

begin
  FDM.qrySalgados.Close;
  FDM.qrySalgados.Open;
  FDM.qrySalgados.First;
  while not FDM.qrySalgados.Eof do
  begin
    LFrame := TfrmItem.Create(nil, FDM);
    LFrame.Align := TAlignLayout.Top;

    LFrame.btnDel.Visible := False;
    LFrame.lblQtde.Visible := False;

    LFrame.btnLayout.Width := LFrame.btnAdd.Width;
    LFrame.btnLayout.Margins.Left := 0;
    LFrame.Layout2.Margins.Right := 0;
    LFrame.Layout2.Align := TAlignLayout.Right;

    LFrame.img.Bitmap.Assign( TGraphicField(FDM.qrySalgados.FieldByName('imagem')) );
    LFrame.lblCodigo.Text := FDM.qrySalgadosCodigo.AsString;
    LFrame.lblNome.Text := FDM.qrySalgadosNome.AsString;
    LFrame.lblDescricao.Text := FDM.qrySalgadosDescricao.AsString;
    LFrame.lblPreco.Text := FormatFloat('##0.00', FDM.qrySalgadosValor.AsCurrency);
    scrSalgados.AddObject(LFrame);
    FDM.qrySalgados.Next;
  end;
end;

procedure TfrmDados.CarregarDoces;
var
  LFrame: TfrmItem;

begin
  FDM.qryDoces.Close;
  FDM.qryDoces.Open;
  FDM.qryDoces.First;
  while not FDM.qryDoces.Eof do
  begin
    LFrame := TfrmItem.Create(nil, FDM);
    LFrame.Align := TAlignLayout.Top;

    LFrame.btnDel.Visible := False;
    LFrame.lblQtde.Visible := False;

    LFrame.btnLayout.Width := LFrame.btnAdd.Width;
    LFrame.btnLayout.Margins.Left := 0;
    LFrame.Layout2.Margins.Right := 0;
    LFrame.Layout2.Align := TAlignLayout.Right;

    LFrame.img.Bitmap.Assign( TGraphicField(FDM.qryDoces.FieldByName('imagem')) );
    LFrame.lblCodigo.Text := FDM.qryDocesCodigo.AsString;
    LFrame.lblNome.Text := FDM.qryDocesNome.AsString;
    LFrame.lblDescricao.Text := FDM.qryDocesDescricao.AsString;
    LFrame.lblPreco.Text := FormatFloat('##0.00', FDM.qryDocesValor.AsCurrency);
    scrDoces.AddObject(LFrame);
    FDM.qryDoces.Next;
  end;
end;

procedure TfrmDados.CarregarPedidos;                 ///////////////
var
  LFrame: TfrmItem;

begin
  if Assigned(FscrPedido) then
    FscrPedido.DisposeOf;

  FscrPedido := TVertScrollBox.Create(Self);
  FscrPedido.Parent := tbiPedido;
  FscrPedido.Align := TAlignLayout.Client;

  FDM.qryPedidosListar.Close;
  FDM.qryPedidosListar.Open;
  FDM.qryPedidosListar.First;

  while not FDM.qryPedidosListar.Eof do
  begin
    LFrame := TfrmItem.Create(nil, FDM, True);
    LFrame.Align := TAlignLayout.Top;

    LFrame.btnDel.Visible := True;
    LFrame.lblQtde.Visible := True;

    LFrame.lblQtde.Text := FDM.qryPedidosListarQtde_Produto.AsString;

    LFrame.img.Bitmap.Assign( TGraphicField(FDM.qryPedidosListar.FieldByName('imagem')) );
    LFrame.lblCodigo.Text := FDM.qryPedidosListarCodigo_Produto.AsString;
    LFrame.lblNome.Text := FDM.qryPedidosListarNome.AsString;
    LFrame.lblDescricao.Text := FDM.qryPedidosListarDescricao.AsString;
    LFrame.lblPreco.Text :=  FormatFloat('##0.00', FDM.qryPedidosListarvalor_total.AsFloat);

    FscrPedido.AddObject(LFrame);
    FDM.qryPedidosListar.Next;
  end;
end;

procedure TfrmDados.CarregarBebidas;
var
  LFrame: TfrmItem;

begin
  FDM.qryBebidas.Close;
  FDM.qryBebidas.Open;
  FDM.qryBebidas.First;
  while not FDM.qryBebidas.Eof do
  begin
    LFrame := TfrmItem.Create(nil, FDM);
    LFrame.Align := TAlignLayout.Top;

    LFrame.btnDel.Visible := False;
    LFrame.lblQtde.Visible := False;

    LFrame.btnLayout.Width := LFrame.btnAdd.Width;
    LFrame.btnLayout.Margins.Left := 0;
    LFrame.Layout2.Margins.Right := 0;
    LFrame.Layout2.Align := TAlignLayout.Right;

    LFrame.img.Bitmap.Assign( TGraphicField(FDM.qryBebidas.FieldByName('imagem')) );
    LFrame.lblCodigo.Text := FDM.qryBebidasCodigo.AsString;
    LFrame.lblNome.Text := FDM.qryBebidasNome.AsString;
    LFrame.lblDescricao.Text := FDM.qryBebidasDescricao.AsString;
    LFrame.lblPreco.Text := FormatFloat('##0.00', FDM.qryBebidasValor.AsCurrency);
    scrBebidas.AddObject(LFrame);
    FDM.qryBebidas.Next;
  end;
end;

class procedure TfrmDados.execute(AUser, AEmail: string);
var
  LForm: TfrmDados;
begin
  LForm := TfrmDados.Create(Application);
  Application.MainForm := LForm;

  LForm.lblEmailC.Text := AUser;
  LForm.lblUserC.Text := AEmail;

  LForm.Show;
end;

procedure TfrmDados.FormCreate(Sender: TObject);
begin
  BorderStyle := TFmxFormBorderStyle.None;

  FDM := TDm.Create(Self);
  FDM.LimparPedido;

  btnHomeClick(Sender);

  btnSalgadosClick(Sender);

  TabControl1.TabPosition := TTabPosition.None;
  TabControl2.TabPosition := TTabPosition.None;

  FDM.TotalGeral := lblTotalPedido;

  CarregarSalgados;
  CarregarDoces;
  CarregarBebidas;
  CarregarPedidos;

  RedimensionartoolbarProduto;
  RedimensionartoolbarMainMenu;
end;

procedure TfrmDados.RedimensionartoolbarProduto;
var
  Llenght: Extended;
begin
  Llenght := toolbarProduto.Width / 3.0;

  rctSalgados.Width := Llenght;
  rctDoces.Width := Llenght;
  rctBebidas.Width := Llenght;
end;

procedure TfrmDados.RedimensionartoolbarMainMenu;
var
  Llenght: Extended;
begin
  Llenght := toolbarProduto.Width / 3.0;

  rctHome.Width := Llenght;
  rctPedido.Width := Llenght;
  rctConta.Width := Llenght;
end;

procedure TfrmDados.SpeedButton1Click(Sender: TObject);
begin
  TabControl1.ActiveTab := tbiHome;
  TabControl2.ActiveTab := tbiSalgados;

  btnHomeClick(Sender);
end;

end.
