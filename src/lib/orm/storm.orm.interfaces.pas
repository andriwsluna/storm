unit storm.orm.interfaces;

interface

uses
  System.Generics.Collections,
  storm.model.interfaces,
  storm.data.interfaces,
  storm.entity.interfaces,
  DFE.Result,
  Data.DB,
  DFE.Maybe,

  System.Sysutils, System.Classes;

Type
  IStormSQLPartition = interface['{33498F09-501C-47E4-91D6-809FE2E87005}']
  end;

  IStormWherePoint<WhereSelector : IInterface> = interface['{3D1F2C75-82B2-491D-A400-75FA5BEC2FAB}']
    Function Where : WhereSelector;
  end;

  IStormWhereCompositor<WhereSelector, Executor : IInterface> = interface['{FD7EA70F-837A-44AA-9817-B266322C4085}']
    Function And_()             : WhereSelector;
    Function Or_()              : WhereSelector;
    Function OpenParenthesis()  : WhereSelector;
    Function CloseParenthesis() : IStormWhereCompositor<WhereSelector, Executor>;
    Function Go()               : Executor;
  end;

  IStormSelectSuccess<EntityType: IStormEntity> = interface['{9CA7139A-020A-4CB7-A1F8-39D705A78E7B}']
    Function IsEmpty : Boolean;
    Function GetDataset : TDataset;
    Function GetModel : IStormModel<EntityType>;
  end;

  IStormExecutionFail = interface['{88155F63-E8ED-4C11-ABC2-15DC92042821}']
    Function GetErrorMessage : String;
    Function GetExecutedCommand : String;
  end;


  IStormSelectExecutor<EntityType: IStormEntity> = interface['{15C9397A-A7E8-413D-84D1-4EC51863B3AC}']
    Function Open() : TResult<IStormSelectSuccess<EntityType>,IStormExecutionFail>;
  end;

  IStormUpdateSuccess = interface['{22F9D1B0-7820-4D14-B100-411B1BCE4FA0}']
    Function RowsUpdated : integer;
  end;

  IStormUpdateExecutor = interface['{1962F069-164A-4A65-89CD-0D2F9D29C86A}']
    Function Execute() : TResult<IStormUpdateSuccess,IStormExecutionFail>;
  end;

  IStormInsertSuccess = interface['{47C1D2B5-2926-4D26-9079-E38B9C56F349}']

  end;

  IStormInsertExecutor<EntityType: IStormEntity> = interface['{476BEC3B-9FD0-4882-A745-5CDF8778877E}']
    Function Execute() : TResult<IStormInsertSuccess,IStormExecutionFail>;
  end;

  IStormDeleteSuccess = interface['{5B081229-3376-4ACB-9502-C6EBE9913ACB}']
    Function RowsDeleted : integer;
  end;

  IStormDeleteExecutor = interface['{994BAE8F-97C8-4B85-B694-752DB239C22C}']
    Function Execute() : TResult<IStormDeleteSuccess,IStormExecutionFail>;
  end;


  IStormStringFieldAssignement<FieldAssignment> = interface['{250D96B0-B9C0-43DE-98CF-14D73DE02352}']
    Function SetTo(Const Value : String) : FieldAssignment;
  end;

  IStormStringNullableFieldAssignement<FieldAssignment> = interface['{20A57C3D-39B0-4016-BB46-5C5D75DA99E4}']
    Function SetTo(Const Value : String) : FieldAssignment;
    Function SetNull : FieldAssignment;
    Function SetThisOrNull(const value : Maybe<String>) : FieldAssignment;
  end;

  IStormIntegerFieldAssignement<FieldAssignment> = interface['{057108BF-E3D1-4D88-BB31-A0D45D6ECE8F}']
    Function SetTo(Const Value : Integer) : FieldAssignment;
  end;

  IStormIntegerNullableFieldAssignement<FieldAssignment> = interface['{022512CD-D01A-480C-AA70-CC406CD46568}']
    Function SetTo(Const Value : Integer) : FieldAssignment;
    Function SetNull : FieldAssignment;
    Function SetThisOrNull(const value : Maybe<Integer>) : FieldAssignment;
  end;

  IStormFloatFieldAssignement<FieldAssignment> = interface['{355E90B6-CAEF-48EB-99A9-4CCA886B9B53}']
    Function SetTo(Const Value : Extended) : FieldAssignment;
  end;

  IStormFloatNullableFieldAssignement<FieldAssignment> = interface['{427F2381-9361-4898-A4D4-455A40347116}']
    Function SetTo(Const Value : Extended) : FieldAssignment;
    Function SetNull : FieldAssignment;
    Function SetThisOrNull(const value : Maybe<Extended>) : FieldAssignment;
  end;

  IStormBooleanFieldAssignement<FieldAssignment> = interface['{17FF020D-2F30-4907-8862-BE1ACCF720EF}']
    Function SetTo(Const Value : Boolean) : FieldAssignment;
  end;

  IStormBooleanNullableFieldAssignement<FieldAssignment> = interface['{86745A91-5697-49CC-B899-52F896FC2720}']
    Function SetTo(Const Value : Boolean) : FieldAssignment;
    Function SetNull : FieldAssignment;
    Function SetThisOrNull(const value : Maybe<Boolean>) : FieldAssignment;
  end;

  IStormDateFieldAssignement<FieldAssignment> = interface['{79035460-A2BA-4132-A1E8-5D7EAB9E718A}']
    Function SetTo(Const Value : TDate) : FieldAssignment;
  end;

  IStormDateNullableFieldAssignement<FieldAssignment> = interface['{8E41FB9C-C80A-4DE7-92D2-C1ECCFE15DC6}']
    Function SetTo(Const Value : TDate) : FieldAssignment;
    Function SetNull : FieldAssignment;
    Function SetThisOrNull(const value : Maybe<TDate>) : FieldAssignment;
  end;

  IStormDAteTimeFieldAssignement<FieldAssignment> = interface['{E61DF6C1-F282-4E7D-AE5F-9ADAC08E7EB9}']
    Function SetTo(Const Value : TDateTime) : FieldAssignment;
  end;

  IStormDAteTimeNullableFieldAssignement<FieldAssignment> = interface['{8C15EDF4-6464-4FD3-BA3F-AE3823E1D90B}']
    Function SetTo(Const Value : TDateTime) : FieldAssignment;
    Function SetNull : FieldAssignment;
    Function SetThisOrNull(const value : Maybe<TDateTime>) : FieldAssignment;
  end;



  {--------------------------}

  IStormStringFieldInsertion<FieldInsertion> = interface['{250D96B0-B9C0-43DE-98CF-14D73DE02352}']
    Function SetValue(Const Value : String) : FieldInsertion; Overload;
  end;

  IStormStringNullableFieldInsertion<FieldInsertion> = interface['{BA05DFB9-3EDC-4C0F-8948-60E668017803}']
    Function SetValue(Const Value : String) : FieldInsertion; Overload;
    Function SetValue( Value : Maybe<String>) : FieldInsertion; Overload;
  end;

  IStormIntegerFieldInsertion<FieldInsertion> = interface['{4AAF559C-B283-4E80-9B25-C68D1F3F34D6}']
    Function SetValue(Const Value : Integer) : FieldInsertion; Overload;
  end;

  IStormIntegerNullableFieldInsertion<FieldInsertion> = interface['{388C9A1E-9B2F-4071-BBE3-7038A5560A75}']
    Function SetValue(Const Value : Integer) : FieldInsertion; Overload;
    Function SetValue( Value : Maybe<Integer>) : FieldInsertion; Overload;
  end;

  IStormFloatFieldInsertion<FieldInsertion> = interface['{94A35FD4-FEAE-414D-932C-81E08AA5F74B}']
    Function SetValue(Const Value : Extended) : FieldInsertion; Overload;
  end;

  IStormFloatNullableFieldInsertion<FieldInsertion> = interface['{B93D1B8D-763B-4C46-B950-A1FD2E34E07F}']
    Function SetValue(Const Value : Extended) : FieldInsertion; Overload;
    Function SetValue( Value : Maybe<Extended>) : FieldInsertion; Overload;
  end;

  IStormBooleanFieldInsertion<FieldInsertion> = interface['{91F3BD09-66C1-45D6-9958-8D46A7E06D82}']
    Function SetValue(Const Value : Boolean) : FieldInsertion; Overload;
  end;

  IStormBooleanNullableFieldInsertion<FieldInsertion> = interface['{3BED27E3-23BB-4BA9-B41A-FB81C450B694}']
    Function SetValue(Const Value : Boolean) : FieldInsertion; Overload;
    Function SetValue( Value : Maybe<Boolean>) : FieldInsertion; Overload;
  end;

  IStormDateFieldInsertion<FieldInsertion> = interface['{73DA1804-14B5-43D2-91D4-020F3D7B8F73}']
    Function SetValue(Const Value : TDate) : FieldInsertion; Overload;
  end;

  IStormDateNullableFieldInsertion<FieldInsertion> = interface['{12273269-3148-4231-8080-4852F100BB07}']
    Function SetValue(Const Value : TDate) : FieldInsertion; Overload;
    Function SetValue( Value : Maybe<TDate>) : FieldInsertion; Overload;
  end;

  IStormDateTimeFieldInsertion<FieldInsertion> = interface['{80F54C31-0CAF-41B8-A3E8-421CBD4E7839}']
    Function SetValue(Const Value : TDateTime) : FieldInsertion; Overload;
  end;

  IStormDateTimeNullableFieldInsertion<FieldInsertion> = interface['{525CD1CB-39D8-4F94-B338-32D2C01B4673}']
    Function SetValue(Const Value : TDateTime) : FieldInsertion; Overload;
    Function SetValue( Value : Maybe<TDateTime>) : FieldInsertion; Overload;
  end;



  IStormORM = interface['{41151E4E-BF3A-46F5-B46B-DC836717449B}']

  end;

  IStormStringWhere<WhereSelector, Executor : IInterface> = interface['{A5061AC4-1881-4D81-A50A-FAACB39316E1}']
    Function IsEqualsTo(Const Value : String) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotEqualsTo(Const Value : String) : IStormWhereCompositor<WhereSelector, Executor>;
    Function BeginsWith(Const Value : string) : IStormWhereCompositor<WhereSelector, Executor>;
    Function Contains(Const Value : string) : IStormWhereCompositor<WhereSelector, Executor>;
    Function EndsWith(Const Value : string) : IStormWhereCompositor<WhereSelector, Executor>;
    Function NotBeginsWith(Const Value : string) : IStormWhereCompositor<WhereSelector, Executor>;
    Function NotContains(Const Value : string) : IStormWhereCompositor<WhereSelector, Executor>;
    Function NotEndsWith(Const Value : string) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotEmpty() : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsEmpty() : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsIn(value : TArray<String>) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotIn(Value : TArray<String>) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsBetween(Const StartValue : String ; EndValue : String) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotBetween(Const StartValue : String ; EndValue : String) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotNull : IStormWhereCompositor<WhereSelector, Executor>;
  end;

  IStormStringNullableWhere<WhereSelector, Executor : IInterface> = interface['{61AC53AD-4C1C-4C61-BB42-015D47C9585C}']
    Function IsEqualsTo(Const Value : String) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotEqualsTo(Const Value : String) : IStormWhereCompositor<WhereSelector, Executor>;
    Function BeginsWith(Const Value : string) : IStormWhereCompositor<WhereSelector, Executor>;
    Function Contains(Const Value : string) : IStormWhereCompositor<WhereSelector, Executor>;
    Function EndsWith(Const Value : string) : IStormWhereCompositor<WhereSelector, Executor>;
    Function NotBeginsWith(Const Value : string) : IStormWhereCompositor<WhereSelector, Executor>;
    Function NotContains(Const Value : string) : IStormWhereCompositor<WhereSelector, Executor>;
    Function NotEndsWith(Const Value : string) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotEmpty() : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsEmpty() : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsIn(value : TArray<String>) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotIn(Value : TArray<String>) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsBetween(Const StartValue : String ; EndValue : String) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotBetween(Const StartValue : String ; EndValue : String) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNull : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotNull : IStormWhereCompositor<WhereSelector, Executor>;
  end;


  IStormIntegerWhere<WhereSelector, Executor : IInterface> = interface['{9DFF9FB7-EF96-4F9B-B9B5-CD31B8071D81}']
    Function IsEqualsTo(Const Value : Integer) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotEqualsTo(Const Value : Integer) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsIn(value : TArray<Integer>) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotIn(Value : TArray<Integer>) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsBetween(Const StartValue : Integer ; EndValue : Integer) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotBetween(Const StartValue : Integer ; EndValue : Integer) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsGreaterThan(Value : Integer) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsGreaterOrEqualTo(Value : Integer) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsLessThan(Value : Integer) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsLessOrEqualTo(Value : Integer) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotNull : IStormWhereCompositor<WhereSelector, Executor>;
  end;

  IStormIntegerNullableWhere<WhereSelector, Executor : IInterface> = interface['{9253EFE7-2BDC-4BF4-B4C2-6F2EF46FC497}']
    Function IsEqualsTo(Const Value : Integer) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotEqualsTo(Const Value : Integer) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsIn(value : TArray<Integer>) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotIn(Value : TArray<Integer>) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsBetween(Const StartValue : Integer ; EndValue : Integer) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotBetween(Const StartValue : Integer ; EndValue : Integer) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsGreaterThan(Value : Integer) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsGreaterOrEqualTo(Value : Integer) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsLessThan(Value : Integer) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsLessOrEqualTo(Value : Integer) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNull : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotNull : IStormWhereCompositor<WhereSelector, Executor>;
  end;

  IStormFloatWhere<WhereSelector, Executor : IInterface> = interface['{0B4EC7B4-1B05-446C-9FC3-4B0D6CFA5EB2}']
    Function IsEqualsTo(Const Value : Extended) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotEqualsTo(Const Value : Extended) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsIn(value : TArray<Extended>) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotIn(Value : TArray<Extended>) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsBetween(Const StartValue : Extended ; EndValue : Extended) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotBetween(Const StartValue : Extended ; EndValue : Extended) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsGreaterThan(Value : Extended) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsGreaterOrEqualTo(Value : Extended) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsLessThan(Value : Extended) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsLessOrEqualTo(Value : Extended) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotNull : IStormWhereCompositor<WhereSelector, Executor>;
  end;

  IStormFloatNullableWhere<WhereSelector, Executor : IInterface> = interface['{14545C41-1AA9-4386-891B-358BDF27D1B3}']
    Function IsEqualsTo(Const Value : Extended) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotEqualsTo(Const Value : Extended) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsIn(value : TArray<Extended>) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotIn(Value : TArray<Extended>) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsBetween(Const StartValue : Extended ; EndValue : Extended) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotBetween(Const StartValue : Extended ; EndValue : Extended) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsGreaterThan(Value : Extended) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsGreaterOrEqualTo(Value : Extended) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsLessThan(Value : Extended) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsLessOrEqualTo(Value : Extended) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNull : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotNull : IStormWhereCompositor<WhereSelector, Executor>;
  end;

  IStormBooleanWhere<WhereSelector, Executor : IInterface> = interface['{9DFF9FB7-EF96-4F9B-B9B5-CD31B8071D81}']
    Function IsTrue : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsFalse : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotNull : IStormWhereCompositor<WhereSelector, Executor>;
  end;

  IStormBooleanNullableWhere<WhereSelector, Executor : IInterface> = interface['{9253EFE7-2BDC-4BF4-B4C2-6F2EF46FC497}']
    Function IsTrue : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsFalse : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNull : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotNull : IStormWhereCompositor<WhereSelector, Executor>;
  end;

  IStormDateWhere<WhereSelector, Executor : IInterface> = interface['{CBD6948C-FA50-4C4E-9708-549D7438DEA7}']
    Function IsEqualsTo(Const Value : TDate) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotEqualsTo(Const Value : TDate) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsIn(value : TArray<TDate>) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotIn(Value : TArray<TDate>) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsBetween(Const StartValue : TDate ; EndValue : TDate) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotBetween(Const StartValue : TDate ; EndValue : TDate) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsGreaterThan(Value : TDate) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsGreaterOrEqualTo(Value : TDate) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsLessThan(Value : TDate) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsLessOrEqualTo(Value : TDate) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotNull : IStormWhereCompositor<WhereSelector, Executor>;
  end;

  IStormDateNullableWhere<WhereSelector, Executor : IInterface> = interface['{762B1392-CA50-4704-B8D3-9F8347C69CDB}']
    Function IsEqualsTo(Const Value : TDate) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotEqualsTo(Const Value : TDate) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsIn(value : TArray<TDate>) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotIn(Value : TArray<TDate>) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsBetween(Const StartValue : TDate ; EndValue : TDate) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotBetween(Const StartValue : TDate ; EndValue : TDate) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsGreaterThan(Value : TDate) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsGreaterOrEqualTo(Value : TDate) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsLessThan(Value : TDate) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsLessOrEqualTo(Value : TDate) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNull : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotNull : IStormWhereCompositor<WhereSelector, Executor>;
  end;

  IStormDateTimeWhere<WhereSelector, Executor : IInterface> = interface['{59CBB9EB-E9AA-43C7-8B30-FA5AD5796760}']
    Function IsEqualsTo(Const Value : TDateTime) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotEqualsTo(Const Value : TDateTime) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsIn(value : TArray<TDateTime>) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotIn(Value : TArray<TDateTime>) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsBetween(Const StartValue : TDateTime ; EndValue : TDateTime) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotBetween(Const StartValue : TDateTime ; EndValue : TDateTime) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsGreaterThan(Value : TDateTime) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsGreaterOrEqualTo(Value : TDateTime) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsLessThan(Value : TDateTime) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsLessOrEqualTo(Value : TDateTime) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotNull : IStormWhereCompositor<WhereSelector, Executor>;
  end;

  IStormDateTimeNullableWhere<WhereSelector, Executor : IInterface> = interface['{4A6D873D-CAD6-49BE-BC66-231C6494ED59}']
    Function IsEqualsTo(Const Value : TDateTime) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotEqualsTo(Const Value : TDateTime) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsIn(value : TArray<TDateTime>) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotIn(Value : TArray<TDateTime>) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsBetween(Const StartValue : TDateTime ; EndValue : TDateTime) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotBetween(Const StartValue : TDateTime ; EndValue : TDateTime) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsGreaterThan(Value : TDateTime) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsGreaterOrEqualTo(Value : TDateTime) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsLessThan(Value : TDateTime) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsLessOrEqualTo(Value : TDateTime) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNull : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotNull : IStormWhereCompositor<WhereSelector, Executor>;
  end;




implementation

end.
