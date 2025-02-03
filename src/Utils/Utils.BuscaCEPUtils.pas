unit Utils.BuscaCEPUtils;

interface

uses FireDAC.Comp.Client, FireDAC.Stan.Param, Model.Conexoes.Interfaces, Data.DB;

const
  cCONTEM = '%%%s%%';

type
  TTypeBusca = (ttbJSON, ttbXML);

  TTypeBuscaUtils = class
    class function TypeBuscaToStr(AValue: TTypeBusca):String;
  end;

  TSequenceUtils = class
    class procedure createSequence(ANomeSequence: String; AConexao: iConexao);
    class function existeSequence(ANomeSequence: String; AConexao: iConexao): Boolean;
    class function getNextValue(ANomeSequence: String; AConexao: iConexao): Integer;
  end;

implementation

uses
  System.SysUtils;

{ TTypeBuscaUtils }

class function TTypeBuscaUtils.TypeBuscaToStr(AValue: TTypeBusca): String;
begin
  case AValue of
    ttbJSON: Result := 'json';
    ttbXML:  Result := 'xml';
  end;
end;

{ TSequenceUtils }

class procedure TSequenceUtils.createSequence(ANomeSequence: String; AConexao: iConexao);
var
  vQry: TFDQuery;
begin
  vQry := TFDQuery.Create(nil);
  try
    vQry.Connection := (AConexao.EndConexao as TFDConnection);
    vQry.SQL.Text := Format('create sequence %s', [ANomeSequence]);
    vQry.ExecSQL;
  finally
    vQry.Free;
  end;
end;

class function TSequenceUtils.existeSequence(ANomeSequence: String; AConexao: iConexao): Boolean;
var
  vQry: TFDQuery;
begin
  vQry := TFDQuery.Create(nil);
  try
    vQry.Connection := (AConexao.EndConexao as TFDConnection);
    vQry.SQL.Text := 'select relname from pg_class where upper(relname) = upper(:nomeSequence)';
    vQry.ParamByName('nomeSequence').AsString := ANomeSequence;
    vQry.Open;

    Result := not vQry.IsEmpty;

    if not Result then
    begin
      Result := True;
      createSequence(ANomeSequence, AConexao);
    end;
  finally
    vQry.Free;
  end;
end;

class function TSequenceUtils.getNextValue(ANomeSequence: String; AConexao: iConexao): Integer;
var
  vQry: TFDQuery;
begin
  Result := 0;

  if TSequenceUtils.existeSequence(ANomeSequence, AConexao) then
  begin
    vQry := TFDQuery.Create(nil);
    try
      vQry.Connection := (AConexao.EndConexao as TFDConnection);
      vQry.SQL.Text := 'select nextval(:nomeSequence) as value';
      vQry.ParamByName('nomeSequence').AsString := ANomeSequence;
      vQry.Open;

      Result := vQry.FieldByName('value').AsInteger;
    finally
      vQry.Free;
    end;
  end;
end;

end.
