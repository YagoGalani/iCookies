unit DataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.FMXUI.Wait, FireDAC.Comp.UI, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FMX.Types, FMX.Controls, FMX.StdCtrls;

type
  Tdm = class(TDataModule)
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDConn: TFDConnection;
    qryUser: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    qrySalgados: TFDQuery;
    qryUserID_USER: TIntegerField;
    qryUserUSER: TStringField;
    qryUserEMAIL: TStringField;
    qryUserPASSWORD: TStringField;
    qrySalgadosCodigo: TIntegerField;
    qrySalgadosDescricao: TStringField;
    qrySalgadosValor: TBCDField;
    qrySalgadosTipo: TIntegerField;
    qrySalgadosImagem: TBlobField;
    qryDoces: TFDQuery;
    qryBebidas: TFDQuery;
    qryDocesCodigo: TIntegerField;
    qryDocesDescricao: TStringField;
    qryDocesValor: TBCDField;
    qryDocesTipo: TIntegerField;
    qryDocesImagem: TBlobField;
    qryBebidasCodigo: TIntegerField;
    qryBebidasDescricao: TStringField;
    qryBebidasValor: TBCDField;
    qryBebidasTipo: TIntegerField;
    qryBebidasImagem: TBlobField;
    qrySalgadosNome: TStringField;
    qryDocesNome: TStringField;
    qryBebidasNome: TStringField;
    StyleBook1: TStyleBook;
    qryPedidosListar: TFDQuery;
    qryPedidosListarCodigo_Produto: TIntegerField;
    qryPedidosListarNome: TStringField;
    qryPedidosListarDescricao: TStringField;
    qryPedidosListarValor: TBCDField;
    qryPedidosListarQtde_Produto: TIntegerField;
    qryPedidosListarvalor_total: TFMTBCDField;
    qryCalcularTotal: TFDQuery;
    qryCalcularTotaltotal_geral: TFloatField;
    qryPedidosListarImagem: TBlobField;
    procedure qryPedidosListarCalcFields(DataSet: TDataSet);
    procedure qryPedidosListarAfterPost(DataSet: TDataSet);
    procedure qryPedidosListarAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    FTotalGeral: TLabel;
    procedure CalcularTotal;
  public
    { Public declarations }
    property TotalGeral: TLabel read FTotalGeral write FTotalGeral;
    procedure LimparPedido;
  end;

const
  _SQL_LOGIN = 'select  ' +
               '   *  ' +
               'from  ' +
               '   tab_user ' +
               'where  ' +
               '   ( (user = :user) or (email = :user)) ' +
               '   and (password = :password) ';

  _SQL_INSERT = 'select ' +
               '   *  ' +
               'from  ' +
               '   tab_user ' +
               'where  ' +
               '   (user = :user) or (email = :email)';

var
  dm: Tdm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure Tdm.CalcularTotal;
begin
  qryCalcularTotal.Close;
  qryCalcularTotal.Open;
  TotalGeral.Text := FormatFloat('##0.00', qryCalcularTotaltotal_geral.AsCurrency);
end;

procedure Tdm.LimparPedido;
begin
  FDConn.ExecSQL('delete from tab_pedidos');
end;

procedure Tdm.qryPedidosListarAfterPost(DataSet: TDataSet);
begin
  CalcularTotal;
end;

procedure Tdm.qryPedidosListarAfterScroll(DataSet: TDataSet);
begin
  CalcularTotal;
end;

procedure Tdm.qryPedidosListarCalcFields(DataSet: TDataSet);
begin
  qryPedidosListarvalor_total.AsCurrency := qryPedidosListarQtde_Produto.AsInteger * qryPedidosListarValor.AsCurrency;
end;

end.
