unit storm.generator.utils;

interface

USES
  System.StrUtils,
  System.Sysutils;

function Capitalize (const Text: string): string;
Function CompleteWithBlanks(const Text: string ; TargetLen : Integer) : String;


implementation

Function CompleteWithBlanks(const Text: string ; TargetLen : Integer) : String;
begin
  Result := Text + StringOfChar(' ',TargetLen - Length(Text)-1);
end;

function Capitalize (const Text: string): string;
var
   c : char;
   s : string;
   Upper : Boolean;
begin
 if Text<>'' then
    begin
      s := '';
      Upper := True;

      for c in Text do
      begin
        if (c = ' ') or (c = '_') then
        begin
          Upper := True;
        end
        else
        if Upper then
        begin
          s := s + UpperCase(c);
          Upper := False;
        end
        else
        begin
          s := s + LowerCase(c);
        end;

      end;
    end;
 result := s;
end;

end.
