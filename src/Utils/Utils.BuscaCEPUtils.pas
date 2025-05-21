unit Utils.BuscaCEPUtils;

interface

uses FireDAC.Comp.Client, FireDAC.Stan.Param, Model.Conexoes.Interfaces, Data.DB,
     Utils.Types;

const
  cCONTEM = '%%%s%%';

type
  TSequenceUtils = class
    class procedure createSequence(ANomeSequence: String; AConexao: iConexao);
    class function existeSequence(ANomeSequence: String; AConexao: iConexao): Boolean;
    class function getNextValue(ANomeSequence: String; AConexao: iConexao): Integer;
  end;

  TValidacoes = class
    class procedure ValidarTamanhoMinimoString(AValue, ANome: String; ATamanhoMinimo: Integer);
    class procedure ValidarCEP(ACEP: String);
    class procedure ValidarEndereco(AUf, ACidade, AEndereco: String);
  end;

implementation

uses
  System.SysUtils;

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

{ TValidacoes }

class procedure TValidacoes.ValidarCEP(ACEP: String);
begin
  if ACEP.Trim.Length <> 8 then
  begin
    raise Exception.Create('O CEP informado é inválido');
  end;
end;

class procedure TValidacoes.ValidarEndereco(AUf, ACidade, AEndereco: String);
begin
  ValidarTamanhoMinimoString(AUf, 'UF', 2);
  ValidarTamanhoMinimoString(ACidade, 'Cidade', 3);
  ValidarTamanhoMinimoString(AEndereco, 'Endereço', 3);
end;

class procedure TValidacoes.ValidarTamanhoMinimoString(AValue, ANome: String;
  ATamanhoMinimo: Integer);
begin
  if AValue.Trim.Length < ATamanhoMinimo then
  begin
    raise Exception.CreateFmt('Tamanho minímo para o campo ''%s'' é %d. Atual %d. Por Favor Verifique!',
                              [ANome, ATamanhoMinimo, AValue.Trim.Length]);
  end;
end;

end.

