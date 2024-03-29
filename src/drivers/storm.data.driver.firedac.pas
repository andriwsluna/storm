{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N-,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN SYMBOL_EXPERIMENTAL ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN UNIT_EXPERIMENTAL ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
{$WARN OPTION_TRUNCATED ON}
{$WARN WIDECHAR_REDUCED ON}
{$WARN DUPLICATES_IGNORED ON}
{$WARN UNIT_INIT_SEQ ON}
{$WARN LOCAL_PINVOKE ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN TYPEINFO_IMPLICITLY_ADDED ON}
{$WARN RLINK_WARNING ON}
{$WARN IMPLICIT_STRING_CAST ON}
{$WARN IMPLICIT_STRING_CAST_LOSS ON}
{$WARN EXPLICIT_STRING_CAST OFF}
{$WARN EXPLICIT_STRING_CAST_LOSS OFF}
{$WARN CVT_WCHAR_TO_ACHAR ON}
{$WARN CVT_NARROWING_STRING_LOST ON}
{$WARN CVT_ACHAR_TO_WCHAR ON}
{$WARN CVT_WIDENING_STRING_LOST ON}
{$WARN NON_PORTABLE_TYPECAST ON}
{$WARN XML_WHITESPACE_NOT_ALLOWED ON}
{$WARN XML_UNKNOWN_ENTITY ON}
{$WARN XML_INVALID_NAME_START ON}
{$WARN XML_INVALID_NAME ON}
{$WARN XML_EXPECTED_CHARACTER ON}
{$WARN XML_CREF_NO_RESOLVE ON}
{$WARN XML_NO_PARM ON}
{$WARN XML_NO_MATCHING_PARM ON}
{$WARN IMMUTABLE_STRINGS OFF}
unit storm.data.driver.firedac;

interface

USES
  System.Generics.Collections,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet,
  Data.DB,
  System.Variants,
  storm.data.interfaces,
  storm.orm.interfaces;

Type
  TStormFireDACConnection = Class(TInterfacedObject, IStormSQLConnection)
  private

  protected
    FConnection : TFDConnection;
    FQuery : TFDQuery;
  public
    Constructor Create(connection : TFDConnection); Reintroduce;
    Destructor  Destroy(); Override;
  public
    Procedure SetSQL(sql : string);
    Procedure LoadParameters(parameters : TList<IQueryParameter>);
    Function  Execute() : Boolean;
    Function  Open() : Boolean;
    Function  Dataset : Tdataset;
    Function  RowsAffected: integer;
    Function  CopyDataset(target : tDataset) : TDataset;
    Function  IsEmpty : Boolean;
    Procedure Clear();
  End;

  TStormFireDacHelper = class helper for TFDConnection
  public
    Function StormDriver() : IStormSQLConnection;
  end;

implementation

USES
  FireDAC.Stan.Param;

{ TStormFireDACConnection }

procedure TStormFireDACConnection.Clear;
begin
  Self.FQuery.SQL.Clear;
  Self.FQuery.Params.Clear;
end;

function TStormFireDACConnection.CopyDataset(target: tDataset): TDataset;
begin
  Result := TFDMemTable.Create(nil);
  TFDMemTable(result).CopyDataSet(target,[coStructure,coAppend, coRestart]);
end;

constructor TStormFireDACConnection.Create(connection : TFDConnection);
begin
  inherited create();
  FConnection := connection;
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := connection;
end;

function TStormFireDACConnection.Dataset: Tdataset;
begin
  Result := CopyDataset(Fquery);
end;

destructor TStormFireDACConnection.Destroy;
begin
  FQuery.Free;
  inherited;
end;

function TStormFireDACConnection.Execute: Boolean;
begin
  FQuery.ExecSQL;
  Result := true;
end;

function TStormFireDACConnection.IsEmpty: Boolean;
begin
  Result := FQuery.IsEmpty;
end;

procedure TStormFireDACConnection.LoadParameters(parameters: TList<IQueryParameter>);
VAR
  parameter : IQueryParameter;
begin
  for parameter in Parameters do
  begin
    FQuery.Params.ParamByName(parameter.getParamName).Value := parameter.getValue;
  end;
end;

function TStormFireDACConnection.Open: Boolean;
begin
  FQuery.Open;
  Result := true;
end;

function TStormFireDACConnection.RowsAffected: integer;
begin
  Result := FQuery.RowsAffected;
end;

procedure TStormFireDACConnection.SetSQL(sql: string);
begin
  FQuery.SQL.Text := sql;
end;

{ TStormADOHelper }

function TStormFireDacHelper.StormDriver: IStormSQLConnection;
begin
   Result := TStormFireDACConnection.Create(self);
end;

end.
