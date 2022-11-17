unit Item;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Objects, System.ImageList,
  FMX.ImgList, DataModule;

type
  TfrmItem = class(TFrame)
    imgList: TImageList;
    recBG: TRectangle;
    btnLayout: TLayout;
    btnAdd: TSpeedButton;
    lytDados: TLayout;
    Layout3: TLayout;
    recStatus: TRectangle;
    Layout4: TLayout;
    lblNome: TLabel;
    Layout1: TLayout;
    lblDescricao: TLabel;
    Layout2: TLayout;
    lblPreco: TLabel;
    btnDel: TSpeedButton;
    lblQtde: TLabel;
    lblCodigo: TLabel;
    img: TImage;

    procedure btnAddClick(Sender: TObject); virtual;
    procedure btnDelClick(Sender: TObject); virtual;
  private
    { Private declarations }
    FDM: TDm;
    FPedido: Boolean;

    procedure AtualizarTotal;
  public
    { Public declarations }

    constructor Create(AOwner: TComponent); reintroduce; overload;
    constructor Create(AOwner: TComponent; ADm: TDM; APedido: boolean = False); reintroduce; overload;
  end;

implementation

{$R *.fmx}

uses
  Data.DB;

{ TfrmItem }

constructor TfrmItem.Create(AOwner: TComponent; ADm: TDM; APedido: boolean = False);
begin
  inherited Create(AOwner);

  FDm := ADm;
  FPedido := APedido;
end;

procedure TfrmItem.AtualizarTotal;
begin
  if not FPedido then
    Exit;

  FDM.qryPedidosListar.Close;
  FDM.qryPedidosListar.Open;

  FDM.qryPedidosListar.Locate('codigo_produto', lblCodigo.Text, [loCaseInsensitive]);
  lblQtde.Text := FDM.qryPedidosListarQtde_Produto.AsString;
  lblPreco.Text :=  FormatFloat('##0.00', FDM.qryPedidosListarvalor_total.AsFloat);
end;

procedure TfrmItem.btnAddClick(Sender: TObject);
begin
  FDM.qryPedidosListar.Close;
  FDM.qryPedidosListar.Open;

  if FDM.qryPedidosListar.Locate('codigo_produto', lblCodigo.Text, [loCaseInsensitive]) then
    FDM.qryPedidosListar.Edit
  else
  begin
    FDM.qryPedidosListar.Insert;
    FDM.qryPedidosListarCodigo_Produto.AsInteger := lblCodigo.Text.ToInteger;
    FDM.qryPedidosListarQtde_Produto.AsInteger := 0;
  end;

  FDM.qryPedidosListarQtde_Produto.AsInteger := FDM.qryPedidosListarQtde_Produto.AsInteger + 1;
  FDM.qryPedidosListar.Post;

  AtualizarTotal;
end;

procedure TfrmItem.btnDelClick(Sender: TObject);
begin
  FDM.qryPedidosListar.Close;
  FDM.qryPedidosListar.Open;

  if FDM.qryPedidosListar.Locate('codigo_produto', lblCodigo.Text, [loCaseInsensitive]) then
  begin
    FDM.qryPedidosListar.Edit;
    FDM.qryPedidosListarQtde_Produto.AsInteger := FDM.qryPedidosListarQtde_Produto.AsInteger - 1;
    FDM.qryPedidosListar.Post;
  end;

  if FDM.qryPedidosListarQtde_Produto.AsInteger <= 0 then
  begin
    FDM.qryPedidosListar.Delete;
    Self.Visible := False;
    Exit;
  end;
  AtualizarTotal;
end;

constructor TfrmItem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

end.
