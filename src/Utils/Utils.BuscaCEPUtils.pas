unit Utils.BuscaCEPUtils;

interface

type
  TTypeBusca = (ttbJSON, ttbXML);

  TTypeBuscaUtils = class
    class function TypeBuscaToStr(AValue: TTypeBusca):String;
  end;

implementation

{ TTypeBuscaUtils }

class function TTypeBuscaUtils.TypeBuscaToStr(AValue: TTypeBusca): String;
begin
  case AValue of
    ttbJSON: Result := 'json';
    ttbXML:  Result := 'xml';
  end;
end;

end.
