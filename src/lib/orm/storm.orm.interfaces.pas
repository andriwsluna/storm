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
    Function _And()             : WhereSelector;
    Function _Or()              : WhereSelector;
    Function OpenParenthesis()  : WhereSelector;
    Function CloseParenthesis() : IStormWhereCompositor<WhereSelector, Executor>;
    Function Go()               : Executor;
  end;

  IStormStringWhere<WhereSelector, Executor : IInterface> = interface['{A5061AC4-1881-4D81-A50A-FAACB39316E1}']
    Function IsEqualsTo(Const Value : String) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotEqualsTo(Const Value : String) : IStormWhereCompositor<WhereSelector, Executor>;
  end;

  IStormStringnULLABLEWhere<WhereSelector, Executor : IInterface> = interface['{61AC53AD-4C1C-4C61-BB42-015D47C9585C}']
    Function IsEqualsTo(Const Value : String) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotEqualsTo(Const Value : String) : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNull : IStormWhereCompositor<WhereSelector, Executor>;
    Function IsNotNull : IStormWhereCompositor<WhereSelector, Executor>;
  end;

  IStormSelectSuccess<EntityType: IStormEntity> = interface['{9CA7139A-020A-4CB7-A1F8-39D705A78E7B}']
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

  IStormInsertSuccess<EntityType: IStormEntity> = interface['{47C1D2B5-2926-4D26-9079-E38B9C56F349}']
    Function GetInserted : EntityType;
  end;

  IStormInsertExecutor<EntityType: IStormEntity> = interface['{476BEC3B-9FD0-4882-A745-5CDF8778877E}']
    Function Execute() : TResult<IStormInsertSuccess<EntityType>,IStormExecutionFail>;
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

  IStormStringFieldInsertion<FieldInsertion> = interface['{250D96B0-B9C0-43DE-98CF-14D73DE02352}']
    Function SetValue(Const Value : String) : FieldInsertion;
  end;


  IStormORM = interface['{41151E4E-BF3A-46F5-B46B-DC836717449B}']

  end;


implementation

end.
